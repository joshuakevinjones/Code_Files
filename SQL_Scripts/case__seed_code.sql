

/* CASE Expressions: Simple
Simple CASE expressions correlate a list of values to a list of
alternatives. For example: */

SELECT u.name,
	CASE u.open_to_public
		WHEN 'y' THEN 'Welcome!'
		WHEN 'n' THEN 'Go Away!'
		ELSE 'Bad code!'
	END AS column_alias
FROM upfall u;

/*
Simple CASE expressions are useful when you can directly link
an input value to a WHEN clause by means of an equality con-
dition. If no WHEN clause is a match, and no ELSE is specified,
the expression returns null */

/* CASE Expressions: Searched
Searched CASE expressions associate a list of alternative return
values with a list of true/false conditions. They also allow you
to implement an IS NULL test. For example: */

SELECT u.name,
	CASE
		WHEN u.open_to_public = 'y' THEN 'Welcome!'
		WHEN u.open_to_public = 'n' THEN 'Go Away!'
		WHEN u.open_to_public IS NULL THEN 'Null!'
		ELSE 'Bad code!'
	END AS column_alias
FROM upfall u;

/* Null is returned when no condition is TRUE and no ELSE is
specified. If multiple conditions are TRUE, the first-listed con-
dition takes precedence. */