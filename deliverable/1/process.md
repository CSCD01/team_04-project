# Development Process

Through an application of the Rational Unified Process, we arrived at a conclusion that the needs of our project align closely with the strengths of the Kanban methodology, with needed additions. Due to the complexity and scope of the preexistent code base, we found a need for test driven development methodologies. Also, due to the imposed deadlines from our artificial "client" (Anya), we found a need for progress tracking as well as participation tracking. Roughly though, our project can be categorized as an iterative set of extensions to an established product whose requirements are well known and static.

## Our Decision Process

For a detailed breakdown of how we evaluated each process in order to arrive at these decisions, see [here](./process_evaluation.md)

## Tracking

We have chosen to employ Trello as the primary tool for tracking progress, allocation of tasks and verification that individual work performances fall within some reasonable standard deviation. In order to do so, we will be borrowing some tricks from agile development, and ignoring some distasteful strictures:
- Tasks will *often* be expressed as features (somewhat like user stories).
- Though user stories are ok guiding principles, their format is too rigid and the principles they evoke can be expressed otherwise.
- The completion of a task must be verifiable and validatable.
- Not all tasks are a feature (many of our will just be bug-fixes, some may be supporting tasks and some will likely be deliverables).
- Tasks will immediately be broken down into smaller components (no subtasks).
- Tasks may be added anytime, but must be estimated before being assigned.
- The description of a task should be precise enough that estimation of the implementation is somewhat possible.
- Estimations will be done in terms of work hours and revised as we see fit, by majority vote.
- Anything that will use (a) group members' time for this project should be tracked on Trello. Post-hoc estimation is better than none.
- Each task will be a single Trello card organized into one of these five columns: 
    - Planned: has not been started. Reassignment is possible.
    - Blocked: depends on another task being completed first. Blocking task should be linked on blocked card.
    - In Progress: may have uncommitted work by the group member(s) to which it is assigned. Frequent contact required.
    - Awaiting Review: is considered completed by the last asssigned group member and awaits the review of another.
    - Completed: is no longer active (finished or abandoned) and is kept mostly for progress tracking.

## Peer Review

All code will be peer reviewed before being merged into the `master` branch. 

Each peer review can be completed remotely and simply entails:
- A critical reading of the new/modified code/commit
- Completion of the peer review checklist [here](./peer_review.md)
- Attachment of the completed checklist to the PR
- If satisfactory: approval of the PR into master
- Else: a comment left on the PR with needed/suggested changes
- Appropiate updates to the Trello board

## Continuous Integration

All branches will be built and run with the Travis and Circle Continuous Integration tools. For both tools, configuration files and instructions for activating the GitHub add-ons are provided by the Matplotlib development team. 

Although they (the MPL devs) do not require or even strongly recommend that contributors set up CI on their own forks, we would like to have the best chance possible of having our PR merged into the master matplotlib repo. For that to be the case, we would like to know if nay changes we make fail the build immediately. Their current recommended strategy involves kicking back PRs that break the build, but due to our time constraint we find this unacceptable.

## Branching

Our branching strategy is simple enough: where possible, work on a unique branch for your task, named after the task. 

### Merging into master

A merge to master will always require a peer review and therefore should not be made directly. Each merge should be made via a pull request and upon successful completion of a peer review is approved.

### Merging branch-to-branch

Typically, this should be done only when one task depends on another and the prior cannot be merged to master without breaking the build or otherwise adversely affecting others.

However, there may be other use cases the will have to be considered for these merges and team members are asked to simply use thier best judgement here. A strict rule seems more likely to harm than help here.

### Naming

Branches should be named after their task name / card name on Trello. This allows for easier association of code to completion status.

## Tooling

So far we have had need of the following development tools just to build, explore and reverse engineer class diagrams for Matplotlib. We anticipate there will be other tools that we find indispensible over the course of the project and will effort to keep this information current as we discover and apply them.

### Docker

Building matplotlib from source code is a nightmare. The dependencies for the C source are scattered and poorly documented. The Python dependencies similarly lack a single authorative document or config file. Although the homebrew and aptitude package managers greatly simplify the acquisition of the build dependencies for the C source, there remain issues of required environment variables, etc. I cannot fathom an excuse as to why the matplotlib developers have neither a virtual environment nor a single `requirements.txt` or `setup.py` for developers (they have )
 
### Pyreverse

### VSCode and Extensions
