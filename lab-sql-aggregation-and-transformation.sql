USE sakila;
-- Challenge 1
-- 1. You need to use SQL built-in functions to gain insights relating to the duration of movies:
-- 1.1 Determine the **shortest and longest movie durations** 
-- and name the values as `max_duration` and `min_duration`.
SELECT MAX(length) AS max_duration FROM film;
SELECT MIN(length) AS min_duration FROM film;
-- 1.2. Express the **average movie duration in hours and minutes**. 
-- Don't use decimals. Hint: Look for floor and round functions.
SELECT ROUND(AVG(length)) AS avg_duration_in_min FROM film;
SELECT CONCAT(LPAD(FLOOR(ROUND(AVG(length)) / 60), 2, '0'), ':', LPAD(ROUND(AVG(length)) % 60, 2, '0')) AS avg_duration_formatted FROM film;
-- 2. You need to gain insights related to rental dates:
-- 2.1 Calculate the *number of days that the company has been operating*.
-- Hint: To do this, use the `rental` table, and the `DATEDIFF()` function
-- to subtract the earliest date in `rental_date` column from latest date.
SELECT DATEDIFF(MAX(rental_date), MIN(rental_date)) AS operating_days FROM rental;
-- 2.2 Retrieve rental information and add two additional columns to show
-- the **month and weekday of the rental**. Return 20 rows of results.
SELECT *, MONTH(rental_date) AS month_of_rental, DAYOFWEEK(rental_date) AS weekday_of_rental FROM rental LIMIT 20;
-- 2.3 Bonus: Retrieve rental information and add an additional column
-- called `DAY_TYPE` with values **'weekend' or 'workday'**, 
-- depending on the day of the week.* Hint: use a conditional expression.
SELECT *, 
	CASE
		WHEN DAYOFWEEK(rental_date) < 6 THEN "weekday"
        ELSE "weekend"
	END AS weekday_of_rental
FROM rental
-- 3. Ensure that customers can easily access information about movie collection. 
-- To achieve this, retrieve the **film titles and their rental duration**. 
-- If any rental duration value is NULL, replace it with string 'Not Available'.
-- Sort the results of the film title in ascending order.
-- *Please note: even if there are currently no null values in rental duration column, 
-- the query should still be written to handle such cases in the future.*
-- *Hint: Look for the `IFNULL()` function.*
SELECT inventory_id, DATEDIFF(return_date, rental_date) AS rental_duration FROM rental
