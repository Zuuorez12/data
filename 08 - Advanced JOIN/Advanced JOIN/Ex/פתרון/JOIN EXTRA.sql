
--1. SELECTS actors who played at least 10 R rated films
SELECT 		act.first_name || ' ' || act.last_name 	AS "Actor Name", 
			COUNT(film.film_id) 					AS "Films"
FROM 		actor act
INNER JOIN 	film_actor flmact 	ON 
			flmact.actor_id = act.actor_id
INNER JOIN 	film 				ON 
			film.film_id = flmact.film_id
WHERE 		rating = 'R'
GROUP BY 	act.actor_id
HAVING 		COUNT(film.film_id) >= 10;


--2. SELECTS avg rental rate and number of rents from each genre 
SELECT 		cat.name 						AS "Category", 
			ROUND(AVG(film.rental_rate), 2) AS "Avg Rental Rate", 
			COUNT(rnt.rental_id) 			AS "Rents"
FROM 		category cat
INNER JOIN 	film_category flmcat ON 
			flmcat.category_id = cat.category_id
INNER JOIN 	film 				 ON 
			film.film_id = flmcat.film_id
LEFT JOIN 	inventory inv 		 ON 
			inv.film_id = film.film_id
LEFT JOIN 	rental rnt 			 ON 
			rnt.inventory_id = inv.inventory_id
GROUP BY 	cat.category_id;


--3. SELECTS MIN, MAX and AVG time takes between movie return to payment
SELECT 		MIN(pay.payment_date::DATE - rnt.return_date::DATE) 			AS "Min days", 
			MAX(pay.payment_date::DATE - rnt.return_date::DATE) 			AS "Max days", 
			ROUND(AVG(pay.payment_date::DATE - rnt.return_date::DATE), 2) 	AS "Avg days"
FROM 		rental rnt
INNER JOIN 	payment pay ON 
			pay.rental_id = rnt.rental_id
WHERE 		rnt.return_date IS NOT NULL;

