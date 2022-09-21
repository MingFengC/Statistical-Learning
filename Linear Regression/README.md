# Linear Regression

Goal: We choose beta values which minimize the RSS

Bias-Variance Trade-off
1. Model flexibility (i.e number of predictors in the model) affects the model bias and estimation variance
2. Higher model flexibility lowers model bias but introduces higher estimation variance
3. Over-fitting of the model gives low training MSE but high test MSE

Penalization & Variable Selection
1. Best subset selection, forward/backward/stepwise selection, ridge regression, lasso regression, least-angle regression
2. All methods above excluding lasso are able to perform variable selection
3. C.V can be performed for ridge & lasso regression to obtain optimum lambda constraint value that gives the lowest MSE

PCA (Principal component analysis)
1. Maximise the variance of (xi - xbar, phi)
2. Sequential PCA Algorithm (find leading eigenvector) & eigen decomposition
3. With the predictors, find first and second principal components (eigenvectors v1 & v2)

Dianostics

Outliers are points where the response is unusual given the predictor. In contrast, points with high leverage have an unusual predictor value. High leverage observations tend to have more substantial impact on the estimated regression line. In a model with multiple predictors, points with high leverage fall outside the range of other values.
1. Non-linearity of response-predictor relationship (Residual vs fitted values plot)
2. Correlation of error terms
3. Non-constant variance of error terms (Residuals vs fitted values plot, funnel shape)
4. Outliers (Residuals vs fitted values, abs(studentized residuals) > 3 are outliers)
5. High leverage points 

![Screenshot 2022-09-21 at 3 32 59 PM](https://user-images.githubusercontent.com/68551564/191442881-9fd38fa7-0c4d-4b17-91ac-bde8e17f339c.png)

6. Collinearity (Causes S.E to be higher than expected, T-score to be lower than expected, may fail to reject H0 in certain cases, look towards correlation matrix)
7. multicollinearity (VIF
