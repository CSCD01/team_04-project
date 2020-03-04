# Team Mozzarella's CSCD01 Final Project

## Meet the Team

* Joe Armitage: [Github](https://github.com/armitag8)
  * [joe.armitage@mail.utoronto.ca](mailto:joe.armitage@mail.utoronto.ca)
* Jacob Chamberlain: [Github](https://github.com/JacobChamberlain)
  * [jacob.chamberlain@mail.utoronto.ca](mailto:jacob.chamberlain@mail.utoronto.ca)
* Saba Kiaei: [Github](https://github.com/sabulikia)
  * [saba.kiaei@mail.utoronto.ca](mailto:saba.kiaei@mail.utoronto.ca)
* Fides Linga: [Github](https://github.com/desslinga)
  * [fides.linga@mail.utoronto.ca](mailto:fides.linga@mail.utoronto.ca) 
* Angela Zavaleta: [Github](https://github.com/angelazb)
  * [angela.zavaletabernuy@mail.utoronto.ca](mailto:angela.zavaletabernuy@mail.utoronto.ca)

## Deliverables

0. [Deliverable 0](./deliverable/0/deliverable_0.pdf)
1. [Deliverable 1](./deliverable/1/deliverable_1.md)

## Dependencies
- Docker (newest version is best)
- VSCode, with
    - The [Remote - Containers](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers) extension
- An `X` server, if you hope to actually see matplotlib running

## Clone, Build and Run

### Clone

First clone this repo AND the submodule (MatPlotLib) without changing the name of the top-level folder (`team_04-project`).

#### Using SSH (recommended)
```bash
git clone --recurse-submodules git@github.com:CSCD01/team_04-project
```

#### Using HTTPS
```bash
git clone --recurse-submodules https://github.com/CSCD01/team_04-project
```

### Build
Just open the folder using VSCode and then the container using the containers extension. It will build (slowly... the first time may take an hour).

### Run

Any example file should work. Try:
```bash
python3 matplotlib/examples/animation/rain.py
```

#### Tests
```
python3 -mpytest matplotlib
```

#### UML Generation
```
uml/generate.sh
```
