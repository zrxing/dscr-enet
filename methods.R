sourceDir("methods")
methods=list()

methods[[1]] = list(name="lasso",fn=lasso.wrapper,args=list(nfolds=10))
methods[[2]] = list(name="lasso.e",fn=lasso.wrapper.enet,args=list(nfolds=10))
methods[[3]] = list(name="ridge",fn=ridge.wrapper,args=list(nfolds=10))
methods[[4]] = list(name="enet",fn=enet.wrapper,args=list(nfolds=10,alpha=seq(0,1,0.1)))
methods[[5]] = list(name="enet.e",fn=enet.wrapper.enet,args=list(nfolds=10,lambda=c(0,0.1,1,10,100)))
methods[[6]] = list(name="nenet.e",fn=enet.naive.wrapper.enet,args=list(nfolds=10,lambda=c(0,0.1,1,10,100)))

 
