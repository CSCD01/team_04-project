# Architecture of Issue 1460

Introduction

![UML](./img/1460_uml_1.svg)

## Pyplot and `Pyplot.subplots()`

The `Pyplot.subplots()` method is defined in [pyplot.py](https://github.com/matplotlib/matplotlib/blob/master/lib/matplotlib/pyplot.py#L1034). It's purpose is to create a figure and a set of subplots using the given arguments. This could draw one subplot or several, and it depends on the passed key word arguments. It functions as a convinient wrapper for multiple subplots that have the same format.  

The parameters for `subplots()` are described below, based on matplotlib documentation.

```
def subplots(nrows=1, ncols=1, sharex=False, sharey=False, squeeze=True,
             subplot_kw=None, gridspec_kw=None, **fig_kw):
```

`nrows, ncols`: an integer that represents the number of rows or columns for the subplot grid. 

`subplot_kw and gridspec_kw`: optional dictionaries of key word arguments, to be passed to `Figure.add_subplot()` and `GridSpec` respectively.

`**fig_kw`: a dictionary of keyword arguments, passed to the `Pyplot.figure()` method to create a `Figure`. 

## Figure

`Figure` is defined in [`figure.py`](https://github.com/matplotlib/matplotlib/blob/master/lib/matplotlib/figure.py#L219). It is a top level `Artist`, which is a container for a set of plot elements. `Figure` defines methods for manipulation of these plots. This is the main object that is manipulated and returned by the Artist Layer. 

`Figure` objects can be created with the following init method. Some parameters are omitted.
```
def __init__(self,
             figsize=None,
             dpi=None,
             facecolor=None,
             edgecolor=None,
             ...
             ):
```
It takes the following parameters (some omitted):
- `figsize`: 2-tuple of floats, default: :rc:`figure.figsize`
            Figure dimension ``(width, height)`` in inches.
- `dpi`: float, default: :rc:`figure.dpi`
            Dots per inch.
- `facecolor`: default: :rc:`figure.facecolor`
            The figure patch facecolor.
- `edgecolor`: default: :rc:`figure.edgecolor`
            The figure patch edge color.

### `Figure.subplots()` ###

[`Figure.subplots()`](https://github.com/matplotlib/matplotlib/blob/master/lib/matplotlib/figure.py#L1423) adds a set of subplots to the given figure object. The `Figure.subplots()` method takes arguments passed from the `Pyplot.subplots()` method, and as such they will not be explained in full. This is where `subplot_kw` parameters are consumed.

```
def subplots(self, nrows=1, ncols=1, sharex=False, sharey=False,
             squeeze=True, subplot_kw=None, gridspec_kw=None):
```

Note that as the figure already exists, there are no figure key word arguments to evaluate. All other parameters are used in the same way as `Pyplot.subplots` above.

### `Figure.add_subplot()` ###

Also in the `Figure` class, [`Figure.add_subplot()`](https://github.com/matplotlib/matplotlib/blob/master/lib/matplotlib/figure.py#L1245) adds a single `Axes` instance to the `Figure` as part of its subplot arrangement. This can handle a lot of overhead work for a detailed definition of the requested `Axes`, or draw a default one. `subplot_kw` arguments are also consumed here.

```
def add_subplot(self, *args, **kwargs):
    Call signatures::
        add_subplot(nrows, ncols, index, **kwargs)
        add_subplot(pos, **kwargs)
        add_subplot(ax)
        add_subplot()
```

`*args`: can be:
* A single integer, in which case the 3 digits (required) of this integer will be split and evaluated as 3 integers
* 3 integers, corisponding to (*nrows*, *ncols*, *index*).
* An instance of `Subplot`

In the case it is an instance of `Subplot`, it will have a few optional parameters

- **`projection`**: An optinal parameter, that represents the projection type of the subplot `Axes`. 
- **`polar`**: An optional boolean parameter, which is True of the subplot is polar.
- **`sharex, sharey`**: An optional instance of `Axes`. Share the x or y `Axis` with the other Axes subplots. 
- **`label`**.

`**kwargs`: Additionally, these argument will be passed to the baseclass `Axes` when it is called. This would be where `subplot_kw` is consumed.


## GridSpec ##

Description

## SubplotBase and `subplot_class_factory()`

Description

## Design Patterns Observed

Description
