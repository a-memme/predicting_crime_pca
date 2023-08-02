#Read in data
library(readr)
crime <- read.table("uscrime.txt", header=TRUE, sep = "", dec = ".")
View(crime)

#Correlation Matrices 
cor(crime)
#Only strong correlations (no multicolinearity)
matrix <- as.matrix(crime[, c('Po1', 'Po2', 'Wealth', 'Prob')])
cor(matrix)
#Standardized
log_crime <- log(crime)
cor(log_crime)

#Build regression models 
#All variables
model1 <- lm(Crime ~ M + So + Ed + Po1 + Po2 + LF + M.F + Pop + NW + U1 + U2 + Wealth + Ineq + Prob + Time, data=crime, x=TRUE, y=TRUE)
summary(model1)
#Only significant/close to sig variables
model2 <- lm(Crime ~ M + Po1 + Ed + Ineq + Wealth + Prob, data=crime, y=TRUE, x=TRUE)
summary(model2)

#Evaluate 
install.packages('lmvar')
library('lmvar')

cv.lm(model1, k=5) #MAE = 228 ; RMSE = 288
cv.lm(model2, k=5) #MAE = 186 ; RMSE = 237***



#PCA
#Apply PCA with scaling
crime_ivs <- (crime[, 1:15])
pca1 <- prcomp(crime_ivs, scale=TRUE)
summary(pca1)

#summary output 
#stdev = eigenvalue
#rotation = eigenvector
pca1$rotation

#Visualize - scree plot to employ elbow method
screeplot(pca1, type='lines')

#Merge pca outputs with the response variable to prep for linear regression 
merged <- as.data.frame(cbind(pca1$x, crime$Crime))
View(merged)

#Build regression models with transformed data 
model_1 <- lm(V16 ~ PC1 + PC2 + PC3 + PC4 + PC5 + PC6 + PC7 + PC8 + PC9 + PC10 + PC11 + PC12 + PC13 + PC14 + PC15, merged, x=TRUE, y=TRUE)
summary(model_1)
#Only significant + close to significant variables 
model_2 <- lm(V16 ~ PC1 + PC2 + PC4 + PC5 + PC7 + PC12 + PC14, merged, x=TRUE, y=TRUE)
summary(model_2)
#Only significant variables in the quantity suggested by screeplot (4-6 predictor variables)
model_3 <- lm(V16 ~ PC1 + PC2 + PC4 + PC5 + PC7 + PC12, merged, x=TRUE, y=TRUE)
summary(model_3)
#Only first initial components as advised by scree plot
model_4 <- lm(V16 ~ PC1 + PC2 + PC3 + PC4 + PC5, merged, x=TRUE, y=TRUE)
summary(model_4)

#Evaluate
cv.lm(model_1, k=5) #MAE = 232 ; RMSE = 292
cv.lm(model_2, k=5) #MAE = 197 ; RMSE = 237
cv.lm(model_3, k=5) #MAE = 177 ; RMSE = 231***
cv.lm(model_4, k=5) #MAE = 220 ; RMSE = 264



#Create a subset of the coefficients, excluding the intercept
b_coeffs <- model_3$coefficients[2:7]
#reverse the rotation by multiplying coefficients by eigenvectors
c_scaled <- b_coeffs %*% t(pca1$rotation[, c(1,2,4,5,7,12)])
c_scaled

#Store the stdev and mean of the original data into variables -- the prcomp() function outputs us these values for each variable
#in the $scale (stdev) and $center (mean) dimensions
sigma <- pca1$scale
mu <- pca1$center

#Descale the coefficients (An) by dividing the std dev of the variables 
unscaled_coeffs <- c_scaled / sigma
#Descale the intercept by subtracting by the sum of all scaled coefficients * mu/sigma (solve for b)
unscaled_intercept <- model_1$coefficients[1] - sum(c_scaled * (mu/sigma))

#Final equation - in the style y= ax + b
prediction <- (as.matrix(crime_ivs) %*% unscaled_coeffs[1, ]) + unscaled_intercept




