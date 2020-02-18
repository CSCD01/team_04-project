# Artist Layer

`Artist`: this is the base class of all artists. It resides [here](https://github.com/matplotlib/matplotlib/blob/master/lib/matplotlib/artist.py) The `Artist` object uses the renderer to draw on the FigureCanvas. The `Artist` will relate its coordinate system with the canvas’ and indicate where the object can be drawn. It converts the abstract representation of the object to an actual drawing for the user.

There are both primitive and composite sub-classes of `Artist` objects. The composite subclasses derive from `Container`, whose base class resides [here](https://github.com/matplotlib/matplotlib/blob/master/lib/matplotlib/container.py):

## Primitives

Primitives can stand on their own in figures, or they can also be part of composites.

- `Line2D`
- Shape classes such as `Rectangle`, `Polygon`, `Circle`, `Ellipse`.
- Texts such as `ArcText`, `Annotation`, and `TextPath`. Images such as `AxesImage` and `FigureImage`

## Composites

Composites can contain other composite objects, or primitive objects.

- `Axis` (`XAxis`, and `Yaxis`). `Tick`, `Axes`, `PolarAxes`, `HammerAxes`, etc.
- Collections: [these](https://github.com/matplotlib/matplotlib/blob/master/lib/matplotlib/collections.py) are classes that allow for efficient rendering of large numbers of similar objects (e.g. thousands of Rectangles). Some classes: PathCollection, CircleCollection.
