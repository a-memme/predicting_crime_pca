# predicting_crime_pca
*Showcasing how PCA can be used to improve simple/multiple regression, and how principal components can be transformed back to their original space for better interpretability*

# PCA
Principal Component Analysis is a dimensionality reduction method that becomes particularly useful when dealing with large datasets containing a wide array of dimensions. Through performing a linear transformation of the variables, PCA is effective in removing multicolinearity of the predictors, and through its ranking system, allows the analyst to further reduce the effects of randomness by concentrating on the top (most relevant) principal components - i.e an effective technique for dimensionality reudction & simplifying the model. 

Its main limitation lies in the fact that the response variable is never included in the calculation, and thus, there is no considered information about said response. The choosing of "important" factors in PCA has a bias toward variability present in the variables themselves - i.e dimensions that have greater variability are usually better predictors or differentiators, however, this in not ALWAYS the case. Thus, this is where the importance of informed trial and error - i.e the comparative evaluation and testing of several models - comes into play.

# Purpose 
The following analysis aims to show how PCA can be used as an effective dimensionality reduction technique to improve the performance of a model. Furthermore, we show how the principal components (new factors created by PCA) can be transformed back to their original factor space so that said variables can be interpreted after the model is fit. This is especially useful when the purpose of the analysis is predominately descriptive.




