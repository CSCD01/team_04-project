# Top Level Overview Of Architecture

## The 3-tiered Architecture
The architecture of matplot lib consists of three stacked up layers. Each layer in the stack is only aware of and interacts with lower levels which results in an appropriate distribution of complexity. Each layer is responsible for a particular functionality such as event-based interactions, visual component abstraction and creation, programmatic manipulation. 

## The Layers
1. [**Backend Layer**](./backend.md)
    
    The lowest level in the stack of layers. It is responsible for encapsulating the surface that is being drawn on, implementing the drawing on the surface, and handling event-based interactions.  
2. [**Artist Layer**](./artists.md)

    The middle layer of Matplotlib's architecture. This layer's main responsibility is the abstraction of all visual components.
3. [**Scripting Layer**](./scripting.md)

    The highest leve of the stack. This layer provides a simple and clean scripting interface to allow programmatic manipulation of visual components.