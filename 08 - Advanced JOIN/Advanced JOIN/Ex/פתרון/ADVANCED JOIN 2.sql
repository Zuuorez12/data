-- 1
-- SELECT top 10 countries with the largest amount of customers
SELECT		cnt.country,
			COUNT(cus.customer_id) 		AS customers
FROM 		customer cus
INNER JOIN	address adr	ON
			adr.address_id = cus.address_id
INNER JOIN 	city 		ON 
			city.city_id = adr.city_id
INNER JOIN 	country cnt	ON 
			cnt.country_id = city.country_id
GROUP BY	cnt.country_id
ORDER BY 	customers DESC
LIMIT 		10;

-- 2
-- SELECTS Inventory status (store, movie, total rents) 
SELECT   	inv.store_id 				AS store,
		  	film.title 					AS film_name,
		  	COUNT(rent.rental_id) 		AS rents
FROM      	film
INNER JOIN	inventory inv			ON
		  	inv.film_id = film.film_id
LEFT JOIN 	rental rent	ON
		  	inv.inventory_id = rent.inventory_id
GROUP BY  	store, film.film_id
ORDER BY 	store ASC, rents DESC;

-- 3
-- SELECTS How much customer from each city and revenue per city
SELECT    	city.city, 
		    COUNT(DISTINCT cust.customer_id) 	AS customers,
		    SUM(pay.amount) 					AS total_payments
FROM        city
LEFT JOIN   address adr		ON
		    city.city_id = adr.city_id
LEFT JOIN  customer cust	ON
		    adr.address_id = cust.address_id
LEFT JOIN   payment pay		ON
		    pay.customer_id = cust.customer_id
GROUP BY    city.city_id
ORDER BY    total_payments DESC NULLS LAST, customers ASC;

-- 4
-- SELECTS the amount of unpayed rents per customer
SELECT 		cus.first_name || ' ' || cus.last_name	AS cus_name, 
			COUNT(rnt.rental_id) 					AS amount_of_unpayed
FROM		customer cus
INNER JOIN 	rental rnt		ON
			cus.customer_id = rnt.customer_id
LEFT JOIN	payment pay		ON
			pay.rental_id = rnt.rental_id
WHERE 		pay.payment_id ISNULL
GROUP BY 	cus.customer_id
ORDER BY 	amount_of_unpayed DESC;

-- 5
-- SELECT late returners(which customer,their phone number,
-- how many days late, which movie and it's fulltext)
SELECT 	   	cust.first_name || ' ' || cust.last_name 	                        AS customer,
		   	film.title, 
		   	film.fulltext,
	       	EXTRACT(DAY FROM NOW() - rent.rental_date)  - rent.rental_duration	AS days_late,
		   	adr.phone
FROM       	customer cust
LEFT JOIN	address adr		ON
		   	adr.address_id = cust.address_id
INNER JOIN 	rental rent		ON
		   	rent.customer_id = cust.customer_id
INNER JOIN 	inventory inv	ON
		   	inv.inventory_id = rent.inventory_id
INNER JOIN 	film				ON
	       	film.film_id = inv.film_id
WHERE 	   	(EXTRACT(DAY FROM NOW() - rent.rental_date) > film.rental_duration) AND
		   	(rent.return_date IS NULL)
ORDER BY   	days_late DESC;