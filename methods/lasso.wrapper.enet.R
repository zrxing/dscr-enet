#define your methods in .R files like this one in the methods subdirectory
#each method should take arguments input and args, like the example
#the output should be a list of the appropriate "output" format (defined in the README)
library(elasticnet)

lasso.wrapper.enet = function(input,args){
    nfolds=args$nfolds
    enet.cv=cv.enet(input[,-1],input[,1],K=nfolds,lambda=0,s=seq(0,1,length=100),mode="fraction",plot.it=FALSE,intercept=FALSE)
    s.final=enet.cv$s[enet.cv$cv==min(enet.cv$cv)]
    enet.out=enet(input[,-1],input[,1],lambda=0,intercept=FALSE)
    enet.beta=predict(enet.out,type="coefficients",s=s.final,mode="fraction")
    return(enet.beta$coefficients)
}
