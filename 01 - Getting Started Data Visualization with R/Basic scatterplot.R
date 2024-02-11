set.seed(955)
# Make some noisily increasing data
dat <- data.frame(xvar = 1:20 + rnorm(20,sd=3),
                  yvar = 1:20 + rnorm(20,sd=3),
                  zvar = 1:20 + rnorm(20,sd=3))
dat


# Plot the points using the vectors xvar and yvar
plot(dat$xvar, dat$yvar)

# Same as previous, but with formula interface
plot(yvar ~ xvar, dat)

# Add a regression line
fitline <- lm(dat$yvar ~ dat$xvar)
abline(fitline)
