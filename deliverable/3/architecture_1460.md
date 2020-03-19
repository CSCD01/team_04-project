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

`nrows, ncol`: an integer that represents the number of rows or columns for the subplot grid. defaults too 1.  

`sharex, sharey`: bool or {'none', 'all', 'row', 'col'}, default: False
        Controls sharing of properties among x (`sharex`) or y (`sharey`)
        axes:
- **`True or 'all'`**: x- or y-axis will be shared among all subplots.
- **`False or 'none'`**: each subplot x- or y-axis will be independent.
- **`'row'`**: each subplot row will share an x- or y-axis.
- **`'col'`**: each subplot column will share an x- or y-axis.
        When subplots have a shared x-axis along a column, only the x tick
        labels of the bottom subplot are created. Similarly, when subplots
        have a shared y-axis along a row, only the y tick labels of the first
        column subplot are created. To later turn other subplots' ticklabels
        on, use `~matplotlib.axes.Axes.tick_params`.

`squeeze`: bool, Default true. If squeeze is set to true, the multiple Axis objects (if `nrows` xor `ncol` > 1)
        will be returned as a 1-D nparray of axis objects. If both `ncol` and `nrow` are 1, it will return a single 
        axis object. If false, will always return a 2-D nparray of axis objects

`subplot_kw and gridspec_kw`: optional dictionaries of key word arguments, to be passed to `~matplotlib.figure.Figure.add_subplot` and `~matplotlib.gridspec.GridSpec` respectively.

`fig_kw`: a dictionary of keyword arguments, passed to the `.pyplot.figure` call. 

## Figure

The "figure" file can be found at [`figure.py`](https://github.com/matplotlib/matplotlib/blob/master/lib/matplotlib/figure.py) and it implements the following classes:

`Figure`
    Top level `~matplotlib.artist.Artist`, which holds all plot elements. This is the main object that is manipulated and returned by the Artist Layer. 

`SubplotParams`
    Control the default spacing between subplots. This is not as important as figure, but it is still relivant to the file.

The class Figure is found at [`figure.py:Figure`](https://github.com/matplotlib/matplotlib/blob/master/lib/matplotlib/figure.py#L219), and it is an inherits from the `Artist` class. As stated before, a Figure object is a container for a set of plot elements, and it hold methods for manipulation of these plots.

`Figure` objects can be created with the following init method:
```
    def __init__(self,
                 figsize=None,
                 dpi=None,
                 facecolor=None,
                 edgecolor=None,
                 linewidth=0.0,
                 frameon=None,
                 subplotpars=None,  # rc figure.subplot.*
                 tight_layout=None,  # rc figure.autolayout
                 constrained_layout=None,  # rc figure.constrained_layout.use
                 ):
```
It takes the following parameters
- `figsize`: 2-tuple of floats, default: :rc:`figure.figsize`
            Figure dimension ``(width, height)`` in inches.
- `dpi`: float, default: :rc:`figure.dpi`
            Dots per inch.
- `facecolor`: default: :rc:`figure.facecolor`
            The figure patch facecolor.
- `edgecolor`: default: :rc:`figure.edgecolor`
            The figure patch edge color.
- `linewidth`: float
            The linewidth of the frame (i.e. the edge linewidth of the figure
            patch).
- `frameon`: bool, default: :rc:`figure.frameon`
            If ``False``, suppress drawing the figure background patch.
- `subplotpars`: `SubplotParams`
            Subplot parameters. If not given, the default subplot
            parameters :rc:`figure.subplot.*` are used.
- `tight_layout`: bool or dict, default: :rc:`figure.autolayout`
            If ``False`` use *subplotpars*. If ``True`` adjust subplot
            parameters using `.tight_layout` with default padding.
            When providing a dict containing the keys ``pad``, ``w_pad``,
            ``h_pad``, and ``rect``, the default `.tight_layout` paddings
            will be overridden.
- `constrained_layout`: bool, default: :rc:`figure.constrained_layout.use`
            If ``True`` use constrained layout to adjust positioning of plot
            elements.  Like ``tight_layout``, but designed to be more
            flexible.  See
            :doc:`/tutorials/intermediate/constrainedlayout_guide`
            for examples.  (Note: does not work with `add_subplot` or
            `~.pyplot.subplot2grid`.)

### `Figure.subplots()` ###

[`Figure.subplots()`](https://github.com/matplotlib/matplotlib/blob/master/lib/matplotlib/figure.py#L1423) adds a set of subplots to the given figure object. The `subplots` method takes arguments passed from the `pyplot.subplots` method, and as such they will not be explained in full. 

```
    def subplots(self, nrows=1, ncols=1, sharex=False, sharey=False,
                 squeeze=True, subplot_kw=None, gridspec_kw=None):
```

Note that as the figure already exists, there are no figure key word arguments to evaluate. All other parameters are used in the same way as `pyplot.subplots` above.

### `Figure.add_subplot()` ###

Also in the figure class, [`Figure.add_subplot()`](https://github.com/matplotlib/matplotlib/blob/master/lib/matplotlib/figure.py#L1245) adds a single `~.axes.Axes` object to the figure as part of its subplot arrangement. This can handle a lot of overhead work for a detailed definition of the requested `Axes`, or draw a default one. 

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
* 3 integers, corisponding to (*nrows*, *ncols*, *index*). The subplot will take the *index* position on a grid with *nrows* rows and *ncols* columns.
* An instance of `.SubplotSpec`

In the case it is an instance of `.SubplotSpec`, it will have a few optional parameters

- **`projection`**: An optinal parameter, that represents the projection type of the subplot (`~.axes.Axes`). This can be `{None, 'aitoff', 'hammer', 'lambert', 'mollweide', 'polar', 'rectilinear', str}`.
- **`polar`**: An optional boolean parameter, defaults to False. True of the subplot is polar (equivilent to projection='polar' form above).
- **`sharex, sharey`**: An optional instnace of `~.axes.Axes`. Share the x or y `~matplotlib.axis` with the other Axes subplots (tics, limits, and scale). 
- **`label`**: required parameter, that is a string representing the displayed name of the subplot.

`**kwargs`: Additionally, these argument will be passed to the baseclass `~.axes.Axes` when it is called. 


## GridSpec ##

Description

## SubplotBase and `subplot_class_factory()`

Description

## Design Patterns Observed

Description
