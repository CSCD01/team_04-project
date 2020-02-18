# Deliverable 2

Handout: https://www.utsc.utoronto.ca/~atafliovich/cscd01/project/deliverable1.pdf

## Architecture Analysis

The Matplotlib architecture is composed of three main layers. All these layers are meant to interact with the `Figure` object: which would be considered the “top-level” object. The current architecture of matplotlib is based around creating, rendering, and updating `Figure` objects.

Documentation [source available here](https://github.com/matplotlib/matplotlib/tree/master/doc) and [hosted here](https://matplotlib.org/3.1.1/contents.html).

Primarily, matplotlib is a library, whose `import`able elements are under the [matplotlib](https://github.com/matplotlib/matplotlib/tree/master/lib/matplotlib) module. We will be focusing our efforts here.

#### Example Usage

Matplotlib is used either in a script, or programatically

##### Script

```python
>>> import matplotlib
...
```

##### Sequence

```sh
 User enters the data
    -> the data is loaded into the Scripting Layer
    -> the Artist Layer uses the data to create objects
    -> the Backend Layer renders the objects and draws on the FigureCanvas
```

##### Direct API Call

```python
import matplotlib
...
```

Roughly the same sequence, without the scripting layer.

### Backend Layer

For a full breakdown of the backend's structure: [details](./backend.md)

Through the backend layer, Figures can be displayed (on the canvas). It is a layer of abstraction over components that can render a Figure. Users can also interact with the figures through keyboard and mouse inputs. There are interactive (user-interface) backends, and also non-interactive (hard copy) backends.

### Artist Layer

For a full breakdown of the artist layer's structure: [details](./artists.md)

Figures are composed of modular "artist" components, which are reusable and built atop one-another. Each artist represents a visual component or shape. An artist is roughly responsible for knowing how to draw the shape / component it represents onto any arbitrary backend.

### Scripting Layer

A wrapper around the artist API for scripting. Core implementation [here](https://github.com/matplotlib/matplotlib/blob/master/lib/matplotlib/pyplot.py)

The purpose of the scripting layer is to provide ease of use during interactive sessions with users, so that they can manipulate Figure objects indirectly. This is typically meant for data visualization purposes where the user does not need the full power of the artists' API.

## Quality of Architecture Review

### Encapsulation

Each layer can only communicate with the layers below and none of the lower layers know about the higher layers.

## Abstraction

The abstract methods for backends and artists are clearly separated from their particular implementations, but are not quite minimal nor as well segregated as they could be.

### Design Patterns

- Observer Design Pattern: When there has been a change with the axes, the function `notify_axes_change(figure)` is called to notify the `figure`’s Observers.
- Singleton: `Gcf` in [`_pylab_helpers.py`](https://github.com/matplotlib/matplotlib/blob/master/lib/matplotlib/_pylab_helpers.py)

### Possible Improvements

TODO

### Software Development Process

## Specifics of Matplotlib development

- Matplotlib was released in 2003, so its feature set and scope are well established
- It is embedded in servers and applications, so it is important that breaking changes are rare
- There is a pre-existing test framework and expectation that new code be well-tested, too

## Processes considered

- ~~Agile~~
- Kanban
- RUP
- ~~Scrum~~
- Spiral (Risk Analysis)
- Waterfall
- XP

## Our choice

TODO
