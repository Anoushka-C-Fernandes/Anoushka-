'''
Q1. a. Consider the Law School Data (population) given in Table 3.2 (PP. 21, An Introduction to Bootstrap). Draw N=1000 samples from the population to get distribution of the correlation coefficient. 
b. Consider the Law School Data (sample) given in Table 3.1 (PP. 19, An Introduction to Bootstrap). Generate 1000 bootstrap replicates of the correlation coefficient for the law school data. From these, compute the bootstrap estimate of standard error for the correlation coefficient. 
c. Compare the distributions obtained from both methods (a) and (b).
'''

#loading libraries bootstrap and dplyr
library(bootstrap)
library(dplyr)
data = law82 #Loading law82 dataset from bootstrap library
#Selecting required columns from law82 dataset
data$LSAT 
data$GPA

#Drawing 1000 samples
samples = replicate(1000,sample_n(data,15,replace=TRUE)) #we use inbuilt 'sample_n' fn 

#We first store list type values (LSAT Column) in a vector to then convert to matrix
vector = c()
for (i in 1:1000){
  vector[i] = samples["LSAT",i]
}

#converting list to matrix 
matrix_LSAT = matrix(nrow = 15,ncol=1000)
for (i in 1:1000){
  matrix_LSAT[,i] = as.matrix(unlist(vector[i]))
}

#We first store list type values (GPA Column) in a vector to then convert to matrix
vector_2 = c()
for (i in 1:1000){
  vector_2[i] = samples["GPA",i]
}

#converting list to matrix 
matrix_GPA = matrix(,nrow = 15,ncol=1000)
for (i in 1:1000){
  matrix_GPA[,i] = as.matrix(unlist(vector_2[i]))
}

#Converting matrices to dataframes
df_LSAT = as.data.frame(matrix_LSAT)
df_GPA = as.data.frame(matrix_GPA)

#To find correlation coefficient
cor_coef = c()

for(i in 1:ncol(df_LSAT)){
  cor_coef[i] = cor(df_LSAT[,i],df_GPA[,i])
}

#Plotting the distribution of correlation coefficient
hist(cor_coef)
