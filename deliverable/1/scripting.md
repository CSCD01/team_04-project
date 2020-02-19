# Scripting Layer

## Pyplot Interface

 Pyplot allows the Scripting Layer to act as a wrapper of the Artist Layer, where the implementation of these functions occur. The pyplot interface provides the following functions (non-exhaustive):

- `plot()`: calls the current `Figure`’s Axes object’s `plot()` method and the `draw()` method of the `FigureCanvas`
- `draw()`: redraws the current `Figure`
- `gcf()`: returns the current `Figure`
- `figure()`: creates or activates a new `Figure`
- `axes()`: adds an `Axes` to the current `Figure` and makes it the current `Axes`
- `sca(Axes ax)`: sets the current `Axes` to `ax` and the current `Figure` to the parent of `ax`
- `show()`: displays all figures.
