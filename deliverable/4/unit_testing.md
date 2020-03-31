# Unit Tests

We have added some unit tests to the `Axes` test suite to ensure that our feature is working as wanted. These unit tests can be found in [`text_axes.py`](https://github.com/CSCD01/team_04-project/blob/abdf278ad10a9fc8b0ab0c927cf8bb9cc8a8f58a/deliverable/4/deliverable_4.md).

Since our software development process is test driven, we add unit tests that are initially failing. Then, during the implementation of our feature, we run these tests to ensure that we are implementing the feature correctly.

Our unit tests are testing the correctness of the three core parts of our new feature. 

1. The `'symbol'` representation of the `nan` errorbar.
2. The `'symbol'` representation of the `inf` errorbar.
3. Then `'bar'` representation of the `inf` errorbar.

We have therefore added three unit test for test each of the above functionalities separately.

For each of the new representations, we have to check that they work correctly with respect to the orientation of the errorbar. An errorbar plotted at a data point can take on six cases.

- For a **y errorbar**:
    - the errorbar is placed **only above** the data point
    - the errorbar is placed **only below** the data point
    - the errorbar is placed **above and below** the data point
- For an **x errorbar**:**
    - the errorbar is placed **only to the left** of the data point
    - the errorbar is placed **only to the right** of the data point
    - the errorbar is placed to the **left and to the right** of the data point
    
In our unit tests, we check that each of these cases are working.

## 1. The `'symbol'` representation of the `nan` errorbar. ##

Firstly, we plot a linear function with errorbars of 0.5 (each side) for each point. However, we change the errorbar at the point at `x = 1` to `nan`.

```
def test_errorbar_nan():
    f, ax = plt.subplots()
    x = np.arange(3)
    y = 2*x # Plot a linear function
    eb = np.array([0.5] * 3) 
    eb[1]=np.nan # Errorbar at position 1 is nan
```

Next, we check for the **y errorbar** cases. There are three subcases. 

The first is when the `nan` symbol is plotted **only above** the data point. We check that the capline position and marker is the one we have chosen.

```
    # Cases for y errorbar, symbol representation of nan
    # Check if lolims is True, then the nan symbol is plotted only above the data point
    plotlines1, caplines1, barcols1 = ax.errorbar(x,y,yerr=eb,lolims=True,nan_repr="symbol")
    assert len(caplines1[0].get_xdata())>1
    assert caplines1[1].get_xdata()[0]==1
    assert caplines1[1].get_ydata()[0]==2
    assert caplines1[1].get_marker()==10
```

The second is when the `nan` symbol is plotted **only below** the data point. We check that the capline position and marker is the one we have chosen.

```
    # Check if uplims is True, then the nan symbol is plotted only below the data point
    plotlines2, caplines2, barcols2 = ax.errorbar(x,y,yerr=eb,uplims=True,nan_repr="symbol")
    assert len(caplines2[0].get_xdata())>1
    assert caplines2[1].get_xdata()[0]==1
    assert caplines2[1].get_ydata()[0]==2
    assert caplines2[1].get_marker()==11
```

The third is when the `nan` symbol is plotted **both above and below** the data point. We check that the capline position and marker is the one we have chosen.

```
    # Check if neither uplims nor lolims is specified, then the nan symbol is plotted 
    # both above and below the data point
    plotlines3, caplines3, barcols3 = ax.errorbar(x,y,yerr=eb,nan_repr="symbol")
    assert caplines3[0].get_xdata()[0]==1
    assert caplines3[0].get_ydata()[0]==2
    assert caplines3[0].get_marker()==11
    assert caplines3[1].get_xdata()[0]==1
    assert caplines3[1].get_ydata()[0]==2
    assert caplines3[1].get_marker()==10
```

Next, we check for the **x errorbar** cases. There are three subcases, which are symmetric to how the y errorbar subcases are handled.

The first is when the `nan` symbol is plotted **only to the right** of the data point. We check that the capline position and marker is the one we have chosen.

```
    # Cases for x errorbar, symbol representation of nan
    # Check if xlolims is True, then the nan symbol is plotted only to the right of the data point
    plotlines4, caplines4, barcols4 = ax.errorbar(x,y,xerr=eb,xlolims=True,nan_repr="symbol")
    assert len(caplines4[0].get_xdata())>1
    assert caplines4[1].get_xdata()[0]==1
    assert caplines4[1].get_ydata()[0]==2
    assert caplines4[1].get_marker()==9
```

The second is when the `nan` symbol is plotted **only to the left** of the data point. We check that the capline position and marker is the one we have chosen.

```
    # Check if xuplims is True, then the nan symbol is plotted only to the left of the data point
    plotlines5, caplines5, barcols5 = ax.errorbar(x,y,xerr=eb,xuplims=True,nan_repr="symbol")
    assert len(caplines5[0].get_xdata())>1
    assert caplines5[1].get_xdata()[0]==1
    assert caplines5[1].get_ydata()[0]==2
    assert caplines5[1].get_marker()==8
```

The third is when the `nan` symbol is plotted **both to the left and to the right** of the data point. We check that the capline position and marker is the one we have chosen.

```
    # Check if neither xuplims nor xlolims is specified, then the nan symbol is plotted
    # both to the left and right of the data point
    plotlines6, caplines6, barcols6 = ax.errorbar(x,y,xerr=eb,nan_repr="symbol")
    assert caplines6[0].get_xdata()[0]==1
    assert caplines6[0].get_ydata()[0]==2
    assert caplines6[0].get_marker()==9
    assert caplines6[1].get_xdata()[0]==1
    assert caplines6[1].get_ydata()[0]==2
    assert caplines6[1].get_marker()==8
```

Lastly, we check the default case, when we do not specify the new representation of the `nan` errorbar. In this case, we expect that there is no errorbar, as with current behaviour.

```
    # Cases of default representation of nan, should display empty errorbar
    plotlines7, caplines7, barcols7 = ax.errorbar(x,y,yerr=eb)
    plotlines8, caplines8, barcols8 = ax.errorbar(x,y,xerr=eb)
    assert len(caplines7)==0
    assert len(caplines8)==0
```

## 2. The `'symbol'` representation of the `inf` errorbar. ##

Note that this test is very similar to the above unit test.

Firstly, we plot a linear function with errorbars of 0.5 (each side) for each point. However, we change the errorbar at the point at `x = 1` to `inf`.

```
def test_errorbar_inf_symbol():
    f, ax = plt.subplots()
    x = np.arange(3)
    y = 2*x # Plot a linear function
    eb = np.array([0.5] * 3) 
    eb[1]=np.nan # Errorbar at position 1 is nan
```

Next, we check for the **y errorbar** cases. There are three subcases. 

The first is when the `inf` symbol is plotted **only above** the data point. We check that the capline position and marker is the one we have chosen.

```
    # Cases for y errorbar, symbol representation of inf
    # Check if lolims is True, then inf symbol is plotted only above the data point
    plotlines1, caplines1, barcols1 = ax.errorbar(x,y,yerr=eb,lolims=True,inf_repr="symbol")
    assert len(caplines1[0].get_xdata())>1
    assert caplines1[1].get_xdata()[0]==1
    assert caplines1[1].get_ydata()[0]==2
    assert caplines1[1].get_marker()==2
```

The second is when the `inf` symbol is plotted **only below** the data point. We check that the capline position and marker is the one we have chosen.

```
    # Check if uplims is True, then inf symbol is plotted only below the data point
    plotlines2, caplines2, barcols2 = ax.errorbar(x,y,yerr=eb,uplims=True,inf_repr="symbol")
    assert len(caplines2[0].get_xdata())>1
    assert caplines2[1].get_xdata()[0]==1
    assert caplines2[1].get_ydata()[0]==2
    assert caplines2[1].get_marker()==3
```

The third is when the `inf` symbol is plotted **both above and below** the data point. We check that the capline position and marker is the one we have chosen.

```
    # Check if neither uplims nor lolims is specified, then inf symbol is plotted 
    # both above and below the data point
    plotlines3, caplines3, barcols3 = ax.errorbar(x,y,yerr=eb,inf_repr="symbol")
    assert caplines3[0].get_xdata()[0]==1
    assert caplines3[0].get_ydata()[0]==2
    assert caplines3[0].get_marker()==3
    assert caplines3[1].get_xdata()[0]==1
    assert caplines3[1].get_ydata()[0]==2
    assert caplines3[1].get_marker()==2
```

Next, we check for the **x errorbar** cases. There are three subcases, which are symmetric to how the y errorbar subcases are handled.

The first is when the `inf` symbol is plotted **only to the right** of the data point. We check that the capline position and marker is the one we have chosen.

```
    # Cases for x errorbar, symbol representation of inf
    # Check if xlolims is True, then the inf symbol is plotted only to the right of the data point
    plotlines4, caplines4, barcols4 = ax.errorbar(x,y,xerr=eb,xlolims=True,inf_repr="symbol")
    assert len(caplines4[0].get_xdata())>1
    assert caplines4[1].get_xdata()[0]==1
    assert caplines4[1].get_ydata()[0]==2
    assert caplines4[1].get_marker()==1
```

The second is when the `inf` symbol is plotted **only to the left** of the data point. We check that the capline position and marker is the one we have chosen.

```
    # Check if xuplims is True, then the inf symbol is plotted only to the left of the data point
    plotlines5, caplines5, barcols5 = ax.errorbar(x,y,xerr=eb,xuplims=True,inf_repr="symbol")
    assert len(caplines5[0].get_xdata())>1
    assert caplines5[1].get_xdata()[0]==1
    assert caplines5[1].get_ydata()[0]==2
    assert caplines5[1].get_marker()==0
```

The third is when the `inf` symbol is plotted **both to the left and to the right** of the data point. We check that the capline position and marker is the one we have chosen.

```
    # Check if neither xuplims nor xlolims is specified, then the inf symbol is plotted
    # both to the left and right of the data point
    plotlines6, caplines6, barcols6 = ax.errorbar(x,y,xerr=eb,inf_repr="symbol")
    assert caplines6[0].get_xdata()[0]==1
    assert caplines6[0].get_ydata()[0]==2
    assert caplines6[0].get_marker()==1
    assert caplines6[1].get_xdata()[0]==1
    assert caplines6[1].get_ydata()[0]==2
    assert caplines6[1].get_marker()==0
```

Lastly, we check the default case, when we do not specify the new `'symbol'` representation of the `inf` errorbar. In this case, we expect that there is no errorbar (in particular, that the `'symbol'` representation is not used), as with current behaviour.

```
    # Cases of default representation of inf, should display empty errorbar
    plotlines7, caplines7, barcols7 = ax.errorbar(x,y,yerr=eb)
    plotlines8, caplines8, barcols8 = ax.errorbar(x,y,xerr=eb)
    assert len(caplines7)==0
    assert len(caplines8)==0
```

## 3. The `'bar'` representation of the `inf` errorbar. ##

For this unit test, we are checking the `'bar'` representation of the `inf` errorbar. This is a bit different as we are not using a symbol, and instead measuring the length of the caplines plotted.

Firstly, we plot a linear function with errorbars of 0.5 (each side) for each point. However, we change the errorbar at the point at `x = 1` to `inf`.

```
def test_errorbar_inf_bar():
    f, ax = plt.subplots()
    x = np.arange(3)
    y = 2*x # Plot exponential function
    eb = np.array([0.5] * 3)
    eb[1]=np.inf # Errorbar at position 1 is inf
```

Next, we check for the **y errorbar** cases. There are three subcases. 

The first is when the `inf` bar is plotted **only above** the data point. We check that the capline position and length extends to the top of the axes frame.

```
    # Cases for y errorbar, bar representation of inf
    # Check if lolims is True, then inf bar is plotted only above the data point
    plotlines1, caplines1, barcols1 = ax.errorbar(x,y,yerr=eb,lolims=True,inf_repr="bar")
    assert np.all(barcols1[1].get_segments()[0]==[[1.,2.],[1,4.]])
```

The second is when the `inf` bar is plotted **only below** the data point. We check that the capline position and length extends to the bottom of the axes frame.

```
    # Check if uplims is True, then inf bar is plotted only below the data point
    plotlines2, caplines2, barcols2 = ax.errorbar(x,y,yerr=eb,uplims=True,inf_repr="bar")
    assert np.all(barcols2[1].get_segments()[0]==[[1.,2.],[1.,0.]])
```

The third is when the `inf` bar is plotted **both above and below** the data point. We check that the capline position and length extends both to the top, and to the bottom of the axes frame.

```
    # Check if neither uplims nor lolims is specified, then inf bar is plotted 
    # both above and below the data point
    plotlines3, caplines3, barcols3 = ax.errorbar(x,y,yerr=eb,inf_repr="bar")
    assert np.all(barcols3[1].get_segments()[0]==[[1.,2.],[1.,0.]])
    assert np.all(barcols3[2].get_segments()[0]==[[1.,2.],[1,4.]])
```

Next, we check for the **x errorbar** cases. There are three subcases, which are symmetric to how the y errorbar subcases are handled.

The first is when the `inf` bar is plotted **only to the right** of the data point. We check that the capline position and length extends to the right of the axes frame.

```
    # Cases for x errorbar, bar representation of inf
    # Check if xlolims is True, then the inf symbol is plotted only to the right of the data point
    plotlines4, caplines4, barcols4 = ax.errorbar(x,y,xerr=eb,xlolims=True,inf_repr="bar")
    assert np.all(barcols4[1].get_segments()[0]==[[1.,2.],[2.,2.]])
```

The second is when the `inf` bar is plotted **only to the left** of the data point. We check that the capline position and length extends to the left of the axes frame.

```
    # Check if xuplims is True, then the inf bar is plotted only to the left of the data point
    plotlines5, caplines5, barcols5 = ax.errorbar(x,y,xerr=eb,xuplims=True,inf_repr="bar")
    assert np.all(barcols5[1].get_segments()[0]==[[1.,2.],[0.,2.]])
```

The third is when the `inf` bar is plotted **both to the left and to the right** of the data point. We check that the capline position and length extends both to the left, and to the right of the axes frame.

```
    # Check if neither xuplims nor xlolims is specified, then the inf bar is plotted
    # both to the left and right of the data point
    plotlines6, caplines6, barcols6 = ax.errorbar(x,y,xerr=eb,inf_repr="bar")
    assert np.all(barcols6[1].get_segments()[0]==[[1.,2.],[0.,2.]])
    assert np.all(barcols6[2].get_segments()[0]==[[1.,2.],[2.,2.]])
```

Lastly, we check the default case, when we do not specify the new `'bar'` representation of the `inf` errorbar. In this case, we expect that there is no errorbar (in particular, that the `'bar'` representation is not used), as with current behaviour.

```
    # Cases of default representation of inf, should display empty errorbar
    plotlines7, caplines7, barcols7 = ax.errorbar(x,y,yerr=eb)
    plotlines8, caplines8, barcols8 = ax.errorbar(x,y,xerr=eb)
    assert len(barcols7)==1
    assert len(barcols8)==1
```