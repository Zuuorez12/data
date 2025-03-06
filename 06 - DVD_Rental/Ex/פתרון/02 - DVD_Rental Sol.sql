-- 1
-- SELECTS the average replacement cost of the
-- films longer then 2 hours(or equel).
SELECT	ROUND(AVG(replacement_cost), 2) AS avg_cost, 
		MIN(replacement_cost)			AS min_cost, 
		MAX(replacement_cost)			AS max_cost
FROM 	film
WHERE 	"length" >= 120;

-- 2
-- SELECTS the average of the length, rental rate, and rental duration
-- and coun the number of films.
SELECT	 	rating, 
		 	ROUND(AVG("length"), 2)			AS "avg length", 
		 	ROUND(AVG(rental_rate), 2)		AS "avg rental rate", 
		 	ROUND(AVG(rental_duration), 2)	AS "avg rental duration", 
		 	COUNT(film_id)					AS "films"
FROM 	 	film
GROUP BY 	rating;

-- 3
-- SELECTS the day of the week and counts the rentals
-- per day.
SELECT	 	DATE_PART('dow', rental_date) + 1 	AS "day", 
		 	COUNT(rental_id) 					AS "rents"
FROM	 	rental
GROUP BY 	"day"
ORDER BY 	"day" ASC;

-- 4
-- SELECTS the amount per month. 
SELECT	 	DATE_PART('month', payment_date) 	AS pay_month, 
		 	SUM(amount)							AS sum_amount
FROM	 	payment
GROUP BY 	pay_month
ORDER BY 	pay_month;
