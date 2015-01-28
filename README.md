# dscr-enet
A simulation study of large-scale regression methods as described in Zou & Hastie (2005)

# Background 

For a general introduction to DSCs, see [here](https://github.com/stephens999/dscr/blob/master/intro.md).

In this simulation study, we aim to compare several methods for fitting a linear model of the form Y=XB+e, where y is a n by 1 vector of responses, X is a n by p matrix of predictors, B is a p by 1 vector of unknown coefficients and e is a n by 1 vector of iid Gaussian noise. Although the problem as described is a generic one, the methods in this study aim to provide some level of variable selection, and the vector B typically contains a substantial number of zeroes. 

The simulation schemes all contain a training set and a test set. The models are trained on the training set and an estimated vector of coefficients \hat{B} is returned. The performance of a method is then determined by the quantity E((X*\hat{B}-X*B)^2), where X* are the predictors in the test set.

# Input, meta and output formats

This DSC uses the following formats:

`input: an ntrain by p+1 matrix of training data [matrix]` #ntrain is the number of observations in the training set, and p is the number of predictors. The first column of the matrix contains the Y values in the training set, and the rest of the matrix contains the X values.

`meta: list(testset [matrix], betatrue [vector])` #testset is an ntest by p+1 matrix of test data, where ntest is the number of observations in the test set, and p is the number of predictors. The first column of the matrix contains the Y values in the test set, and the rest of the matrix contains the X values. betatrue is a p by 1 vector, which is simply the true B from whence the observations are generated from.


`output: an estimated vector of coefficients for B [vector]` 


# Scores

The performance of a method is scored by the quantity median(\hat{E}((X*\hat{B}-X*B)^2)). Here X* are the predictors in the test set, \hat{E} denotes the sample average, and the median is computed over all runs of a given simulation scheme (ie different seeds).

See [score.R](score.R).

# To add a method

To add a method there are two steps.

- add a `.R` file containing an R function implenting that method to the `methods/` subdirectory
- add the method to the list of methods in the `methods.R` file.

Each method function must take arguments `(input,args)` where `input` is a list with the correct format (defined above), and `args` is a list containing any additional arguments the method requires.

Each method function must return `output`, where `output` is a list with the correct format (defined above).

# To add a scenario

To add a scenario there are two steps, the first of which can be skipped if you are using an existing datamaker function

- add a `.R` file containing an R function implenting a datamaker to the `datamakers/` subdirectory
- add the scenario to the list of scenarios in the `scenarios.R` file.

Each datamaker function must return a `list(meta,input)` where `meta` and `input` are each lists with the correct format
(defined above).


