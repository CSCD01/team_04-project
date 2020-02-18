# Scripting Layer

## Pyplot Interface

The pyplot interface provides the following functions (non-exhaustive). The implementation of these functions occur in the Artist Layer. Pyplot allows the Scripting Layer to act as a wrapper of the Artist Layer:

- `plot()`: calls the current `Figure`’s Axes object’s `plot()` method and the `draw()` method of the `FigureCanvas`.
- `draw()`: redraws the current `Figure`
- `gcf()`: returns the current `Figure`
