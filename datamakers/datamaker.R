#define your datamaker functions in .R files in the datamaker subdirectory
#each datamaker should take input seed (integer) and args (list), and output a list with names elements meta and input
#the format of the meta and input elements should be defined in the README
library(MASS)


#inputs:
#args is a list with the following elements:
#n: total size of data (training + test set)
#trainsize: size of training set
#p: nuber of parameters ie. length of beta
#betatrue: true coefficients beta
#sigma: the standard deviation for the errors
#xcov: the covariance function for the predictors X, which are generated from a multivariate normal with covariance matrix sigma
#
#returns a list with the following elements:
#meta: a list with elements "testset" and "betatrue". testset is a n-trainsize by p+1 matrix with the first column being the y values 
#input: the training set, a trainsize by p+1 matrix with the first column being the y values
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
