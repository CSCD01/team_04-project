# User Guide - `nan` and `inf` errorbars

This new feature brings new functionality to the `Axes.errorbar()` method. If you are unfamiliar with this method, read [here](https://matplotlib.org/3.1.1/api/_as_gen/matplotlib.pyplot.errorbar.html). In short, the `Axes.errorbar()` method takes as input a set of data points, and the error ranges for those data points. It then applies those errors to the data points as errorbars. The data points and their errors are returned in a `Container`. 

This feature allows the user to choose an intuitive representation of a `nan` (not a number) and `inf` (infinite) errorbar.

## Default behaviour

Explain current behaviour.

## New feature

Explain addition of two new optional parameters.

### `nan_repr`

Explain the behaviour for both `nan_repr=None`, and `nan_repr='symbol'`. Show example usage (concise).

### `inf_repr`

Explain the behaviour for `inf_repr=None`, `inf_repr='symbol'`, and `inf_repr='bar'`. Show example usage (concise).