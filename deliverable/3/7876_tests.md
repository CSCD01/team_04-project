# User Acceptance Tests

To verify that the feature was properly implemented, the user can follow the steps below to replicate the different cases.

## UAT 1 - The feature does not interfere with the default case

1. Import `matplotlib.pyplot` and `numpy` libraries at the very top of the python file. For convenience, use `import matplotlib as plt` and `import numpy as np`.
2. Use `numpy` to initialize the the range of x. Use the `np.arange` method that will return an array of values given a start and end points, and step. For this test, we can make `x = np.arange(0, 3, 0.5)`. Make y represent the negative linear function `y = -x`.
3. Initialize a `Figure` using `plt.figure()`.
4. Plot the error bars for x and y. Make the bars for all x and y data points 0.1 long, and color them purple. Use `plt.errorbar(x, y, xerr=0.1, yerr=0.1, ecolor='purple')`.
4. Finally, write `plt.show()` to display the graph.

```
import matplotlib.pyplot as plt
import numpy as np

# Initialize the range of x points from 0 to 3 with
# an step of 0.5, and make the function negative linear
x = np.arange(0, 3, 0.5)
y = -x

# Initializes a figure
plt.figure()

# Plots error bars in the line
# Make all the horizonal and vertical errors for every 
# point be 0.1 and color them purple
plt.errorbar(x, y, xerr=0.1, yerr=0.1, ecolor='purple')

# Display the graph
plt.show()

```

The output should be a plot of a negative linear function with x range from 0 to 3 and 0.5 step. Each data point should have two purple error bars, one horizontal and one vertical, of 0.1 lenght each.

![uat_1](./img/7876_UAT1.png)
