n=240
trainsize=40
p=8
betatrue=c(3,1.5,0,0,2,0,0,0)
sigma=3
xcov=0.5^(abs(outer(1:8,1:8,"-")))



n=240
trainsize=40
p=8
betatrue=rep(0.85,8)
sigma=3
xcov=0.5^(abs(outer(1:8,1:8,"-")))



n=600
trainsize=200
p=40
betatrue=c(rep(0,10),rep(2,10),rep(0,10),rep(2,10))
sigma=15
xcov=matrix(0.5,40,40)+diag(0.5,40)

library(magic)
n=500
trainsize=100
p=40
betatrue=c(rep(3,15),rep(0,25))
sigma=15
xcov.bs=matrix(1,5,5)-diag(0.99,5)
xcov.b=list(xcov.bs,xcov.bs,xcov.bs,matrix(0,25,25))
sim4xcov=do.call(adiag,xcov.b)+diag(1,40)

sim4xcov=do.call(adiag,list(matrix(1,5,5)-diag(0.99,5),matrix(1,5,5)-diag(0.99,5),matrix(1,5,5)-diag(0.99,5),matrix(0,25,25)))+diag(1,40)

scenarios=list()
scenarios[[1]]=list(name="sim1",fn=datamaker,args=list(n=240,trainsize=40,p=8,betatrue=c(3,1.5,0,0,2,0,0,0),sigma=3,xcov=0.5^(abs(outer(1:8,1:8,"-")))),seed=seq(2,100,50))
scenarios[[2]]=list(name="sim2",fn=datamaker,args=list(n=240,trainsize=40,p=8,betatrue=rep(0.85,8),sigma=3,xcov=0.5^(abs(outer(1:8,1:8,"-")))),seed=seq(2,100,50))
scenarios[[3]]=list(name="sim3",fn=datamaker,args=list(n=600,trainsize=200,p=40,betatrue=c(rep(0,10),rep(2,10),rep(0,10),rep(2,10)),sigma=15,xcov=matrix(0.5,40,40)+diag(0.5,40)),seed=seq(2,100,50))
scenarios[[4]]=list(name="sim4",fn=datamaker,args=list(n=500,trainsize=100,p=40,betatrue=c(rep(3,15),rep(0,25)),sigma=15,xcov=sim4xcov),seed=seq(2,100,50))


methods=list()
methods[[1]] = list(name="lasso",fn=lasso.wrapper,args=list(nfolds=10))
methods[[2]] = list(name="lasso.e",fn=lasso.wrapper.enet,args=list(nfolds=10))
methods[[3]] = list(name="ridge",fn=ridge.wrapper,args=list(nfolds=10))
methods[[4]] = list(name="enet",fn=enet.wrapper,args=list(nfolds=10,alpha=seq(0,1,0.1)))
methods[[5]] = list(name="enet.e",fn=enet.wrapper.enet,args=list(nfolds=10,lambda=c(0,0.1,1,10,100)))
methods[[6]] = list(name="nenet.e",fn=enet.naive.wrapper.enet,args=list(nfolds=10,lambda=c(0,0.1,1,10,100)))




score = function(data, output){
  return(mean((data$meta$testset[,-1]%*%(data$meta$betatrue-output))^2))
}

res=run_dsc(scenarios,methods,score)

aggregate(results~method+scenario,res,median)

tt=datamaker(22,list(n=240,trainsize=40,p=8,betatrue=c(3,1.5,0,0,2,0,0,0),sigma=3,xcov=0.5^(abs(outer(1:8,1:8,"-")))))
zz=lasso.wrapper.enet(tt$input,list(nfolds=10,lambda=c(0,0.1,1,10,100)))
score(tt,zz)