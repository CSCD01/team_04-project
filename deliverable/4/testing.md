# Testing

## Acceptance Tests

To verify that the feature was properly implemented, the user can follow the steps below to replicate the different cases.

## 1. No `nan` and `inf` errorbars on a plot

The purpose of this test is that errorbars whose values are not `inf` and `nan` are not affected by the implementation of this feature, even if the errorbar types are defined.

1. Import `matplotlib.pyplot` and `numpy` libraries at the very top of the python file. For convenience, use `import matplotlib as plt` and `import numpy as np`.
2. Use `numpy` to initialize the the range of x. Use the `np.linespace` method that will return an array of values given a start and end points, and number of points. For this test, we can make `np.linspace(0, np.pi/2, 6)`. Make y represent the sinusoidal function `y = np.sin(x)`.
3. Initialize a `Figure` using `plt.figure()`.
4. Plot the errorbars for x and y. Make the bars for all x and y data points 0.1 long, and color them purple. Use `plt.errorbar(x, y, xerr=0.1, yerr=0.1, ecolor='purple')`.
5. Finally, write `plt.show()` to display the graph.

```
import matplotlib.pyplot as plt
import numpy as np

# Initialize the range of x points from 0 to pi/2 with
# a step of 0.5, and form a sinusoidal function
x = np.linspace(0, np.pi/2, 6)
y = np.sin(x)

# Initializes a figure
plt.figure()

# Plots errorbars in the line
# Make all the horizonal and vertical errors for every 
# point be 0.1 and color them purple
plt.errorbar(x, y, xerr=0.1, yerr=0.1, ecolor='purple', nan_repr='symbol', inf_repr='bar')

# Display the graph
plt.show()

```

The output should be the plot of a sinusoidal function formed by 6 data points in the x range from 0 to pi/2. Each data point should have two purple errorbars, one horizontal and one vertical, of 0.1 length each.

<!-- ![uat_1]() -->

## 2. `nan_repr` and `inf_repr` are omitted when calling `Axes.errorbar()`

The purpose of this test is to support backwards compatibility. When the new parameters `nan_repr` and `inf_repr` are not specified, the errorbars for `nan` and `inf` are displayed as they were before the implementation of this feature, which will be considered the default value.

1. Import `matplotlib.pyplot` and `numpy` libraries at the very top of the python file. For convenience, use `import matplotlib as plt` and `import numpy as np`.
2. Use `numpy` to initialize the the range of x. Use the `np.linespace` method that will return an array of values given a start and end points, and number of points. For this test, we can make `np.linspace(0, np.pi/2, 6)`. Make y represent the sinusoidal function `y = np.sin(x)`.
3. Make the bars for all x and y data points 0.1 by initializing two arrays of size 6 with values of 0.1. Name the arrays `xerrors` and `yerrors`, use `np.array([0.1] * 6)`.
4. Change the third x error to `nan` and the fifth y error to `inf`. Use `xerrors[2] = np.nan` and `yerrors[4] = np.inf`.
5. Initialize a `Figure` using `plt.figure()`.
6. Plot the errorbars for x and y and color them purple. Make the `nan` and the `inf` errors be represented as the default case, so they will not be displayed on the plot. Use `plt.errorbar(x, y, xerr=xerrors, yerr=yerrors, ecolor='purple')`, or `plt.errorbar(x, y, xerr=xerrors, yerr=yerrors, ecolor='purple')`.
7. Finally, write `plt.show()` to display the graph.

```
import matplotlib.pyplot as plt
import numpy as np

# Initialize the range of x points from 0 to pi/2 with
# a step of 0.5, and form a sinusoidal function
x = np.linspace(0, np.pi/2, 6)
y = np.sin(x)

# Make all the horizonal and vertical errors
# for every point be 0.1
xerrors = np.array([0.1] * 6)
yerrors = np.array([0.1] * 6)

# Change the third x errorbar to be nan and
# Change the fifth y errorbar to be inf
xerrors[2] = np.nan
yerrors[4] = np.inf

# Initializes a figure
plt.figure()

# Plots errorbars in the line and color them purple
plt.errorbar(x, y, xerr=xerrors, yerr=yerrors, ecolor='purple')

# Display the graph
plt.show()

```

The output should be the plot of a sinusoidal function formed by 6 data points in the x range from 0 to pi/2. Each data point should have two purple errorbars, one horizontal and one vertical, of 0.1 length each. At the third point, only the y errorbar should be displayed. In the fifth point, only the x errorbar should be displayed.

<!-- ![uat_2]() -->

## 3. `nan` symbol and `inf` bar plotted at different data points

