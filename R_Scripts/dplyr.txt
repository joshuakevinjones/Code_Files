# dplyr
suppressMessages(library(dplyr))


# Dplyr aims to provide a function for each basic verb of data manipulation:
	# filter() (and slice())
	# arrange()
	# select() (and rename())
	# distinct()
	# mutate() (and transmute())
	# summarise()
	# sample_n() (and sample_frac())
	
library(nycflights13)
dim(flights) # flights is the df
head(flights)

	# filter
		# subsetting
		filter(flights, month == 1, day == 1)
		filter(flights, month == 1 | month == 2)
	
		# equivalent in base R
		flights[flights$month == 1 & flights$day == 1, ]

	# slice
		# select rows by position
		slice(flights, 1:10)

	# arrange
		# reorder rows
		arrange( flights, year, month, day)
		arrange( flights, desc(arr_delay))
		
	# select
		# select columns
		select(flights, year, month, day)
		select(flights, year:day)
		select(flights, -(year:day))
		
			# use with helper functions
			starts_with()
			ends_with()
			matches()
		
		# rename
		select(flights, tail_num = tailnum)
		rename(flights, tail_num = tailnum) # easier
		
	# distinct
		distinct(flights, tailnum)
		distinct(flights, origin, dest)
		
	# mutate
		# add new columns
		mutate(flights,
			gain = arr_delay - dep_delay,
			speed = distance / air_time * 60)
		
		# refer to columns that you just created
			# this is a benefit over base::transform()
		mutate(flights,
			gain = arr_delay - dep_delay,
			gain_per_hour = gain / (air_time / 60)
			)
			
		# transmute
			# like mutate, but only keeps the new variables you created
			transmute(flights,
			  gain = arr_delay - dep_delay,
			  gain_per_hour = gain / (air_time / 60)
			  )
			  
	# summarise
		# collapses data frame into a single rows
		summarise(flights,
			delay = mean(dep_delay, na.rm = TRUE))
			
	# sample_n and sample_frac
		# sample_n takes a random sample of n rows
		# sample_frac uses a fixed fraction
		
		sample_n(flights, 10)
		sample_frac(flights, 0.01)
			
# GROUPED OPERATIONS			
	# Grouping affects the verbs as follows:
		# grouped select() is the same as ungrouped select(), except that grouping variables are always retained.
		# grouped arrange() orders first by the grouping variables
		# mutate() and filter() are most useful in conjunction with window functions (like rank(), or min(x) == x). They are described in detail in vignette("window-functions").
		# sample_n() and sample_frac() sample the specified number/fraction of rows in each group.
		# slice() extracts rows within each group.
		# summarise() is powerful and easy to understand, as described in more detail below.
	
	# example
	by_tailnum <- group_by(flights, tailnum)
		delay <- summarise(by_tailnum,
		count = n(),
		dist = mean(distance, na.rm = TRUE),
		delay = mean(arr_delay, na.rm = TRUE))
		delay <- filter(delay, count > 20, dist < 2000)
	
			
		# random example (ok to delete)
		by_ec  <- group_by(data, Earn.Code)
		summarise(by_ec, sum = sum(Gross.MTD))
	
		# ""
		by_earnCode <- data %>%
			group_by(Earn.Code, Year)
			
		summarise(by_earnCode, totalPay = sum(Gross.MTD, na.rm = TRUE))
			# appears to be using the group_by arguments to summarise
	
			# another way to do the same thing
			aggdata <- aggregate(MyData$Gross.MTD, by=list(MyData$Year, MyData$Descr), FUN=sum, na.rm=TRUE)
		
		# ""
		group <- summarise(by_earnCode,
			count = n(),
			sum = sum(Gross.MTD),
			average = mean(Gross.MTD))
	
	# summarise with aggregate functions
		# agg functions take a vector of values and return a single number/fraction
			min(), max(), mean(), sum(), sd(), median(), and IQR()
			n(), n_distinct(x), first(x), last(x), nth(x, n) --- provided through dplyr
			
			# find the number of planes and the number of flights that go to each possible destination
			destinations <- group_by(flights, dest)
				summarise(destinations,
				planes = n_distinct(tailnum),
				flights = n()
				)
				
	# summarise by multiple variables
		# each summary peels off one level of the grouping
		daily <- group_by(flights, year, month, day)
			(per_day   <- summarise(daily, flights = n()))
			(per_month <- summarise(per_day, flights = sum(flights)))
			(per_year  <- summarise(per_month, flights = sum(flights)))

# CHAINING
	
	# three ways to write same thing
	
	# 1
	a1 <- group_by(flights, year, month, day)
	a2 <- select(a1, arr_delay, dep_delay)
	a3 <- summarise(a2,
		arr = mean(arr_delay, na.rm = TRUE),
		dep = mean(dep_delay, na.rm = TRUE))
	a4 <- filter(a3, arr > 30 | dep > 30)
	
	# 2
	filter(
		summarise(
			select(
				group_by(flights, year, month, day),
				arr_delay, dep_delay
			),
			arr = mean(arr_delay, na.rm = TRUE),
			dep = mean(dep_delay, na.rm = TRUE)
		),
	arr > 30 | dep > 30
)
	
	# 3
	flights %>%
	  group_by(year, month, day) %>%
	  select(arr_delay, dep_delay) %>%
	  summarise(
		arr = mean(arr_delay, na.rm = TRUE),
		dep = mean(dep_delay, na.rm = TRUE)
	  ) %>%
	  filter(arr > 30 | dep > 30)