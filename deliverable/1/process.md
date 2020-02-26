# Development Process

Roughly, our project can be categorized as an iterative set of extensions to an established product whose requirements are well known and static. Other considerations were that our team is capable of putting much less than even a typical part-time work-week in and that measuring the speed at which we develop as a team, either momentarily or aon average serves little purpose since our duration is so short and fixed. Thus, we made the following decisions:

Due to the complexity and scope of the existent code base, we found a need for test driven development methodologies. Also, due to the imposed deadlines and peer evaluation "requirements" from our artificial "client" (Anya), we found a need for some time management and labour division tracking (but no need for live progress tracking).

There was some debate about which process our chosen methodologies best conforms to. If we were forced to pick one, perhaps Waterfall with added TDD elements would come closest to our strategy. However, we incorporate elements of Agile development, too, as well as borrowing some ideas from Kanban and the V-shaped methodology. Perhaps Frankenstein's monster might be the best name for our process.

## Our Decision Process

Our primary requirements for a development process were:
- **Flexibility**: in our experience, these projects are completed in bursts, rather than continuously distributed work. This is just a result of being coursework in an undergraduate course.
- **Robustness**: in order to maximize our chances of making a meaningful contribution, any additions or modifications we make must be thoroughly tested. We prefer that our tests are written before the tested code especially due to the nature of bug fixing (sometimes there may not actually BE a bug, sometimes a fix breaks something else).
- **Simplicity**: the work done to maintain the process should be minimal and certainly not exceed the productivity it enhances. That is, if it doesn't help us develop better or faster, it should not be a part of our process.
- **Responsibility**: the process should help us ensure that our deadlines are being met, since postponement is typically not an option in an academic setting at this level.

For a detailed breakdown of how we evaluated each process in order to arrive at these decisions and how we subsequently modified the process we chose, see [here](./process_evaluation.md).

## Tracking

We have chosen to employ Trello as the primary tool for time management, allocation of tasks, and verification that individual work performances fall within some reasonable standard deviation. In order to do so, we will be borrowing some tricks from agile development, and ignoring some distasteful strictures:
- "Task"s will *often* be expressed as features (somewhat like user stories, but more flexible).
- Though the standard user story format has important characteristics, it is too rigid and the principles they evoke can be expressed otherwise.
- The completion of a task must be verifiable and validatable. An appropriate long-form description should be added to the task card before it is estimated.
- The description of a task should be precise enough that estimation of the implementation is somewhat possible.
- Not all tasks are a feature (many of our will just be bug-fixes, some may be supporting tasks and some will likely be deliverables).
- Where possible, tasks will immediately be broken down into smaller components (no subtasks for "final" tasks).
- Tasks may be added any time, but must be estimated before being assigned.
- Estimations will be done in terms of work hours and revised as we see fit, by majority vote.
- Anything that will use (a) group members' time for this project should be tracked on Trello. Post-hoc estimation is better than none.
- Each task will be a single Trello card organized into one of these five columns: 
    - **Planned**: has not been started. Reassignment is possible.
    - **Blocked**: depends on another task being completed first. Blocking task should be linked on blocked card.
    - **In Progress**: may have uncommitted work by the group member(s) to which it is assigned. Frequent contact required.
    - **Awaiting Review**: is considered completed by the last assigned group member and awaits the review of another.
    - **Completed**: is no longer active (finished or abandoned) and is kept mostly for progress tracking.

## Peer Review

All code will be peer reviewed before being merged into the `master` branch. 

Each peer review can be completed remotely and simply entails:
- A critical reading of the new/modified code/commit
- Completion of the peer review check list [here](./peer_review.md)
- Attachment of the completed check list to the PR
- If satisfactory: approval of the PR into master
- Else: a comment left on the PR with needed/suggested changes
- Appropriate updates to the Trello board

## Test Driven Development

Our process will incorporate most of the standard paradigms of TDD. We will write tests that initially fail in order to identify either the feature or bug that is needed. We will begin development in earnest only once the tests that have been written fully evaluate the correctness of the portion in question. This does not have to be a whole task: a good size portion might be a single method or function.

