-- 1
-- SELECTS for each actor the amount of payed orders
SELECT		stf.first_name || ' ' || stf.last_name 	AS staff_name,
			COUNT(DISTINCT rnt.rental_id) 			AS count_payed_rents
FROM		payment pay 
INNER JOIN	rental rnt	ON
			pay.rental_id = rnt.rental_id
RIGHT JOIN	staff stf	ON
			stf.staff_id = rnt.staff_id
GROUP BY	stf.staff_id;



-- 2 
-- SELECTS for each country its amount of customers whose address ends with 7
-- and 'a' appears twice in the second word
SELECT		cnt.country,
			COUNT(cus.customer_id) AS customer_count
FROM		customer cus 
INNER JOIN	address adr		ON
			cus.address_id = adr.address_id
INNER JOIN	city			ON
			city.city_id = adr.city_id
INNER JOIN	country	cnt		ON
			cnt.country_id = city.country_id
WHERE		address ~* '^\d*7\s\w*a\w*a' 
GROUP BY	cnt.country_id
ORDER BY	customer_count ASC;



-- 3 
-- SELECTS for each actor the ratio between their rentals to the customer amount
SELECT		act.first_name || ' ' || act.last_name 					AS actor_name,
			COUNT(rnt.rental_id) / COUNT(DISTINCT cus.customer_id)	AS rental_customer_ratio		
FROM		actor act
INNER JOIN	film_actor flmact 	ON
			act.actor_id = flmact.actor_id
INNER JOIN	film				ON
			film.film_id = flmact.film_id
INNER JOIN	inventory inv		ON
			inv.film_id = film.film_id
INNER JOIN	rental rnt			ON
			inv.inventory_id = rnt.inventory_id
INNER JOIN	customer cus		ON
			cus.customer_id = rnt.customer_id
GROUP BY	act.actor_id;



-- 4
-- SELECTS total loss of unreturnd rented movies for each store.
SELECT		inv.store_id 					AS store, 
			SUM(film.replacement_cost)  	AS lost
FROM 		inventory inv
INNER JOIN 	film 		ON 
			film.film_id = inv.film_id
INNER JOIN 	rental rnt 	ON
			rnt.inventory_id = inv.inventory_id
WHERE 		rnt.return_date IS NULL
GROUP BY 	store;




