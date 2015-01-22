#define your datamaker functions in .R files in the datamaker subdirectory
#each datamaker should take input seed (integer) and args (list), and output a list with names elements meta and input
#the format of the meta and input elements should be defined in the README
library(MASS)

datamaker = function(seed,args){


  n=args$n
  trainsize=args$trainsize
  p=args$p
  betatrue=args$betatrue
  sigma=args$sigma
  xcov=args$xcov 

  set.seed(seed)
  xall=mvrnorm(n,rep(0,p),xcov)
  yall=xall%*%betatrue+sigma*rnorm(n)

  alldata=cbind(yall,xall)
  trainset=alldata[1:trainsize,]
  testset=alldata[(trainsize+1):n,]
  
  meta=list(testset=testset,betatrue=betatrue)

  data = list(meta=meta,input=trainset)
  
  return(data)

}
