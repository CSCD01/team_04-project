# Design

Most or all of the code changes should be in the [`Axes.errorbar()`](https://github.com/matplotlib/matplotlib/blob/master/lib/matplotlib/axes/_axes.py#L3086) method. As mentioned previously, there has been discussion on whether or not an infinite range of error even makes sense. Currently it is treated the same as a range of error: `nan`. The question would be how to distinguish these two values.

We would need to change how we handle the inputs `xerr`, and `yerr`, to account for the value of `inf`.

## Tracing ##

To get an idea of how this change would need to fit in, it would be helpful to trace the `Axes.errorbar()` method. As mentioned previously, it takes parameters for the data points `x`,`y`, and the error ranges `xerr`,`yerr`. First, these parameters are turned into iterables, if they are not already. If `x='7'`, then it is converted to `x=['7']`. And if the error ranges are specified as, for example, `xerr='3'`, and there are 4 data points, then it is converted to `x=['3','3','3']`. 

In lines 3248 to 3297, the styles are applied for the plot, including the data line, and the errorbars (with barlines and caplines), and their associated markers. 

`xololims`, `xuplims`, `uplims`, and `lolims` are also converted into iterables so that they are compatible when processing data points.

In line 3322, there is a method `extract_err(err, data)`. As mentioned previously, this method parses the iterable `err` and adds/subtracts them to the data points `data`. It checks that `err` (which would either be `yerr` or `xerr`), is in the proper format. Recall that they must either be a `scalar`, or a `1D`/`(2,n)` array-like. If the format of `err` is valid, then it proceeds to add these error ranges to each data point. In lines 3354 and 3355, it does this using list comprehension.

```
low = [v - e for v, e in zip(data, a)]
high = [v + e for v, e in zip(data, b)]
```

Two arrays `low, high` are returned. `low` holds the lower error bounds, while `high` holds the upper error bounds.

In line 3358, the x-error range is handled. The left and right error bounds are extracted using the `extract_err()` method. Recall `xlolims` and `xuplims`. It checks if there are any data points that don't have such limits. If so, then we draw normal error bars for those data points. The errorbars for these points are defined in this block, and appended to the list of `barlines` and `caplines`.

If there are any data points for which we only want to draw the lower x-limits (left), then `xlolims` would be `True` for that point. The errorbar is drawn only for the left side of the data point, and a special caret symbol on the right.

Symmetrically, if `xuplims` is `True` for some point, then the errorbar is draw only for the right side of the data point. A special caret symbol is drawn on the left. 

In line 3407, the y-error range is handled. This works similarly to how the x-error range is handled, except that it deals with upper and lower limits (`lolims` and `uplims`).

Finally, an `ErrorbarContainer` instance is created, to house the `data_line`, `caplines`, and `barcols`. We also specify if the errors were for the y-direction, the x-direction, or both.

## Changes ##

Previously we described two options for displaying an `inf` errorbar.

The **first option** is to display an errorbar extending the frame size, to symbolize an infinite error range. The **second option** is to display a special marker on the data point, to symbolize the special value of `inf`.

It seems that there is currently no functionality in matplotlib that extends a graph beyond the framesize. Changing this behaviour seems overkill for an edge case such as an infinite range of error. Choosing not to extend the errorbar beyond the frame size would greatly reduce the API changes needed. Normally, the axes scales defines the range of the x and y axes depending on the plot data given. This is so that every data point is contained within the frame, including the range of errorbars.

The most we should do, along the same lines, would be to plot an errorbar that extends to the upper and lower bounds of the plot data. We could accompany this with a special symbol, and omit the caplines (if any), indicating that unbounded error. 

However, we also thought that simply having a special marker for the `inf` errorbar would be a cleaner (albeit less intuitive) representation. Thus, we think this choice should be deferred to the user. Within the `Axes.errorbar()` method, we could allow the user to choose how to represent an `inf` error. 

In addition to the changes proposed, a similar approach to the second option can be taken for the error `nan`. A special marker or symbol can be displayed on the data point to explicitly indicate the error range. In that case, the user could add special markers for both a `nan` and `inf` error for a better representation. Meanwhile, we can make these changes optional to the user, by maintaining the default representations of these errorbars.

Note that there are no architectural changes involved in implementing this feature. There may be an additional parameter and a helper function in `Axes.errorbar()`, so this would count as an API change.