The purpose of this test is to check the correctness of the `'bar'` representation of an `inf` errorbar, and the `'symbol'` representation of a `nan` errorbar, on different points.

1. Import `matplotlib.pyplot` and `numpy` libraries at the very top of the python file. For convenience, use `import matplotlib as plt` and `import numpy as np`.
2. Use `numpy` to initialize the the range of x. Use the `np.linespace` method that will return an array of values given a start and end points, and number of points. For this test, we can make `np.linspace(0, np.pi/2, 6)`. Make y represent the sinusoidal function `y = np.sin(x)`.
3. Make the bars for all x and y data points 0.1 by initializing two arrays of size 6 with values of 0.1. Name the arrays `xerrors` and `yerrors`, use `np.array([0.1] * 6)`.
4. Change the third x error to `nan` and the fifth y error to `inf`. Use `xerrors[2] = np.nan` and `yerrors[4] = np.inf`.
5. Initialize a `Figure` using `plt.figure()`.
6. Plot the errorbars for x and y and color them purple. Use the `'symbol'` representation of the `nan` errorbars, and the `'bar'` representation of the `inf` errorbars. Use `plt.errorbar(x, y, xerr=xerrors, yerr=yerrors, ecolor='purple', nan_repr='symbol', inf_repr='bar')`.
7. Finally, write `plt.show()` to display the graph.

```
import matplotlib.pyplot as plt
import numpy as np

# Initialize the range of x points from 0 to pi/2 with
# a step of 0.5, and form a sinusoidal function
x = np.linspace(0, np.pi/2, 6)
y = np.sin(x)

# Make all the horizonal and vertical errors
# for every point be 0.1
xerrors = np.array([0.1] * 6)
yerrors = np.array([0.1] * 6)

# Change the third x errorbar to be nan and
# Change the fifth y errorbar to be inf
xerrors[2] = np.nan
yerrors[4] = np.inf

# Initializes a figure
plt.figure()

# Plots errorbars in the line and color them purple
plt.errorbar(x, y, xerr=xerrors, yerr=yerrors, ecolor='purple', nan_repr='symbol', inf_repr='bar')

# Display the graph
plt.show()

```

The output should be a plot of a sinusoidal function formed by 6 data points in the x range from `0` to `pi/2`. Each data point should have two purple errorbars, one horizontal and one vertical, of 0.1 length each. At the third point, the x errorbar should be a dotted line of length 0.1, with a dot in the middle. At the fifth point, y errorbar should be a dotted vertical line drawn across the figure.

<!-- ![uat_3]() -->

## 4. `inf` symbol plotted at a data point

The purpose of this test is to check the correctness of the `'symbol'` representation of an `inf` errorbar. The `inf` `'symbol'` representation is oriented based on the type of error: horizontal orientation if it is an x error, or a vertical orientation if it is a y-error.

1. Import `matplotlib.pyplot` and `numpy` libraries at the very top of the python file. For convenience, use `import matplotlib as plt` and `import numpy as np`.
2. Use `numpy` to initialize the the range of x. Use the `np.linespace` method that will return an array of values given a start and end points, and number of points. For this test, we can make `np.linspace(0, np.pi/2, 6)`. Make y represent the sinusoidal function `y = np.sin(x)`.
3. Make the bars for all x and y data points 0.1 by initializing two arrays of size 6 with values of 0.1. Name the arrays `xerrors` and `yerrors`, use `np.array([0.1] * 6)`.
4. Change the fourth x error to `inf`. Use `xerrors[3] = np.inf`.
5. Initialize a `Figure` using `plt.figure()`.
6. Plot the errorbars for x and y and color them purple. Use the `'symbol'` representation for the `inf` errorbar. Use `plt.errorbar(x, y, xerr=xerrors, yerr=yerrors, ecolor='purple', inf_repr='symbol')`.
7. Finally, write `plt.show()` to display the graph.

```
import matplotlib.pyplot as plt
import numpy as np

# Initialize the range of x points from 0 to pi/2 with
# a step of 0.5, and form a sinusoidal function
x = np.linspace(0, np.pi/2, 6)
y = np.sin(x)

# Make all the horizonal and vertical errors
# for every point be 0.1
xerrors = np.array([0.1] * 6)
yerrors = np.array([0.1] * 6)

# Change the fourth x errorbar to be inf
xerrors[3] = np.inf

# Initializes a figure
plt.figure()

# Plots errorbars in the line and color them purple
plt.errorbar(x, y, xerr=xerrors, yerr=yerrors, ecolor='purple', inf_repr='symbol')

# Display the graph
plt.show()

```

