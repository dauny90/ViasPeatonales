library(ROCR)
library(AUC)
library(xgboost)  
library(pROC) 

eta<-data.frame(eta=seq(0.05,1,0.05))
maxdepth<-data.frame(maxdepth=seq(1,12,1))
nround<-data.frame(nround=seq(50,500,50))
colsample<-data.frame(colsample=seq(0.1,1,0.1))
subsample<-data.frame(subsample=seq(0.1,1,0.1))


hiperparametros<-merge(merge(merge(merge(
  eta,
  maxdepth,all=TRUE),
  nround,all=TRUE),
  subsample,all=TRUE),
  colsample,all=TRUE)
hiperparametros$result_roc<-NA
hiperparametros$result_tresh<-NA
hiperparametros<-hiperparametros[sample(1:nrow(hiperparametros)),]

setwd("C:/Users/dawoo/Dropbox/Proyectos/Veredas/ViasPeatonales/data")

fiscalizacion <- read.csv("fiscaizacion_rus_final.csv",stringsAsFactors = FALSE)
fiscalizacion$X <- NULL
fiscalizacion$f_CO_date <- NULL
fiscalizacion$f_CC_date <- NULL
fiscalizacion$f_CD_date <- NULL
fiscalizacion$f_CO_inicio_obra <- NULL
fiscalizacion$f_CO_fin_obra <- NULL

dataFinaly <- fiscalizacion$f_CD_output
dataFinalTrain <- fiscalizacion
dataFinalTrain$f_CD_output <- NULL

dataFinalTrain <- as.matrix(dataFinalTrain)


i = 1
while(i <= nrow(hiperparametros))
{
  a <- Sys.time()
  set.seed(19900330)
  cv.res <- xgb.cv(data = dataFinalTrain,
                   label = dataFinaly,
                   nfold = 5,
                   nrounds = hiperparametros[i,]$nround,
                   max_depth = hiperparametros[i,]$maxdepth ,
                   subsample = hiperparametros[i,]$subsample,
                   colsample_bytree = hiperparametros[i,]$colsample,
                   eta=hiperparametros[i,]$eta,
                   objective = "binary:logistic",
                   eval_metric ='auc',
                   early_stopping_rounds =10,verbose = FALSE)
  hiperparametros[i,]$result_roc <- cv.res$evaluation_log[cv.res$best_iteration,4] 
  hiperparametros[i,]$result_tresh<- cv.res$best_iteration
  b <-Sys.time()
  print(b-a)
  print(i)
  print(hiperparametros[i,]$result_roc)
  i=i+1
  gc()
}


xgb <- xgboost(data = dataFinalTrain, 
               label = dataFinaly, 
               eta = 0.25,
               max_depth = 6,
               nround=35, 
               subsample = 1,
               colsample_bytree = 1,
               eval_metric ='auc',
               objective = 'binary:logistic',
               num_class = 1,verbose = FALSE
)
View(xgb.importance(model = xgb))
