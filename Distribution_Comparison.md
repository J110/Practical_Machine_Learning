Distribution of Random Variables
========================================================
author: J110
date: 26/Oct/2014
transition: rotate
font-family: 'Helvetica'

Objective
========================================================

This app was created to compare various distributions of Randomly Generated numbers. Available distributions are:

- Normal
- Uniform
- T
- F
- Gamma
- Exponential
- Chi-Square
- Log-normal
- Beta

Customizations
========================================================

Users have the choice of selecting any of the distributions as well as number of data points which can range between 1 and 1000.

Also various tabs are available to check the distributions:

- Histogram - To see the histogram pattern of selected distribution
- Density - To see the density pattern of selected distribution and ho it changes by increasing or decreasing data points
- Summary - To see the summary of randomly generated data along with its box plot
- Table - To see the actual Data

Data Generation
========================================================

Data is generated randomly in the app for selected distribution. For example:

```r
# Normal Distribution
rnorm(5)
```

```
[1] -0.3771  1.5957 -0.6464 -2.3685  0.1515
```
For some distributions, some values are assumed by default:

```r
# t distribution
rt(10, 15)
```
Also the data can be downloaded in csv format

Graphics
========================================================

Simple Graphics Techniques are used to draw plots

![plot of chunk graph](Distribution_Comparison-figure/graph.png) 
