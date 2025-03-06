-- 1
-- SELECTS an international scale for each actor
SELECT		act.first_name || ' ' || act.last_name 				AS actor_name,
			ROUND(COUNT(rnt.rental_id) /
                  COUNT(DISTINCT city.country_id)::NUMERIC, 2) 	AS international_scale
FROM		actor act		
INNER JOIN	film_actor flm_act 	ON
			act.actor_id = flm_act.actor_id
INNER JOIN	film 				ON
			film.film_id = flm_act.film_id
INNER JOIN	inventory inv		ON
			inv.film_id = film.film_id
INNER JOIN	rental rnt			ON
			inv.inventory_id = rnt.inventory_id
INNER JOIN	customer cus		ON
			cus.customer_id = rnt.customer_id
INNER JOIN	address adr			ON
			adr.address_id = cus.address_id
INNER JOIN	city				ON
			adr.city_id = city.city_id
GROUP BY	act.actor_id
ORDER BY	international_scale DESC
LIMIT		10;

-- 2
-- SELECTS rents made in the release date for each employee
SELECT		stf.first_name ||' '|| stf.last_name AS staff_name,
			COUNT(rnt.rental_id) 				 AS rentals	
FROM		film
INNER JOIN	inventory inv 	ON
			film.film_id = inv.film_id
INNER JOIN	rental rnt 		ON
			inv.inventory_id = rnt.inventory_id
INNER JOIN	staff stf		ON
			rnt.staff_id = stf.staff_id
WHERE		DATE_PART('year', rnt.rental_date) = film.release_year
GROUP BY	stf.staff_id;


--3
-- SELECTS all the films that exist in the inventory but have not been rented
SELECT		film.title,
			REGEXP_REPLACE(film.description, 'an', 'na', 'gi')	AS replaced_description
FROM		film
INNER JOIN	inventory inv		ON
			inv.film_id = film.film_id
LEFT JOIN	rental rnt			ON
			inv.inventory_id = rnt.inventory_id
GROUP BY	film.film_id
HAVING		COUNT(rnt.rental_id) = 0;
 

-- 4	
-- SELECTS customers that have not paid for their rentals and calculates a fine for them
SELECT		cus.first_name || ' ' || cus.last_name 						    AS customer_name,
			cus.email,
			ROUND(SUM(film.rental_rate) * 
				  AVG(rnt.return_date::DATE - rnt.rental_date::DATE), 2)		AS fine_sum
FROM		film
INNER JOIN	inventory inv 	ON
			film.film_id = inv.film_id
INNER JOIN	rental rnt		ON
			rnt.inventory_id = inv.inventory_id
INNER JOIN	customer cus	ON
			cus.customer_id = rnt.customer_id
LEFT JOIN	payment pay 	ON
			rnt.rental_id = pay.rental_id
WHERE		(pay.payment_id IS NULL)	AND
			(rnt.return_date IS NOT NULL)
GROUP BY	cus.customer_id			
ORDER BY	fine_sum DESC;			
						
			

									