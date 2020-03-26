# Design

Most or all of the code changes should be in the [`Axes.errorbar()`](https://github.com/matplotlib/matplotlib/blob/master/lib/matplotlib/axes/_axes.py#L3086) method. As mentioned previously, there has been discussion on whether or not an infinite range of error even makes sense. Currently it is treated the same as a range of error: `nan`. The question would be how to distinguish these two values.

We would need to change how we handle the inputs `xerr`, and `yerr`, to account for the value of `inf`.

## Tracing ##

To get an idea of how this change would need to fit in, it would be helpful to trace the `Axes.errorbar()` method. As mentioned previously, it takes parameters for the data points `x`,`y`, and the error ranges `xerr`,`yerr`. First, these parameters are turned into iterables, if they are not already. For example `x='7'` is converted to `x=['7']`. And if the error ranges are specified as, for example, `xerr='3'`, and there are 4 data points, then it is converted to `x=['3','3','3','3']`. 

In lines 3248 to 3297, the styles are applied for the plot, including the data line, and the errorbars (with barlines and caplines), with their associated markers. 

`xololims`, `xuplims`, `uplims`, and `lolims` are also converted into iterables for compatibility when processing data points.

In line 3322, there is a method `extract_err(err, data)`. As mentioned previously, this method parses the iterable `err` and adds/subtracts them to the data points `data`. It checks that `err` (which would either be `yerr` or `xerr`), is in the proper format. Recall that they must either be a `scalar`, or a `1D`/`(2,n)` array-like. If the format of `err` is valid, then the method proceeds to add these error ranges to each data point. In lines 3354 and 3355, it does this using list comprehension.

```
low = [v - e for v, e in zip(data, a)]
high = [v + e for v, e in zip(data, b)]
```

Two arrays `low, high` are returned. `low` holds the lower error bounds, while `high` holds the upper error bounds.

In line 3358, the x-error range is handled. The left and right error bounds are extracted using the `extract_err()` method. Recall `xlolims` and `xuplims` which checks if there are any data points that don't have such limits. If so, then we draw normal error bars for those data points. The errorbars for these points are defined in this block, and appended to the list of `barlines` and `caplines`.

If there are any data points for which we only want to draw the lower x-limits (left), then `xlolims` would be `True` for that point. The errorbar is drawn only for the left side of the data point, and a special caret symbol on the right.

Symmetrically, if `xuplims` is `True` for some point, then the errorbar is draw only for the right side of the data point. A special caret symbol is drawn on the left. 

In line 3407, the y-error range is handled. This works similarly to how the x-error range is handled, except that it deals with upper and lower limits (`lolims` and `uplims`).

Finally, an `ErrorbarContainer` instance is created, to house the `data_line`, `caplines`, and `barcols`. We also specify if the errors were for the y-direction, the x-direction, or both.

## Discussion of Changes ##

Previously we described two options for displaying an `inf` errorbar.

The **first option** is to display an errorbar extending the frame size, to symbolize an infinite error range. The **second option** is to display a special marker on the data point, to symbolize the special value of `inf`.

It seems that there is currently no functionality in matplotlib that extends a graph beyond the framesize. Changing this behaviour seems overkill for an edge case such as an infinite errorbar. Choosing not to extend the errorbar beyond the frame size would reduce the API changes needed. Normally, the range of the x and y axes are defined based on the given plot data. Every data point is contained within the frame, including the range of errorbars.

The most we should do is plot an errorbar that extends to the upper and lower bounds of the plot data. We could accompany this with a special symbol, and omit the caplines (if any), indicating that unbounded error. 

However, we also thought that simply having a special marker for the `inf` errorbar would be a cleaner (albeit less intuitive) representation. Thus, we think this choice should be deferred to the user. Within the `Axes.errorbar()` method, we could allow the user to choose how to represent an `inf` error. 

In addition to the proposed changes, a similar approach can be applied to `nan` errorbars. We can allow users to choose a symbol representation of a `nan` errorbar. Meanwhile, we can make these changes optional to the user, by maintaining the default representations of both `inf` and `nan` errorbars.

Note that there are **no architectural changes** involved in implementing this feature. However, we have made comments on how `Axes.errorbar()` interacts with other components.

### [Architecture](./architecture.md) ###

There may be an additional parameter and a helper function in `Axes.errorbar()`, so this would count as an API change.

## Planned Implementation ##

Here we will write in more detail how we plan to implement the changes described in **Design Choices**. There, we detailed 4 changes we were going to make.

1. Create a special symbol in the case of a `nan` error range.
2. Allow the user to specify how the `inf` and `nan` error range is represented.
3. Create a special symbol in the case of an `inf` error range.
4. Handle the case of an `inf` error range by drawing an errorbar that extends to the upper and lower limits of the axes.

We will go through each of these changes and how they would be implemented, below. Note that all of these changes are to be made in the `Axes.errorbar()` method.

### Special symbol for `nan` errorbar ###

We also need to add a case to when handling `if xerr is not None` in [line 3366](https://github.com/matplotlib/matplotlib/blob/master/lib/matplotlib/axes/_axes.py#L3366). 

For all data points with an errorbar of `nan`, then we add a special type of marker for that errorbar. We handle similarly for `if yerr is not None` in [line 3415](https://github.com/matplotlib/matplotlib/blob/master/lib/matplotlib/axes/_axes.py#L3415). 

### Handling user choice of representing `inf` and `nan` errorbar ###

This change would be in the `Axes.errorbar()` method. Firstly, we need to be prepared to handle an extra parameter, say `inf_repr`. This extra parameter is a `str` describing how the user wants the `inf` errorbar to be represented. For now, we only handle three possible values: `None`, `'bar'` or `'symbol'`. We would need to add documentation on the usage of `inf_repr` in the docstring. Depending on the value of `inf_repr`, we change the representation of the errorbar, as described below. To allow for backwards compatibility, if `inf_repr=None`, or `nan_repr=None`, then we maintain the same representation as now.   

### Special symbol for `inf` errorbar ###

This change would be similar to handling the special symbol for a `nan` errorbar. This change would also be in the private method `Axes.errorbar.extract_err(data, err)`. Similarly to the above, we add another case checking for the value of `inf`.

Note that we only choose this representation if `inf_repr='symbol'`. As with the symbol for `nan`, we add a special type of marker for all data points with an errorbar of `inf` in the case of [`xerr`](https://github.com/matplotlib/matplotlib/blob/master/lib/matplotlib/axes/_axes.py#L3366), and [`yerr`](https://github.com/matplotlib/matplotlib/blob/master/lib/matplotlib/axes/_axes.py#L3415) existing.

### Special long errorbar for `inf` ###

This change would also be in the private method `Axes.errorbar.extract_err(data, err)`. We only choose this representation if `inf_repr='bar'`. To get an errorbar that extends to the lower and upper limits of the axes, we would need to calculate the upper and lower limits of `Axes`, and add a line that spans those values.

Then, when handling the [`xerr`](https://github.com/matplotlib/matplotlib/blob/master/lib/matplotlib/axes/_axes.py#L3366) and [`yerr`](https://github.com/matplotlib/matplotlib/blob/master/lib/matplotlib/axes/_axes.py#L3415) we provide a special errorbar extending for this range. We will omit the capline (if needed) to represent an unbounded error.
We need to handle the `inf` case for all three sub-cases.

```
if noxlims.any() or len(noxlims) == 0:
```
```
if xlolims.any():
```
and
```
if xuplims.any():
```

## Time Estimate

Implementing the above steps, if all goes well, should take about 16-24 hours. We are taking into account any subtleties we have missed during documentation and design. Testing the feature and documenting it (i.e. adding to docstring) should take about 8-16 hours.