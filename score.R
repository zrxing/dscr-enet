score = function(data, output){
  return(mean((data$meta$testset[,-1]%*%(data$meta$betatrue-output))^2))
}
