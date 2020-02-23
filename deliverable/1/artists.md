# Artist Layer

The Artist Layer defines modular visual components that are used in Figures.

`Artist`: this serves as the base class of all artists. The code resides [here](https://github.com/matplotlib/matplotlib/blob/master/lib/matplotlib/artist.py). The `Artist` object uses the `renderer` (an implementation of `RendererBase`) to draw on the `FigureCanvas`. The `Artist` will relate its coordinate system with the canvas’ and indicate where the object can be drawn. It converts the abstract representation of the object to an actual drawing for the user. 

There are both primitive and composite implementations of `Artist` classes.

## Primitives

Primitives can stand on their own in figures, or they can also be part of composites.

- `Line2D`
- Shape classes such as `Rectangle`, `Polygon`, `Circle`, `Ellipse`, which have an abstract base class `Patch`.
- Texts such as `ArcText`, `Annotation`, and `TextPath`, which have an abstract base class `Text`.
- Images such as `AxesImage` and `FigureImage`, which have an abstract base class `ImageBase`.

## Composites

Composites can contain other composite objects, or primitive objects.

- `XAxis`, and `Yaxis`, which have a base class `Axis`. 
- `Tick` (which are contained in `Axis`). 
- `Axes`, which is composed of most other `Artist` objects such as `Line2D`, `Text`, `Axis` (`YAxis` and `XAxis`), and `Patch`

![Artist Layer UML](./img/UML_Artist_Layer.svg)

