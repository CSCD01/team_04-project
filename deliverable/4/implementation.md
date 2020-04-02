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
and 
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
and 
```
if uplims.any()
```

Each of the above six cases would need to accommodate three special considerations.
- `nan_repr='symbol'`
- `inf_repr='symbol'`
- `inf_repr='bar'`

To prevent duplication of code, we defined a private method that appends the appropriate marker symbol (or bar) with the correct orientation and position, to `caplines` and `barcols`. Below is the private helper method.

```
<function here>
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

**Case 1**: applying the errorbars **to the left** and **to the right** of the data point.
```
if noxlims.any() or len(noxlims) == 0:
    ...
    nan_inf_lims(right, 'x', x, y, [x[np.isfinite(x)].min()], 
                 mlines.CARETRIGHTBASE, mlines.TICKRIGHT)
    nan_inf_lims(left 'x', x, y, [x[np.isfinite(x)].max()], 
                 mlines.CARETLEFTBASE, mlines.TICKLEFT)
```

**Case 2**: applying the errorbars **only to the left** of the data point. 

```
if xlolims.any():
    ...
    if self.xaxis_inverted():
        marker = mlines.CARETLEFTBASE
        inf_marker = mlines.TICKLEFT
    else:
        marker = mlines.CARETRIGHTBASE
        inf_marker = mlines.TICKRIGHT
    nan_inf_lims(left, 'x', x, y, [x[np.isfinite(x)].max()], 
                 marker, inf_marker)
```

**Case 3**: applying the errorbars **only to the right** of the data point.

```
if xuplims.any():
    ...
    if self.xaxis_inverted():
        marker = mlines.CARETRIGHTBASE
        inf_marker = mlines.TICKRIGHT
    else:
        marker = mlines.CARETLEFTBASE
        inf_marker = mlines.TICKLEFT
    nan_inf_lims(right, 'x', x, y, [x[np.isfinite(x)].min()],
                 marker, inf_marker)
```

**Case 4**: applying the errorbars **above** and **below** the data point.
```
if noylims.any() or len(noylims) == 0:
    ...
    nan_inf_lims(lower, 'y', x, y, [y[np.isfinite(y)].min()], 
                 mlines.CARETDOWNBASE, mlines.TICKDOWN)
    nan_inf_lims(left 'y', x, y, [y[np.isfinite(y)].max()], 
                 mlines.CARETUPBASE, mlines.TICKUP)
```

**Case 5**: applying the errorbars **only above** the data point. 

```
if lolims.any():
    ...
    if self.yaxis_inverted():
        marker = mlines.CARETDOWNBASE
        inf_marker = mlines.TICKDOWN
    else:
        marker = mlines.CARETUPBASE
        inf_marker = mlines.TICKUP
    nan_inf_lims(upper, 'y', x, y, [y[np.isfinite(y)].max()], 
                 marker, inf_marker)
```

**Case 6**: applying the errorbars **only below** the data point. 

```
if uplims.any():
    ...
    if self.yaxis_inverted():
        marker = mlines.CARETUPBASE
        inf_marker = mlines.TICKUP
    else:
        marker = mlines.CARETDOWNBASE
        inf_marker = mlines.TICKDOWN
    nan_inf_lims(lower, 'y', x, y, [y[np.isfinite(y)].min()], 
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