The output should be a plot of a sinusoidal function formed by 6 data points in the x range from 0 to pi/2. Each data point should have two purple errorbars, one horizontal and one vertical, of 0.1 length each. At the fourth point, the x errorbar should use the `'symbol'` representation for `inf`, horizontally oriented.

<!-- ![uat_4]() -->

## 5. `nan` and `inf` symbols plotted at the same data point

The purpose of this test is to check the correctness of the `'symbol'` representations of both the `nan`, and `inf` errorbar, when plotted on the same data point, to show that both symbols can be overlapped while maintaining its orientation.

1. Import `matplotlib.pyplot` and `numpy` libraries at the very top of the python file. For convenience, use `import matplotlib as plt` and `import numpy as np`.
2. Use `numpy` to initialize the the range of x. Use the `np.linespace` method that will return an array of values given a start and end points, and number of points. For this test, we can make `np.linspace(0, np.pi/2, 6)`. Make y represent the sinusoidal function `y = np.sin(x)`.
3. Make the bars for all x and y data points 0.1 by initializing two arrays of size 6 with values of 0.1. Name the arrays `xerrors` and `yerrors`, use `np.array([0.1] * 6)`.
4. Change the fourth x error to `nan` and the fourth y error to `inf`. Use `xerrors[3] = np.nan` and `yerrors[3] = np.inf`.
5. Initialize a `Figure` using `plt.figure()`.
6. Plot the errorbars for x and y and color them purple. Use the `'symbol'` representation for both the `nan` and `inf` errorbars. Use `plt.errorbar(x, y, xerr=xerrors, yerr=yerrors, ecolor='purple', nan_repr='symbol', inf_repr='symbol')`.
7. Finally, write `plt.show()` to display the graph.

```
import matplotlib.pyplot as plt
import numpy as np

# Initialize the range of x points from 0 to pi/2 with
# a step of 0.5, and form a sinusoidal function
x = np.linspace(0, np.pi/2, 6)
y = np.sin(x)

# Make all the horizonal and vertical errors
# for every point be 0.1
xerrors = np.array([0.1] * 6)
yerrors = np.array([0.1] * 6)

# Change the fourth x errorbar to be nan and
# Change the fourth y errorbar to be inf
xerrors[3] = np.nan
yerrors[3] = np.inf

# Initializes a figure
plt.figure()

# Plots errorbars in the line and color them purple
plt.errorbar(x, y, xerr=xerrors, yerr=yerrors, ecolor='purple', nan_repr='symbol', inf_repr='symbol')

# Display the graph
plt.show()

```

The output should be a plot of a sinusoidal function formed by 6 data points in the x range from 0 to pi/2. Each data point should have two purple errorbars, one horizontal and one vertical, of 0.1 length each. At the fourth point, the x errorbar should be a dotted line of length 0.1, with a dot in the middle. The y errorbar should use the `'symbol'` representation for `inf`, horizontally oriented.

<!-- ![uat_5]() -->

## 6. `nan` symbol and `inf` bar plotted at the same data point

The purpose of this test is to check the correctness of the `'symbol'` representation of a `nan` errorbar, and the `'bar'` representation of the `inf` errorbar, when plotted on the same data point, to show that both a symbol and a bar can be overlapped and maintain its orientation.

1. Import `matplotlib.pyplot` and `numpy` libraries at the very top of the python file. For convenience, use `import matplotlib as plt` and `import numpy as np`.
2. Use `numpy` to initialize the the range of x. Use the `np.linespace` method that will return an array of values given a start and end points, and number of points. For this test, we can make `np.linspace(0, np.pi/2, 6)`. Make y represent the sinusoidal function `y = np.sin(x)`.
3. Make the bars for all x and y data points 0.1 by initializing two arrays of size 6 with values of 0.1. Name the arrays `xerrors` and `yerrors`, use `np.array([0.1] * 6)`.
4. Change the fourth x error to `inf` and the fourth y error to `nan`. Use `xerrors[3] = np.inf` and `yerrors[3] = np.nan`.
5. Initialize a `Figure` using `plt.figure()`.
6. Plot the errorbars for x and y and color them purple. Use the `'symbol'` representation for `nan` errorbars, and the `'bar'` representation for `inf` errorbars. Use `plt.errorbar(x, y, xerr=xerrors, yerr=yerrors, ecolor='purple', nan_repr='symbol', inf_repr='bar')`.
7. Finally, write `plt.show()` to display the graph.

