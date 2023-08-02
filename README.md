# Principal Component Analysis (PCA) and Predicting Crime Rates
*Showcasing how PCA can be used to improve simple/multiple regression, and how principal components can be transformed back to their original space for better interpretability*

# PCA
Principal Component Analysis is a dimensionality reduction method that becomes particularly useful when dealing with large datasets containing a wide array of dimensions. Through performing a linear transformation of the variables, PCA is effective in removing multicolinearity of the predictors, and through its ranking system, allows the analyst to further reduce the effects of randomness by concentrating on the top (most relevant) principal components - i.e an effective technique for dimensionality reduction & simplifying the model. 

Its main limitation lies in the fact that the response variable is never included in the calculation, and thus, there is no considered information about said response. The choosing of "important" factors in PCA has a bias toward variability present in the variables themselves - i.e dimensions that have greater variability are usually better predictors or differentiators, however, this in not ALWAYS the case. Thus, this is where the importance of informed trial and error - i.e the comparative evaluation and testing of several models - comes into play.

# Analysis
## Purpose 
The following analysis aims to 
- Show how PCA can be used an effective dimensionality reduction technique
- Showcase how principal components (new factors created by PCA) can be transformed back to their original vector space for easier interpretation/use after the model is fit.
    - (especially useful when the purpose of the analysis is predominately descriptive.)
-  Explore limitations of PCA

## Method 
- Multiple regression models are fit to the popular uscrime dataset using multiple dimensions to predict crime rate
- PCA is applied to the predictor variables and models are fit to the newly created pricipal components.
- Regression models using the original dataset vs PCA set are evaluated using 5-fold cross validation.
- Principal components are then transformed back to their original vector space and models chosen via evaluation are tested and compared for performance.

## Results
### Evaluation 
##### Multiple Regression - Original Dataset
- The model using only predictor variables deemed as significant (p < 0.05) or close to significant (p < 0.1) yielded the best performance in cross validation:
![image](https://github.com/a-memme/predicting_crime_pca/assets/79600550/c74b4b29-179f-4c13-a782-51cf7512791b)

##### Multiple Regression - PCA 
- Using the prcomp() function in R, the predictor variables in the original dataset are isolated, and pca is applied.
- Once the principal components are merged back onto the respective response data, multiple regression models are fit to several different iterations of the data, based on model significance and/or scree plot inference (see below)
- The model that performed best, similarily, was that that used only principal components deemded as significant in the original model:
![image](https://github.com/a-memme/predicting_crime_pca/assets/79600550/dd9ff38f-d09b-472c-993f-2563ccb7951d)

### Expressing PCA in Original Terms (Reversing Linear Transformation)
- The transformed coefficients are first multiplied by the matrix of eigenvectors to reverse the original rotation(s):
'''
#Slice the coefficients to exclude the intercept, and multiply coefficients by eigenvectors (i.e rotations)
b_coeffs <- model$coefficients[2:5]

#reverse the rotation by multiplying coefficients by eigenvectors
c_scaled <- (b_coeffs %*% t(pca$rotation[, c(1,2,4,5)]))
'''
- The formula below represents how to transform standardized predictors back to the original form, where Bj is the scaled regression coefficient of the jth predictor and B0 is the scaled intercept:
  ![image](https://github.com/a-memme/predicting_crime_pca/assets/79600550/0de86e68-be2f-4708-a0a6-a0cdb6d30416)
- Finally, the model (as initially represented by principal components) is 

### Testing 

### Limitations 


## Discussion
- Represent the model in a way that is compatible with the raw data points but still represents the dimensionality of the Principal Component Analysis
- Why? Because said transformation could help immensley with the interpretation of the model (especially in linear regression), and can provide greater leeway to ETL processes where dimensionality reduction may be unfavourable to perform in the pipeline itself.