## Continuous Integration

All branches will be built and run with the Travis and Circle Continuous Integration tools. For both tools, configuration files and instructions for activating the GitHub add-ons are provided by the Matplotlib development team.

Although they (the matplotlib developers) do not require or even strongly recommend that contributors set up CI on their own forks, we would like to have the best chance possible of having our PR merged into the master matplotlib repo. For that to be the case, we would like to know if any changes we make cause the build to fail, immediately. Their current recommended strategy involves kicking back PRs that break the build, but due to our time constraint we find this unacceptable.

## Branching

Our branching strategy is simple enough: where possible, work on a unique branch for your task, named after the task. 

### Merging into master

A merge to master will always require a peer review and therefore should not be made directly. Each merge should begin with merging the master branch into the local branch. Merge conflicts will be fixed, and then the local branch will be rebased. Finally a pull request is made, and upon successful completion of a peer review, is approved.

### Merging branch-to-branch

Typically, this should be done only when one task depends on another and the prior cannot be merged to master without breaking the build or otherwise adversely affecting others.

However, there may be other use cases the will have to be considered for these merges and team members are asked to simply use their best judgement here. A strict rule seems more likely to harm than help here.

### Naming

Branches should be named after their task name / card name on Trello. This allows for easier association of code to completion status.

## Tooling

So far we have had need of the following development tools just to build, explore and reverse engineer class diagrams for Matplotlib. We anticipate there will be other tools that we find indispensable over the course of the project and will effort to keep this information current as we discover and apply them.

### Docker

Building matplotlib from source code is a nightmare. The dependencies for the C source are scattered and poorly documented. The Python dependencies similarly lack a single authoritative document or config file. Although the homebrew and aptitude package managers greatly simplify the acquisition of the build dependencies for the C source, there remain issues of required environment variables, etc. We cannot fathom an excuse as to why the matplotlib developers have neither a virtual environment nor a single `requirements.txt` or `setup.py` **for developers**.

So, we created a Dockerfile that has all the build dependencies, test dependencies and other useful tooling for development installed. This way, all group members have a unified and simplified development experience.
 
### Pylint and Pyreverse

In order to generate preliminary class UML diagrams to help us understand the architecture and to serve as references as we continue our development process, we use the `pyreverse` tool that is now included in `pylint`.

Also, we will be continuing to use `pylint` during our development to ensure quality and reliable code.

### VSCode and Extensions

Working in harmony with our Dockerfile is the Visual Studio Code extension [Remote Containers](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers) which allows us to develop from within the Docker image without resorting to only command line utilities, or synchronizing files. Additionally, this allows for tools like `pylint` and the intellisense features provided by [VSCode's Official Python Extension](https://marketplace.visualstudio.com/items?itemName=ms-python.python) to act directly on the code being built and tested in the environment in which it will be built and tested.

We also make use of a host of other extensions:
- [Gitlens](https://marketplace.visualstudio.com/items?itemName=eamodio.gitlens) helps us understand when changes were made to the code and for what reason, without explicitly browsing the commit history.
- [CPP Tools](https://marketplace.visualstudio.com/items?itemName=ms-vscode.cpptools) may not be needed, but in the case where a bug turns out to be in a `C++` module (or a feature requires modifying/adding to one), may come in handy.
- [Remote X11](https://marketplace.visualstudio.com/items?itemName=spadin.remote-x11) allows for the transmission of X11 data (for GUI elements) from the development container to the host machine of the developer. We need this to check that the GUI elements of matplotlib still work and in the case that a feature requires (likely) GUI modifications / additions.
- [Spell Checker](https://marketplace.visualstudio.com/items?itemName=streetsidesoftware.code-spell-checker) is rather obviously useful.

### Draw.io

In order to refine and improve our UML class diagrams, we have been using [draw.io](https://draw.io). It is simply one of the best lossless graphical editors any of us has used, with native UML support, no charge and no installation.
