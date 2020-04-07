# Implementation

In **Design Choices**, we detailed that our feature has 4 main parts. 

1. Allow the user to specify how the `inf` and `nan` errorbar is represented.
2. Create a special symbol for the `nan` errorbar.
3. Create a special symbol for the `inf` errorbar.
4. Handle the case of the `inf` errorbar by drawing an errorbar that extends to the upper and lower limits of the axes frame.

## Code Changes ##

The changes were implemented in [`axes.py`](). 

We introduced two parameters in the signature of `Axes.errorbar()`: `nan_repr`, and `inf_repr`. 

- `nan_repr`: a string that describes how a `nan` errorbar is displayed. It takes a default value of `None`. Below are the possible values.
    - `None`: no errorbar is displayed.
    - `'symbol'`: a `nan` symbol is displayed.
- `inf_repr`: a string that describes how an `inf` errorbar is displayed. It takes a default value of `None`. Below are the possible values.
    - `None`: no errorbar is displayed.
    - `'symbol'`: an `inf` symbol marker is displayed.
    - `'bar'`: an errorbar extending to the upper and lower limits of the axes is displayed.

We needed to add special cases under `if xerr is not None`. There were three cases.

```
if noxlims.any() or len(noxlims) == 0
```
```
if xlolims.any()
```
```
if xuplims.any()
```

Similarly under `if yerr is not None`, there were three cases.

```
if noylims.any() or len(noylims) == 0
```
```
if lolims.any()
```
```
if uplims.any()
```

Each of the above six cases would need to accommodate three special considerations.
- `nan_repr='symbol'`
- `inf_repr='symbol'`
- `inf_repr='bar'`

### `nan_inf_lims()` ###

To prevent duplication of code, we defined a private method
`nan_inf_lims` that appends the appropriate marker symbol (or bar) with the correct orientation and position, to `caplines` and `barcols`. Below is the private helper method. It takes the following parameters:

- `lim_vals`: lower, upper, left, or right. Describes where the errorbar is placed.
- `x_or_y`: `'x'` or `'y'`. 
    - `'x'` if the errorbar is in the x-direction: left or right.
    - `'y'` if the errorbar is in the y-direction: upper or lower.
- `bar_end`: an integer specifying the end position of the errorbar when `inf_repr='bar'` is used.
- `nan_marker`: a string representing the marker when `nan_repr='symbol'` is used.
- `inf_marker`: a string specifying the marker when `inf_repr='symbol'` is used.

```
def nan_inf_lims(lim_vals, x_or_y, bar_end, 
                 nan_marker=None, inf_marker=None):
    for i in range(0, len(lim_vals)):
        if (nan_repr and np.isnan(lim_vals[i])):
            caplines.append(mlines.Line2D([x[i]], [y[i]], 
                            marker=nan_marker, **eb_cap_style))
        if (inf_repr and np.isinf(lim_vals[i])):
            if inf_repr == "bar":
                if x_or_y == 'x':
                    barcols.append(self.hlines([y[i]], [x[i]], 
                                   bar_end, **eb_lines_style))
                elif x_or_y == 'y':
                    barcols.append(self.vlines([x[i]], [y[i]], 
                                   bar_end, **eb_lines_style))
            elif inf_repr == "symbol":
                caplines.append(mlines.Line2D([x[i]], [y[i]], 
                                marker=inf_marker, **eb_cap_style))
```

For the `nan_repr='symbol'` case, we would call the private helper function with the appropriate marker. There are four possible markers.

1. `mlines.CARETRIGHTBASE`
2. `mlines.CARETLEFTBASE`
3. `mlines.CARETDOWNBASE`
4. `mlines.CARETUPBASE`

For the `inf_repr='symbol'` case, we would similarly call the private method with the appropriate marker. There are also four possible markers.

1. `mlines.TICKRIGHT`
2. `mlines.TICKLEFT`
3. `mlines.TICKDOWN`
4. `mlines.TICKUP`

For both of the above `'symbol'` cases, the helper method appends the marker to `caplines`.

For the `inf_repr='bar'` case, we would have to calculate the length of the bar depending on it's position and orientation. For an `inf` errorbar **above** a data point, the length would have to extend to the upper limit of the axes. Similar logic would apply for the case of the errorbar being below, to the left, or to the right of the data point.

The helper method is called with the appropriate marker/bar-length according to the six cases mentioned.

Before explaining the six cases, there are two other helper 
methods to note, which are responsible for determining the
length of the `'bar'` representation of `inf`. 

### `get_extent()` ###

The first method is `get_extent()`, which takes two parameters
`dir`, and `x_or_y`. It calculates the maximum/minimum data point
based on the specified direction (up, down, left, or right). This 
data point includes the length of the maximum errorbar, via a call
to `get_extent_err()`.

- `dir`: string, takes values `'min'` or `'max'`. This describes whether or not we are getting the min or max extent of the data from the given direction.
- `x_or_y`: string, takes values `'x'` or `'y'`. This describes
whether or not we are getting the data from the `x` or the `y`
direction.

