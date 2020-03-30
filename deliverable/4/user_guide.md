# User Guide - `nan` and `inf` errorbars

This new feature brings new functionality to the `Axes.errorbar()` method. If you are unfamiliar with this method, read [here](https://matplotlib.org/3.1.1/api/_as_gen/matplotlib.pyplot.errorbar.html). In short, the `Axes.errorbar()` method takes as input a set of data points, and the error ranges for those data points. It then applies those errors to the data points as errorbars. The data points and their errors are returned in a `Container`. 

This feature allows the user to choose an intuitive representation of a `nan` (not a number) and `inf` (infinite) errorbar.

## Default behaviour

The default behaviour is the standard implementation of the representation of `nan` and `inf`, which is to do not display the errorbar. There is no additional action that needs to be taken to obtain the default behaviour.

## New feature

For this feature, there are new two parameters that are being introduced: `nan_repr` and `inf_repr`. These two parameters will get the type of representation that will be plotted. The parameter `nan_repr` can be set to `None` or `symbol` and the parameter `inf_repr` can be set to `None`, `symbol` or `bar`.

### `nan_repr`

By default, the parameter `nan_repr` is set to `None`, but it can also be declared as `nan_repr=None` to obtain the default behaviour.

To set `nan_repr`, the user can add the parameter `nan_repr='symbol'` while setting up the errorbar. In this case, a small circle with short lines next to it indicating the direction (xerror or yerror) will be plotted on the data points that had a value of `nan`.

Assuming the values of x, y, xerrors and yerrors are set up, the user can set the `nan_repr` in the following way:

'''
plt.errorbar(x, y, xerr=xerrors, yerr=yerrors, nan_repr='symbol')
'''

### `inf_repr`

By default, the parameter `inf_repr` is set to `None`, but it can also be declared as `inf_repr=None` to obtain the default behaviour.

To set the `inf` error as a symbol, the user can add the parameter `inf_repr='symbol'` while setting up the errorbar. In this case, a small symbol will be plotted on the data points that had a value of `inf`. The orientation of the symbol will represent the if the `inf` error is an xerror or a yerror. 

To set the `inf` error as a bar, the user can add the parameter `inf_repr='bar'` while setting up the errorbar. In this case, a dotted line across the graph will be plotted on the data points that had a value of `inf`. The orientation of the bar will be horizontal `inf` error is an xerror and it will be vertical if it is a yerror. 

Assuming the values of x, y, xerrors and yerrors are set up, the user can set the `inf_repr` in the following way:

'''
plt.errorbar(x, y, xerr=xerrors, yerr=yerrors, inf_repr='symbol')
'''

or

'''
plt.errorbar(x, y, xerr=xerrors, yerr=yerrors, inf_repr='bar')
'''