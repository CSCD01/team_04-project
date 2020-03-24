# Documentation

## Description

This change request is about the behaviour of error bars when supplied with an “infinite” range of error. The change request requested that “infinite” errors would be displayed with an error range that exceeds the frame size. This would serve as an intuitive visual that there is an “infinite” error range. Currently, when a data point has an error of `inf`, this would result in no errorbar for that particular data point. The same behaviour is seen when a data point has an error of `nan`. This behaviour can cause confusion, because one can argue that `nan` and `inf` are not really the same value.

There has been some discussion about the meaning of an infinite error which should be viewed as undefined, however, the change request is about representing the infinite error bar in a more explicit way so that the user could distinguish it from a `nan` error bar. Moreover, displaying a different errorbar can indicate what is happening at a particular data point. The user can be warned of their erroneous input, whether it is `nan` or `inf`.

Showing an errorbar that extends the axes frame given an `inf` errorbar is a clearer representation, rather than an ommitted errorbar. Another proposed solution is to either remove the data point, or to plot a different symbol representing the infinite errorbar. The symbol does not necessarily represent `inf`, but rather an `undefined` error. There has been discussion on whether `inf` should be equated to `undefined`, which leaves us open to different representations if necessary.

For instance, in the following example both instances of errorbars with error `inf` and `nan` are plotted the same way. The user is unable to distinguish the errorbars from each other. The implementation of this feature would hopefully improve the intuitiveness of errorbars.

```
import numpy
import matplotlib.pyplot as plt

fig1, ax1 = plt.subplots(figsize=(15, 9))
a = numpy.arange(10)
b = a**2

c = numpy.array([1.0] * 10)
c[2] = numpy.nan # errorbar of nan
c[8] = numpy.inf # errorbar of inf

ax1.errorbar(a,b,c)
plt.show()

```

![outcome](./img/7876_outcome.png)

An example of a possible expected output where the error bar has the height of the `axes`.

![expected](./img/7876_expected2.png)

An example of another possible expected output where the data point is removed to show that it is undefined.

![expected](./img/7876_expected.png)