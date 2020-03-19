## Architecture Revisited ##

### The 3-tiered Architecture

The current architecture of matplotlib is based around creating, rendering, and updating `Figure` objects. It consists of three stacked up layers. The **encapsulation** of Matplotlib is in such a way that each layer in the stack is only aware of and interacts with lower levels which results in an appropriate distribution of complexity. Each layer is responsible for a particular functionality such as event-based interactions, visual component abstraction and creation, or stateful user interaction.

### Backend Layer

The lowest level in the stack of layers. It is responsible for encapsulating the canvas that is being drawn on, implementing the drawing on the canvas. 

Through the backend layer, Figures can be displayed (on the canvas). It is a layer of abstraction over components that can render a Figure. This layer is also responsible for handling event-based interactions (interacting with figures through keyboard and mouse inputs). There are interactive (user-interface) backends, and also non-interactive (hard copy) backends.

### Artist Layer

The middle layer of Matplotlib's architecture. This layer's main responsibility is the abstraction of all visual components.  The artist layer mainly interacts with the Backend layer through the `draw()` method that is implemented by all the classes in the Artist layer. There is one main class `Artist`, and various implementations in two primary categories: Primitive, and Composite.

The more important Artist Layer classes are perhaps the `Axes` and `Figure` classes. While documenting Issue 7876, we learned more about `Axes` methods, particularly `Axes.errorbar()`, and the design patterns within this class. We also learned about the `Container` class which is used to gather similar `Artist` objects. 

[**Architecture related to Issue 7876**](./architecture_7876).

While documenting Issue 1460, we also learned more about `Figure` methods, particularly `Figure.subplots()` and `Figure.add_subplot()`. We discovered a factory: `subplot_class_factory`, which allows users to create their own Subplot classes.

[**Architecture related to Issue 1460**](./architecture_1460).

### Scripting Layer

This layer is a wrapper around the Artist and Backend layers.

The highest level of the stack. This layer provides a simple and clean scripting interface to allow for stateful interaction with visual components. The Scripting layer has wrappers for the the Artist Layer's external methods as well as some Backend Layer classes/functionalities. It allows the user to interact with selected functions in each layer, with reduced verbosity and flexibility.

The purpose of the scripting layer is to provide ease of use during interactive sessions with users, so that they can manipulate Figure objects indirectly. This is typically meant for data visualization purposes where the user does not need the full power of the artists' API.

The Scripting Layer essentially revolves around [`Pyplot`](). While documenting Issue 1460, we learned more about `Pyplot`, particularly the `Pyplot.subplots()` method. 