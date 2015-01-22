sourceDir("datamakers")
library(magic)

scenarios=list()
scenarios[[1]]=list(name="sim1",fn=datamaker,args=list(n=240,trainsize=40,p=8,betatrue=c(3,1.5,0,0,2,0,0,0),sigma=3,xcov=0.5^(abs(outer(1:8,1:8,"-")))),seed=seq(2,100,2))
scenarios[[2]]=list(name="sim2",fn=datamaker,args=list(n=240,trainsize=40,p=8,betatrue=rep(0.85,8),sigma=3,xcov=0.5^(abs(outer(1:8,1:8,"-")))),seed=seq(2,100,2))
scenarios[[3]]=list(name="sim3",fn=datamaker,args=list(n=600,trainsize=200,p=40,betatrue=c(rep(0,10),rep(2,10),rep(0,10),rep(2,10)),sigma=15,xcov=matrix(0.5,40,40)+diag(0.5,40)),seed=seq(2,100,2))
scenarios[[4]]=list(name="sim4",fn=datamaker,args=list(n=500,trainsize=100,p=40,betatrue=c(rep(3,15),rep(0,25)),sigma=15,xcov=do.call(adiag,list(matrix(1,5,5)-diag(0.99,5),matrix(1,5,5)-diag(0.99,5),matrix(1,5,5)-diag(0.99,5),matrix(0,25,25)))+diag(1,40)),seed=seq(2,100,2))

