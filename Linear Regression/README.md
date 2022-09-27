# Linear Regression

**Goal**: We choose beta values which minimize the sample MSE. We use the RSE to estimate var(eps). RSE = sqrt(RSS / n-p-1). We use RSE and R^2 to study model fit.

Training data: data used for estimating model parameters
Test data: data used for assesing model prediction accuracy

**Test MSE**
1. Approximate by validation MSE through C.V on a validation dataset if the dataset is small. Obtain the MSE of each model on the rth fold of data, then obtain the CV MSE through the mean of all the model MSE. Any form of variable selection must be done within each iteration of C.V using the validation dataset.
2. Split dataset into training and test, and approximate through predict function

**Bias-Variance Trade-off**
1. Bias = E(f^(x0)) = f(x0), how close a model is to its true relationship. If the true relationship is a subset of the chosen model, model bias = 0.
2. Variance = Var(f^(x0))
3. Model flexibility (i.e number of predictors in the model) affects the model bias and estimation variance
4. Higher model flexibility lowers model bias but introduces higher estimation variance
5. Over-fitting of the model gives low training MSE but high test MSE
6. Training MSE tends to underestimate the theoretical MSE, tend to choose a more flexible model that overfits the training data (lower training MSE)

**Variable Selection (subset selection, shrinkage, dimension reduction)**
Motivations: 
a. Prediction accuracy: full model has low bias, high estimation variance. When p > n, there is no longer a unique least squares coefficient estimate
b. Interpretability: high-dimensions can contain certain irrelevant predictors, removing them can improve interpretability

**Subset selection (best subset selection, forward/backward stepwise selection, forward stagewise regression)**
1. Best subset selection: Obtain a model with increasing number of predictors. Among p predictors, choose k <= p predictors that provide the best fit. Within each of the models with k predictors, select the best model with k predictors using the smallest RSS or largest R2. When comparing models with different number of predictors, we use c.v prediction error, Cp (AIC), BIC or adjR2.
2. Forward/backward stepwise selection: sequentially add and remove predictors respectively. The predictor added and removed will correspond to the model with the smallest RSS or largest R2 respectively. The selection stop once the prev model has the smallest c.v prediction error, Cp (AIC), BIC or adjR2.
3. Forward stagewise regression: consider correlation between each predictor and residuals <img width="151" alt="Screenshot 2022-09-26 at 4 54 27 PM" src="https://user-images.githubusercontent.com/68551564/192235135-632b9fd1-878f-4827-8384-97e3e8a1f192.png">. Choose the predictor to add which has the highest absolute correlation with the residuals. <img width="412" alt="Screenshot 2022-09-26 at 4 56 16 PM" src="https://user-images.githubusercontent.com/68551564/192235527-e25a1a2b-cd46-437e-a35f-9206622618ea.png">. If delta = abs(cjhathat), it is forward stepwise selection. Small delta makes forward stagewise selection less greedy. If a variable is repicked in another step, then no new variable is added.

1. Best subset selection, forward/backward/stepwise selection, ridge regression, lasso regression, least-angle regression (LARS)
2. All methods above excluding ridge are able to perform variable selection
3. C.V can be performed for ridge & lasso regression to obtain optimum lambda constraint value that gives the lowest MSE

