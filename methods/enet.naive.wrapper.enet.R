#define your methods in .R files like this one in the methods subdirectory
#each method should take arguments input and args, like the example
#the output should be a list of the appropriate "output" format (defined in the README)
library(elasticnet)

#performs naive elastic net with K-fold CV using package "elasticnet"
#inputs:
#input: a matrix with the first column being the y values
#args: a list with elements "nfolds" for the number of folds used in CV, and "lambda" for the grid of lambda values used for one of the dimensions in two-fold CV
#
#returns the estimated coefficients beta
enet.naive.wrapper.enet = function(input,args){
    nfolds=args$nfolds
    lambda=args$lambda
    enet.cve=NULL
    enet.smin=NULL
    for(i in 1:length(lambda)){
      enet.cv=cv.enet(input[,-1],input[,1],K=nfolds,lambda=lambda[i],s=seq(0,1,length=100),mode="fraction",plot.it=FALSE,intercept=FALSE)
      enet.cve[i]=min(enet.cv$cv)
      enet.smin[i]=enet.cv$s[enet.cv$cv==min(enet.cv$cv)]
    }
    ind.mincve=which(enet.cve==min(enet.cve))
    lambda.final=lambda[ind.mincve]
    s.final=enet.smin[ind.mincve]
    enet.out=enet(input[,-1],input[,1],lambda=lambda.final,intercept=FALSE)
    enet.beta=predict(enet.out,type="coefficients",s=s.final,mode="fraction",naive=TRUE)
    return(enet.beta$coefficients)
}
