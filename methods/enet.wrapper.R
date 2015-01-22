#define your methods in .R files like this one in the methods subdirectory
#each method should take arguments input and args, like the example
#the output should be a list of the appropriate "output" format (defined in the README)
library(glmnet)

enet.wrapper = function(input,args){
    nfolds=args$nfolds
    alpha=args$alpha
    cve.min=NULL
    enet.out=list()
    enet.out[[1]]=cv.glmnet(input[,-1],input[,1],family="gaussian",alpha=alpha[1],nfolds=nfolds,intercept=FALSE,keep=TRUE)
    cv.id=enet.out[[1]]$foldid
    cve.min[1]=min(enet.out[[1]]$cvm)
    for(i in 2:length(alpha)){
      enet.out[[i]]=cv.glmnet(input[,-1],input[,1],family="gaussian",alpha=alpha[i],nfolds=nfolds,intercept=FALSE,foldid=cv.id)
      cve.min[i]=min(enet.out[[i]]$cvm)
    }
    ind.mincve=which(cve.min==min(cve.min))
    enet.beta=coef(enet.out[[ind.mincve]],s="lambda.min")
    return(as.vector(matrix(enet.beta))[-1])
}
