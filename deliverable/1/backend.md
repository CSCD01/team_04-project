# Backend Layer

Abstractions for most backend modules are found in [backend_bases.py](https://github.com/matplotlib/matplotlib/blob/master/lib/matplotlib/backend_bases.py). Both interactive and non-interactive backends use the following base classes:

- `FigureCanvas`: the area (canvas) on which the Figure is rendered. This class holds a reference to a Figure, and is responsible for giving a Figure a reference to it’s canvas. This class also defines methods to draw and render the Figure. Methods used: `resize`, `print_figure`, etc.
- `RendererBase`: renders the `FigureCanvas`. The renderer handles drawing operations (for the Figure). Methods deinfed:
  - `draw_path`
  - `draw_text`
  - etc.
- `GraphicsContextBase`: An additional abstraction to handle colour and line styles, and blending properties. Methods used: `set_foreground`, `set_linewidth`
- `Event`, `ShowBase`, `TimerBase`: All of these components are responsible for handling events (and event loops), and timing to display the final result. `Event` handles user input, like keyboard strokes and mouse movement.
- `StatusBarBase`: Sets the title
