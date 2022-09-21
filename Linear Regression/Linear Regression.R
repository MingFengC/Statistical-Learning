# Applied Questions ISLR

## Q8a

library(ISLR2)
library(fastDummies)

y <- Auto$mpg
x <- Auto$horsepower
lm.fit <- lm(y ~ x)
summary(lm.fit)

xnew <- data.frame(x = 98)
confint(lm.fit, level = 0.95)
predict(lm.fit, newdata = xnew, interval = "prediction")


We observe that the p-value < 2e-16 < 0.05, thus we can reject H0 conclude that the predictor and response do have a relationship.
The relationship is strong as the p-value < 2.2e-16 < 0.05
The relationship between the predictor and response is negative

## Q8b

plot(x, y)
abline(lm.fit)
plot(lm.fit)

# Q9a

pairs(Auto)

## Q9b

Auto.new <- Auto[, -ncol(Auto)]
Auto.d <- dummy_cols(Auto.new, select_columns = 'origin', remove_selected_columns = TRUE)
cor(Auto.d)

## Q9c

Auto.new$origin <- as.factor(Auto.new$origin)
lm.fit <- lm(mpg ~ ., data = Auto.new)
summary(lm.fit)

Yes since the p-value of the F-statistic is extremely small.
Significant predictors: Displacement, weight, year and origin.
It suggests that an increase of 1 model year increases the mpg by 77700.

## Q9D

plot(lm.fit)

From the residuals vs fitted plot, we observe slight non-linearity which could mean non-linearity in the data, most likely a quadratic trend. From the Q-Q plot, we observe 1 possible outlier observation 323. From the scale-location plot, we see that the variance of the residuals increases as the fitted values increases. From the leverage plot, we can see that observation 14 has significantly higher leverage than the other points.

## Q9e

lm.fit.int <- lm(mpg ~ .^2, data = Auto.new)
summary(lm.fit.int)

cylinders:acceleration and acceleration:year

## Q9f

lm.fit.log <- lm(sqrt(mpg) ~ . + I(horsepower^2), data = Auto.new)
summary(lm.fit.log)
plot(lm.fit.log)

We can perform a sqrt transformation on mpg to alleviate the issue where variance increases as fitted values increases. We can also apply a quadratic transformation to horsepower as there is a quadratic relationship from the scatterplot.

## Q10a

lm.fit <- lm(Sales ~ Price + Urban + US, data = Carseats)
summary(lm.fit)
plot(lm.fit)

## Q10b

Since UrbanYes has a negative coefficient, an urban store has fewer sales as compared to rural stores, however the difference is not significant as the p-value is larger than 0.05.

Since USYes has a positive coefficient, a US store has higher sales as compared to stores which are not in the US, the difference is significant as the p-value is small.

## Q10c

Sales = -0.054459Price -0.021916Urban + 1.200573US, where Urban = 1 if store is urban and US = 1 if store is in the US

## Q10d

lm.fit <- lm(Sales ~ ., data = Carseats)
summary(lm.fit)

We can reject CompPRice, Income, Advertising, Price, Shelve and age.

## Q10e

lm.fit <- lm(Sales ~ Population + Education + Urban + US, data = Carseats)
summary(lm.fit)
plot(lm.fit)

From a, the R2 is 0.2393 while the R2 from e is 0.03465. The model from a is able to explain 23.93% of the variation seen in the Sales while the model from e is only able to explain 3.465% of the variation seen in Sales.

## Q10g

confint(lm.fit)

## Q10h

plot(lm.fit)

We observe that there are no obvious outliers or points with high leverage.



























