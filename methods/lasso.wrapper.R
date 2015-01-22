#define your methods in .R files like this one in the methods subdirectory
#each method should take arguments input and args, like the example
#the output should be a list of the appropriate "output" format (defined in the README)
library(glmnet)

lasso.wrapper = function(input,args){
    nfolds=args$nfolds
    lasso.out=cv.glmnet(input[,-1],input[,1],family="gaussian",alpha=1,nfolds=nfolds,intercept=FALSE)
    lasso.beta=coef(lasso.out,s="lambda.min")
    return(as.vector(matrix(lasso.beta))[-1])
}
