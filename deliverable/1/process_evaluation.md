### Software Development Process

## Specifics of Matplotlib development

- Matplotlib was released in 2003, so its feature set and scope are well established
- It is embedded in servers and applications, so it is important that breaking changes are rare
- There is a pre-existing test framework and expectation that new code be well-tested, too

## Processes considered

- Agile
- Kanban
- Scrum
- Spiral (Risk Analysis)
- Waterfall
- XP
- Rational Unified Process
- Incremental Delivery
- Incremental Development
- Reuse-oriented

To pick the best development process for our team, we first eliminate the processes that do not make sense. These would be; Scrum, Agile, Reuse-Oriented, and eXtreme Programming.
* Scrum is not being considered due to the role structure. We do not have a Product Owner, nor do we have anyone who wants to be the Scrum Master. As both roles are integral to the Scrum process, it will not be considered.
* Agile will not be considered for a similar reason. There is no customer satisfaction to evaluate, nor are we dealing with shifting requirements.
* Reuse Oriented focuses on using open source software for most of the development. As we are fixing bugs, and doing feature development, we will not likely be using any open source software.
* Extreme Programming is a type of Agile, and will be removed for the same reason as above.

So this leaves us with...
- ~~Agile~~
- Kanban
- ~~Scrum~~
- Spiral (Risk Analysis)
- Waterfall
- ~~XP~~
- Rational Unified Process
- Incremental Delivery
- Incremental Development
- ~~Reuse-oriented~~

## Evaluation Criteria

From here we are left with 5 possible development processes from the ones we discussed in class. To choose the final process for our team, we have come up with 4 evaluation criteria that are central to the team's needs. The criteria was discussed and signed off on by all members, and are described as follows:

1. Flexibility: We are not a professional team working 9 to 5 everyday. Whatever process we choose must reflect that some of us may be busy on days when others are not ect. So the process we choose will have to have loose regulations on workflow and work allocation, with availability to pile on critical development if important sections fall behind.

2. Deadlines and Progression: Although we are not a professional team, there will be hard deadlines we must hit. The process we choose must allow us to see how close we are to done as the deadline approaches, and allow for us to allocate more resources to critical work that is falling behind.

3. Simplicity: The last thing we want to do is spend more time logging and enhancing the process, when we could be doing work. The process we choose should be streamlined and fast to set up and implement. Little oversight should be needed to keep things running smoothly in our small team, and team members should not feel undue pressure due to process structure.

4. Test Driven: We as a team are working with matplotlib for the first time, so it is important we do not break anything. Therefore, we think our chosen process should follow test driven design philosophies, and force us to ensure our bug fixes not only “fix” the bug but also implement new tests to ensure that it stays fixed.

## Flexibility

We found the process Kanban to be the most flexible. The entire process is meant to fit into companies that are looking to adopt a new software development process without breaking everything they have. As a result, we can somewhat taylor the application of Kanban to our needs. The only thing Kanban would require us to do is utilize a board to track progress, and break user stories into tickets. Even these requirements leave much room for tweaking to suit our needs. Kanban is probably the leading Software Process when it comes to flexibility for us.

Incremental development is also very flexible. Given that we must produce outlines before we begin anyway, there is very little work required to get the ball rolling with this process. The only issue with this process is that we will likely not have any intermediate versions to improve or increment, as a bug is either fixed or not fixed typically. This is a small concession, and will not likely change the outcome of this process overall.

Incremental Delivery is similar to the above, but the focus on end user deployment will likely not fit as well. We would probably use this process in the same way as incremental development, which may somewhat defeat the purpose of using it.

Spiral will work decently in terms of flexibility. The core concept of defining objectives, developing towards the objectives, then verify and validate before moving onto the next objective is rather fluid in how exactly we would implement it for our specific needs. However, the evaluation of risk may not fit well into our ideas or flow, so this will keep Spiral below Incremental Development. As with how it goes in the real world, an implementation of Spiral for us would involve some changes to how it actually works to suit our needs more completely.

