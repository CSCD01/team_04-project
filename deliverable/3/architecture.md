## Architecture Revisited ##

### The 3-tiered Architecture

The current architecture of matplotlib is based around creating, rendering, and updating `Figure` objects. It consists of three layers. The **encapsulation** of matplotlib is in such a way that each layer in the stack is only aware of and interacts with lower levels which results in an appropriate distribution of complexity. Each layer is responsible for a particular functionality such as event-based interactions, visual component abstraction and creation, or stateful user interaction.

![Top level Diagram](./img/UML_Top_Level.svg)

### Backend Layer

For a full breakdown of the backend layer's structure: [details](./architecture_backend.md).

This is the bottom layer. It is responsible for encapsulating the canvas that is being drawn on, implementing the drawing on the canvas. The backend layer defines different classes, each having separate responsibilities, all working together to display a `Figure`. This layer is also responsible for handling event-based interactions (interacting with figures through keyboard and mouse inputs). As for backend implementations, there are both interactive (user-interface) backends, and also non-interactive (hard copy) backends.

### Artist Layer

For a full breakdown of the artist layer's structure: [details](./architecture_artist.md).

This is the middle layer. It is responsible for defining all the visual components that can be rendered inside a `Figure`. The Artist Layer mainly interacts with the Backend Layer through the `Artist.draw()` method that is implemented by all subclasses of `Artist`. 

The more important Artist Layer classes are perhaps the `Axes` and `Figure` classes. While documenting Issue 7876, we learned more about `Axes` methods, particularly `Axes.errorbar()`, and the design patterns within this class. We also learned about the `Container` class which is used to gather similar `Artist` objects. 

[**Architecture related to Issue 7876**](./architecture_7876.md).

While documenting Issue 1460, we also learned more about `Figure` methods, particularly `Figure.subplots()` and `Figure.add_subplot()`. We discovered a factory: `subplot_class_factory`, which allows users to create their own Subplot classes.

[**Architecture related to Issue 1460**](./architecture_1460.md).

### Scripting Layer

For a full breakdown of the scripting layer's structure: [details](./architecture_scripting.md).

This is the topmost layer. This layer provides a simple and clean scripting interface to allow for stateful interaction with visual components. The Scripting Layer has wrappers for the the Artist Layer's external methods as well as some Backend Layer classes/functionalities. It allows the user to interact with selected functions in each layer, with shorthand methods.

The purpose of the scripting layer is to provide ease of use during interactive sessions with users, so that they can manipulate Figure objects indirectly. The Scripting Layer essentially revolves around [`Pyplot`](). While documenting Issue 1460, we learned more about `Pyplot`, particularly the `Pyplot.subplots()` method. 

## Design Patterns ##

### Factory Design Pattern ###

[**`Axes` and `Container`**](./architecture_7876.md#design-patterns-observed)

[**`FigureCanvasBase` and `Event`**](./architecture_backend.md#design-patterns-observed)

[**`subplot_class_factory` and `SubplotBase`**](./architecture_1460.md#design-patterns-observed)

### Facade Design Pattern ###

[**`Pyplot`**](./architecture_scripting.md#design-patterns-observed)