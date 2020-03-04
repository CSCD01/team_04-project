# Issues Documentation #

### [Issue 16482](https://github.com/matplotlib/matplotlib/issues/16482): Pyplot hlines and vlines do not use the 'lines.color' property in rcParams by default ###

This is a: **Change Request**.

**Description:** This issue is about wanting to be set the `colors` parameter in both `hlines` and `vlines` method in pyplot (as well as in `axes`). Instead of using `k` as the default parameter for colour, it should at least try `lines.color` which it should extract from `rcParams`.

**Where it is in the code:**

**Estimate**: X hours.

****

### [Issue 1460](https://github.com/matplotlib/matplotlib/issues/1460): make subplots smarter with regards to subplot_kw and figure_kw ###

This is a: **New Feature**.

**Description:** This issue is just about elegance. `pyplot.subplots` is a method for combining `Figure` and `Subplot` creation, for efficiency. When replacing lines such as:

```
fig = plt.figure(figsize=(10,20))
ax = plt.subplot(111, axisbg=‘w’)
```

… so that `python.subplots` is used, this is what's required. The parameters for `subplot` must now be passed into a separate dictionary `subplot_kw` instead of being directly handled by keyword arguments.

```
fig, ax = plt.subplots(figsize=(10,20), subplot_kw=dict(axisbg=‘w’))
```

However, it is arguably better if we were able to omit the `subplot_kw`, and instead pass those `subplot` parameters directly:

```
fig, ax = plt.subplots(figsize=(10,20), axisbg=‘w’)
```
**Where it is in the code:**

**Estimate**: X hours.

****

### [Issue 16389](https://github.com/matplotlib/matplotlib/issues/16389): “Size” ignored if placed before fontproperties ###

This is a: **Bug**.

**Description:** This issue is about inconsistency when specifying parameters to a function. When parameters are passed in different orders, there are different behaviours seen. 

```
plt.xlabel("value", fontproperties='SimHei',size=20) # this will work

plt.ylabel("counts",size=20, fontproperties='SimHei')  # this doesn't
```

In the first line, apparently the `size` parameter will be ignored (because it is passed before `fontproperties`). However, in the second line, the `size` parameter will be honoured. The expected behaviour is that it doesn’t matter the order in which the parameters are passed.

**Where it is in the code:** The `pyplot.xlabel` method calls the `_axes.set_label(...)` method, which calls the `axis.set_label_text(...)` method, which calls the `Text.update(...)` function on the `**kwargs`. The `update` function is inherited from `Artist.update` function, which is called on each 
keyword argument in order. The fix would be somewhere in this function.

**Estimate**: X hours.

****

### [Issue 14233](https://github.com/matplotlib/matplotlib/issues/14233): Feature Request: Allow setting default AutoMinorLocator ###

This is a: **New Feature**.

**Description:** ...

**Where it is in the code:**

**Estimate**: X hours.

****

### [Issue 9007](https://github.com/matplotlib/matplotlib/issues/9007): set_facecolor method does not auto-update in ipython ###

This is a: **Bug**.

**Description:** ...

**Where it is in the code:**

**Estimate**: X hours.