```
def get_extent(x_or_y, dir):
    if x_or_y == 'x':
        arr = np.array(x)
        err = xerr
    else:
        arr = np.array(y)
        err = yerr

    if len(arr) == 0:
        arr = np.array([0])
    if len(err) == 0:
        err = np.array([0])

    if dir == 'min':
        return np.nanmin(arr[arr != -np.inf]) - get_extent_err(
            'min', err)
    elif dir == 'max':
        return np.nanmax(arr[arr != np.inf]) + get_extent_err(
            'max', err)
```

### `get_extent_err()` ###

The second method is `get_extent_err()`, which takes the two 
parameters `dir` and `err`. It calculates the maximum/minimum 
errorbar based on the specified error range `err`.

- `dir`: string, takes values `'min'` or `'max'`. This describes whether or not 
we are getting the min or max extent of the errorbar from the given error range.
- `err`: either `yerr` or `xerr`, depending on which error range we are 
calculating the extent of.

```
def get_extent_err(dir, err):
    try: 
        a, b = err
        iter(a)
        iter(b)
    except (TypeError, ValueError):
        a = b = err 
    
    ac = np.array(a)
    bc = np.array(b)
    if dir == 'min':
        return np.nanmin(ac[ac != -np.inf])
    elif dir == 'max':
        return np.nanmax(bc[bc != np.inf])
```

Below are the six cases.

### Case 1 ###

Applying the errorbars **to the left** and **to the right** of the data point.

```
if noxlims.any() or len(noxlims) == 0:
    ...
    nan_inf_lims(right, 'x', get_extent('x', 'min'), 
                 mlines.CARETRIGHTBASE, mlines.TICKRIGHT)
    nan_inf_lims(left, 'x', get_extent('x', 'max'), 
                 mlines.CARETLEFTBASE, mlines.TICKLEFT)
```

### Case 2 ###

Applying the errorbars **only to the left** of the data point. 

```
if xlolims.any():
    ...
    if self.xaxis_inverted():
        marker = mlines.CARETLEFTBASE
        inf_marker = mlines.TICKLEFT
    else:
        marker = mlines.CARETRIGHTBASE
        inf_marker = mlines.TICKRIGHT
    ...
    nan_inf_lims(left, 'x', get_extent('x', 'max'), 
                 marker, inf_marker)
```

### Case 3 ###

Applying the errorbars **only to the right** of the data point.

```
if xuplims.any():
    ...
    if self.xaxis_inverted():
        marker = mlines.CARETRIGHTBASE
        inf_marker = mlines.TICKRIGHT
    else:
        marker = mlines.CARETLEFTBASE
        inf_marker = mlines.TICKLEFT
    ...
    nan_inf_lims(right, 'x', get_extent('x', 'min'), 
                 marker, inf_marker)
```

### Case 4 ###

Applying the errorbars **above** and **below** the data point.

```
if noylims.any() or len(noylims) == 0:
    ...
    nan_inf_lims(lower, 'y', get_extent('y', 'min'), 
                 mlines.CARETDOWNBASE, mlines.TICKDOWN)
    nan_inf_lims(upper, 'y', get_extent('y', 'max'), 
                 mlines.CARETUPBASE, mlines.TICKUP)
```

### Case 5 ###

Applying the errorbars **only above** the data point. 

```
if lolims.any():
    ...
    if self.yaxis_inverted():
        marker = mlines.CARETDOWNBASE
        inf_marker = mlines.TICKDOWN
    else:
        marker = mlines.CARETUPBASE
        inf_marker = mlines.TICKUP
    ...
    nan_inf_lims(upper, 'y', get_extent('y', 'max'), 
                marker, inf_marker)

```

### Case 6 ###

Applying the errorbars **only below** the data point. 

```
if uplims.any():
    ...
    if self.yaxis_inverted():
        marker = mlines.CARETUPBASE
        inf_marker = mlines.TICKUP
    else:
        marker = mlines.CARETDOWNBASE
        inf_marker = mlines.TICKDOWN
    ...
    nan_inf_lims(lower, 'y', get_extent('y', 'min'), 
                 marker, inf_marker)
```

## Verification ##

We have verified the correctness of our feature by running both the unit tests and acceptance tests, which were developed during the Testing phase. 

After the implementation, all the existing and new unit tests pass. We were also able to verify the root folder of this project repository on your local.

```
python3 -mpytest matplotlib
```
For convenience, we can directly run the unit tests for `Axes`.
```
python3 -mpytest matplotlib/lib/matplotlib/tests/test_axes.py
```
All test cases (unit test, and acceptance test) now pass.

## Documentation ##

It is important that the `matplotlib` user knows about this feature and how to use it. We have included a [User Guide](./user_guide.md). In addition, we have included example usage in the docstring of `Axes.errorbar()`, so that developers know how to modify or build upon this feature.
