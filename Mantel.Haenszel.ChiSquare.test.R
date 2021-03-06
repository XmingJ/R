###Mantel-Haenszel Chi-Square test
###Use R
### 
### The score1 and score2 default are Table rank


MM=function(x,score1=1:dim(x)[1],score2=1:dim(x)[2]){
gg=data.frame()

for(i in 1:length(score1)){
gg[(i*dim(x)[2]-(dim(x)[2]-1)):(i*dim(x)[2]),1]=score1[i]
gg[(i*dim(x)[2]-(dim(x)[2]-1)):(i*dim(x)[2]),2]=rep(score2)
gg[(i*dim(x)[2]-(dim(x)[2]-1)):(i*dim(x)[2]),3]=x[i,1:dim(x)[2]]
}
res<-gg[,1:2][rep(1:nrow(gg),gg$V3),]# method 2 (see above)
res<-apply(gg[,1:2],2,function(x){rep(x,gg$V3)}) # method 1
M=(cor(res)[2,1]^2)*(nrow(res)-1)
p=1-pchisq(M,1)
cat("\n\n        Mantel-Haenszel Chi-Square test \n\ndata:  ","x","\nM-squared = ",M,", df = 1, pvalue = ",p,"\n\n")
}

###example
edu=c(9,11,9,44,52,41,13,23,12,10,22,27)
table.3.16=cbind(expand.grid(list(edu=c("Low","Middle","High"),as.scale=c("HS","HSG","C","CG"))),count=edu)
table.3.16.array=tapply(table.3.16$count,table.3.16[,1:2], sum)

MM(table.3.16.array,score1=c(5,7,9),score2=c(1,7,8,9))