**Shrinkage methods**
1. Subset selection: L0 norm (number of non zero loadings in beta) < k. 
2. Ridge regression: squared L2 norm <= gamma. Larger gamma value results in a more flexible model. ![Screenshot 2022-09-27 at 12 06 51 AM](https://user-images.githubusercontent.com/68551564/192326319-7133bb76-10e8-4836-93f3-37effbe6f605.png). Larger gamma values correspond to smaller lambda values. The shrinkage penalty tends to be small when all betas are close to 0. As lambda approaches infinity, beta values approach 0 to minimize the penalized RSS as much as possible. The scale of each predictor has impact on the shrinkage effect ![Screenshot 2022-09-27 at 1 10 20 AM](https://user-images.githubusercontent.com/68551564/192338731-24153bc6-221a-4c47-8657-24ab3b96223b.png). We want the ridge estimate betajR to receive roughly the same amount of shrinkage after standardization, thus standardization has to be done for each xij before ridge regression.
3. Lasso regression: L1 norm <= gamma. Shrinkage effect: ![Screenshot 2022-09-27 at 1 53 36 AM](https://user-images.githubusercontent.com/68551564/192346545-75061f18-1213-4349-877e-1c5f3e8b1b9c.png). The estimate does = 0 at a certain value, so Lasso does variable selection.
4. LARS: similar to forward stagewise regression where predictors are added sequentially that correspond to the highest correlation between the predictor and the residuals. <img width="412" alt="Screenshot 2022-09-26 at 4 56 16 PM" src="https://user-images.githubusercontent.com/68551564/192235527-e25a1a2b-cd46-437e-a35f-9206622618ea.png">, we want to choose a delta value such that in the next step, xj and another predictor xk will have the same absolute correlation with the residuals. 
Steps: 1. Start with standardized predictors and the model with only intercept. 2. Find the predictor xj more correlated with the residual and add the proportion of xj into the model where delta is the largest value such that some other predictor xk has as much correlation with the current residual as does xj. ![Screenshot 2022-09-27 at 11 45 56 AM](https://user-images.githubusercontent.com/68551564/192427180-562e7be5-8c10-4715-8f01-af53964cf9cc.png) 3. Move betajLARS and betakLARS in the diorection defined by their joint least squares coefficient of the current residual on (xj, xk), until some other predictor xl has as much correlation with the current residual. Continue until all p predictors have been entered.

Estimating hyperparameters: perform C.V with k folds. Within each fold, for each candidate lambda value, we find the ridge estimator and the validation MSE for that particular fold with that particular lambda value. Find the mean across all K folds for each lamba value to obtain the mean test error. ![Screenshot 2022-09-27 at 1 41 22 AM](https://user-images.githubusercontent.com/68551564/192344369-2b0c6575-3c55-438b-8c49-5d284595b58c.png)

**Dimension Reduction: PCA (Principal component analysis)**
1. High dimension data where p > n, OLS has a much higher estimation variance.
2. Maximise the variance of (xi - xbar, phi)
3. Sequential PCA Algorithm (find leading eigenvector) & eigen decomposition
4. With the predictors, find first and second principal components (eigenvectors v1 & v2)

**Dianostics**

Outliers are points where the response is unusual given the predictor. In contrast, points with high leverage have an unusual predictor value. High leverage observations tend to have more substantial impact on the estimated regression line. In a model with multiple predictors, points with high leverage fall outside the range of other values.
1. Non-linearity of response-predictor relationship (Residual vs fitted values plot)
2. Correlation of error terms
3. Non-constant variance of error terms (Residuals vs fitted values plot, funnel shape)
4. Outliers (Residuals vs fitted values, abs(studentized residuals) > 3 are outliers)
5. High leverage points 

![leverage statistic](https://user-images.githubusercontent.com/68551564/191442881-9fd38fa7-0c4d-4b17-91ac-bde8e17f339c.png)

6. Collinearity (Causes S.E to be higher than expected, T-score to be lower than expected, may fail to reject H0 in certain cases, look towards correlation matrix)
7. Multicollinearity (VIF of 1 represents no collinearity and values above 5/10 indicates a problematic amount of collinearity)

![VIF](https://user-images.githubusercontent.com/68551564/191443707-01cad8ef-1a35-4cc0-a939-77e932fd9b06.png)

R2 from a regression of Xj onto all of the other predictors. If R2 is close to one, then collinearity is present, and so the VIF will be large.

**Steps:**
1. Determine the scale of predictor variables to be included in the regression function: pairwise scatter plots.
2. Using the full model for the preliminary analysis.
3. Check homogeneity (equal variance of irreducible error): plot of residuals vs. fitted values (check for null pattern).
4. Check normality: normal probability plot of standardized residuals (points are supposed to fall on a straight line in a Q-Q plot).
5. Check outliers: hat values, deletion residuals and Cook’s distance.
6. If there are any discrepancy, adopt remedial measures (for outliers: create dummy variables of size n of 0s except the index of the observation number and add this dummy variable to the model reject if p-value < 0.05).
7. If preliminary analysis showed discrepancies (e.g. outliers), remove those observations if significant and perform variable selection/penalization using the new dataset. Then perform diagnostics check and remove significant discrepancies from the original dataset. The new dataset will be the final dataset to train the model.

**Model Selection & Regularization**
1. Criteria: Cp, AIC/BIC, adjR2
2. Minimum value gives the best model subset of the full fit

**Model.matrix**
1. To be used when the fit involves matrices and not dataframes
2. Dummy variables needed when calculating vcov matrix

**Hypothesis Testing**
1. Two sided test: If abs(Tbeta1) > tn-2(alpha / 2), reject H0; otherwise, do not reject. 
2. One sided test: <img width="281" alt="Screenshot 2022-09-26 at 4 18 32 PM" src="https://user-images.githubusercontent.com/68551564/192227658-86e424f7-f726-4bd9-a5f3-e508f7be1672.png">, for (1), if Tbeta1 > tn-2(alpha), reject H0; otherwise, do not reject. For (2), if Tbeta1 < -tn-2(alpha), reject H0, otherwise do not reject.
3. T statistic e.g Tbeta0 = (beta0hat - beta0) / SE(beta0hat) 
4. F statistic (1-MSE) / MSE (If F exceeds the upper alpha quantile f1,n-1(alpha), the null hypothesis is rejected at level alpha, otherwise it is not.
5. P-value: Reject when < alpha
6. Confidence interval containing 0
