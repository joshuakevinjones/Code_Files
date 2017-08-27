# GLM
	# logit
	
	# logistic regression
		# useful to predict binary outcome from continuous or categorical predictor variables
	
	# GLM fits a function of the conditional mean response; LM fits the conditional mean response itself
	# basic form of GLM model
	glm(formula, family = family(link = function), data = )
	
#Family Default link function
binomial (link = "logit")
gaussian (link = "identity")
gamma (link = "inverse")
inverse.gaussian (link = "1/mu^2")
poisson (link = "log")
quasi (link = "identity", variance = "constant")
quasibinomial (link = "logit")
quasipoisson (link = "log")

# Y = response variable
# X1, X2, X3 = predictor variables
# mydata = data frame

	# logit application
		# situations in which response variable is dichotomous(0, 1)
	# assumptions
		# Y follows a binomial distribution
		
	# logic example
	glm(Y ~ X1 + X2 + X3, family = binomial(link = "logit"), data = mydata)
		
# glm() uses same supporting functions as lm()