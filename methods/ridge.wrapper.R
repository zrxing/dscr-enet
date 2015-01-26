#define your methods in .R files like this one in the methods subdirectory
#each method should take arguments input and args, like the example
#the output should be a list of the appropriate "output" format (defined in the README)
library(glmnet)

#performs ridge regression with K-fold CV using package "glmnet"
#inputs:
#input: a matrix with the first column being the y values
#args: a list with element "nfolds" for the number of folds used in CV
#
#returns the estimated coefficients beta
ridge.wrapper = function(input,args){
    nfolds=args$nfolds
    ridge.out=cv.glmnet(input[,-1],input[,1],family="gaussian",alpha=0,nfolds=nfolds,intercept=FALSE,standardize=FALSE)
    ridge.beta=coef(ridge.out,s="lambda.min")
    return(as.vector(matrix(ridge.beta))[-1])
}