```
import matplotlib.pyplot as plt
import numpy as np

# Initialize the range of x points from 0 to pi/2 with
# a step of 0.5, and form a sinusoidal function
x = np.linspace(0, np.pi/2, 6)
y = np.sin(x)

# Make all the horizonal and vertical errors
# for every point be 0.1
xerrors = np.array([0.1] * 6)
yerrors = np.array([0.1] * 6)

# Change the fourth x errorbar to be inf and
# Change the fourth y errorbar to be nan
xerrors[3] = np.inf
yerrors[3] = np.nan

# Initializes a figure
plt.figure()

# Plots errorbars in the line and color them purple
plt.errorbar(x, y, xerr=xerrors, yerr=yerrors, ecolor='purple', nan_repr='symbol', inf_repr='bar')

# Display the graph
plt.show()

```

The output should be a plot of a sinusoidal function formed by 6 data points in the x range from 0 to pi/2. Each data point should have two purple errorbars, one horizontal and one vertical, of 0.1 length each. At the fourth point, the x errorbar should be a dotted horizontal line drawn across the figure. The y errorbar should be a dotted line of length 0.1, with a dot in the middle.

<!-- ![uat_6]() -->

## 7. `nan` and `inf` plotted upper and lower

The purpose of this test is to check the correctness of the `'symbol'` representation of both a `nan` and `inf` errorbars, when plotted on an upper or lower limit, to show that both can appear only on one side of the graph.

1. Import `matplotlib.pyplot` and `numpy` libraries at the very top of the python file. For convenience, use `import matplotlib as plt` and `import numpy as np`.
2. Use `numpy` to initialize the the range of x. Use the `np.linespace` method that will return an array of values given a start and end points, and number of points. For this test, we can use `np.linspace(0, np.pi/2, 6)`. Make y represent the sinusoidal function `y = np.sin(x)`.
3. Make the bars for all x and y data points 0.1 by initializing two arrays of size 6 with values of 0.1. Name the arrays `xerrors` and `yerrors`, use `np.array([0.1] * 6)`.
4. Change the first x errorbar to be nan and the second to be inf. Use `xerrors[0] = np.nan` and `xerrors[1] = np.inf`. Change the fourth y errorbar to be inf and the fifth to be nan. Use `yerrors[3] = np.inf` and `yerrors[4] = np.nan`.
5. Set the upper and lower limits for the errors by initializing four arrays of 6 boolean values each. We can use the following format for setting the limits: `np.array([1, 0, 0, 0, 0, 0], dtype=bool)`.
6. Initialize a `Figure` using `plt.figure()`.
7. Plot the errorbars for x and y and the corresponding limits, and color them purple. Use the `'symbol'` representation for both `nan` and `inf` errorbars. Use `plt.errorbar(x, y, xerr=xerrors, yerr=yerrors, xlolims=xlolims, xuplims=xuplims, lolims=lolims, uplims=uplims, ecolor='purple', nan_repr='symbol', inf_repr='bar')`.
8. Finally, write `plt.show()` to display the graph.

```
import matplotlib.pyplot as plt
import numpy as np

# Initialize the range of x points from 0 to pi/2 with
# a step of 0.5, and form a sinusoidal function
x = np.linspace(0, np.pi/2, 6)
y = np.sin(x)

# Make all the horizonal and vertical errors
# for every point be 0.1
xerrors = np.array([0.1] * 6)
yerrors = np.array([0.1] * 6)

# Change the first x errorbar to be nan and the second to be inf
xerrors[0] = np.nan
xerrors[1] = np.inf

# Change the fourth y errorbar to be inf and the fifth to be nan
yerrors[3] = np.inf
yerrors[4] = np.nan

# Set the first x errorbar to be upper limit aand the second one low limit
xuplims = np.array([1, 0, 0, 0, 0, 0], dtype=bool)
xlolims = np.array([0, 1, 0, 0, 0, 0], dtype=bool)

# Set the fourth y errorbar to be upper limit aand the fifth one low limit
uplims = np.array([0, 0, 0, 1, 0, 0], dtype=bool)
lolims = np.array([0, 0, 0, 0, 1, 0], dtype=bool)

# Initializs a figure
plt.figure()

# Plots errorbars and the corresponding limits in the line and color them purple
plt.errorbar(x, y, xerr=xerrors, yerr=yerrors, xlolims=xlolims, xuplims=xuplims, lolims=lolims, uplims=uplims, ecolor='purple',nan_repr='symbol', inf_repr='symbol'))

# Display the graph
plt.show()

```

The output should be a plot of a sinusoidal function formed by 6 data points in the x range from 0 to pi/2. Each data point should have two purple errorbars, one horizontal and one vertical, of 0.1 length each. At the first point, the x errorbar should appear only on the upper limit and at the second point the x errorbar should appear only on the lower limit. At the fourth point, the y errorbar should appear only on the upper limit and at the fifth point the y errorbar should appear only on the lower limit. 

<!-- ![uat_7]() -->

## Unit Tests