Waterfall has some issues with flexibility. By dividing the project into rigid sections, it could help our small team divide the work evenly. The main flexibility problems in waterfall come from changing requirements, but this will not be an issue for our static process. However, the sections must be completed in order, so waterfall is somewhat unfavorable when it comes to flexibility.

Rational Unified Development has a few main advantages that should be mentioned. The phases that used in RUD, mainly the inception and elaboration sections have already been completed for this phase of the project. The workflow of RUD is rather static in the order you do things, which is a point against it. We also do not have business use cases, an important part of RUD's workflow structure. RUD also requires lots of documentation and requirements gathering, something we will not be doing a lot of. We feel that RUD is to strict in its structure to be considered.

- Kanban
- Incremental Development
- Incremental Delivery
- Spiral
- Waterfall
- ~~Rational Unified Process~~

## Deadlines and Progression

Of the remaining 5 processes, waterfall is by far the one with the best deadline structure. We could set a deadline for each phase, and/or a deadline for the whole process for each section of code we work on. Its progression tracking is a little quantized (we will only be able to see which stage someone is at), but overall it is still the strongest process in this regard.

Kanban has a very strong sense of progression tracking. Multiple tickets can be seen in a visual way, allowing the whole team to track the overall progress. However, there is no real way to enforce deadlines in this way. It is possible we could perform some modifications, like enforce "time in progress" limits rather than the typical "work in progress" limits that Kanban usually uses. However this may somewhat defeat the central focus of Kanban. So we leave this in 2nd place, as there would be many modifications required to get a good deadline formula.

While spiral does not seem to have any built in method for deadline enforcement, it does have distinct phases. This would allow us to track progression by counting the number of “loops” completed. However, this would do nothing for telling us how close we are to completing the work. At least as many modifications as Kanban would be required.

Incremental Development and Incremental Delivery both suffer from major issues in this area. As both are designed around getting software to a client as quickly as possible, they suffer from a major lack of tracking. There is no build in progression system other than to deliver parts of the system. There is also no way to implement deadlines. As we think both of these are a central part of the process we want, the amount of work required to add them to either of these makes them not worth considering any more.

- Waterfall
- Kanban
- Spiral
- ~~Incremental Development~~
- ~~Incremental Delivery~~

## Simplicity

Waterfall is the simplest process for us to pull off. By simply following the sets of the process, very little overhead or modifications will be needed to implement this as our process. However, it does not have some of the things we need, so there may be some modification work to get it running smoothly, and in a way that is documentable.

Due to Kanbans flexibility, it is likely the simplest. Once a board is set up with wip limits and columns, there is essentially not more work to do. However this set up is crucial, and some aspects of it are not really in line with how we will be working (daily standup meetings for example).

Spiral is the most complex of these 3. The sections for prototyping and risk analysis would either need to be removed entirely, or modified heavily to suit our needs. It also suffers from the same drawbacks as waterfall, where we would need some way to document our progress, and we would have to come up with that on our own. So Spiral will require a lot of work and the benefits seem limited at best. It will no longer be considered an option from this point onward.

- Waterfall
- Kanban
- ~~Spiral~~

## Test Driven

Waterfall has some built in test driven functionalities, as specific steps require that unit or integration tests be developed. However, these are usually taking place after the software development is finished. While this is not ideal, we could simply modify it, and do the tests before the development, and nothing will really be lost from the process.

Kanban has no real built in TDD philosophies. Any test driven work could be easily done by simply building the test tickets and pulling them across the board first, but it is possible we would want something more rigid and well defined in this area.

- Waterfall
- Kanban

## Conclusion

Look at the remaining two processes, we believe that a heavily modified version of waterfall is our best path forward. While Kanban has a lot of flexibility and progression tracking that would be useful, it seems that the basic deadline enforcement and clean functionality of waterfall makes it the best starting framework for our final process.
