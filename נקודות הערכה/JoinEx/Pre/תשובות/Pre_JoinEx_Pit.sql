--1
--SELECTS payment and diversity of rentals data for heavy consumers
SELECT		cus.first_name || ' ' || cus.last_name	AS full_name,
			ROUND(COUNT(DISTINCT inv.film_id)::NUMERIC /
				   	COUNT(rnt.rental_id), 2)		AS diversity
FROM 		customer cus
INNER JOIN 	rental rnt		ON
			rnt.customer_id = cus.customer_id
INNER JOIN	inventory inv 	ON 
			inv.inventory_id = rnt.inventory_id
GROUP BY 	cus.customer_id
HAVING 		COUNT(rnt.rental_id) > 40;

--2
--SELECTS amont of rentals for each mannager in each store
SELECT 		mng.first_name || ' ' || mng.last_name	AS manager,
			COUNT(rnt.rental_id)					AS "rentals_by manager"
FROM		staff mng
INNER JOIN 	store str		ON 
			mng.staff_id = str.manager_staff_id
LEFT JOIN 	inventory inv	ON 
			inv.store_id = str.store_id
LEFT JOIN 	rental rnt 		ON 
			inv.inventory_id = rnt.inventory_id
WHERE 		mng.staff_id = rnt.staff_id 
GROUP BY 	str.store_id, mng.staff_id;

--3
--SELECTS amont of rentals for each country that has 5-15 customers
SELECT 		cnt.country,
			COUNT(rnt.rental_id)	AS amount_of_sales
FROM		country cnt
INNER JOIN	city ct 		ON
			ct.country_id = cnt.country_id
INNER JOIN	address adr		ON
			adr.city_id = ct.city_id
INNER JOIN	customer cus	ON
			cus.address_id = adr.address_id
LEFT JOIN 	rental rnt	ON
			rnt.customer_id = cus.customer_id
GROUP BY	cnt.country_id
HAVING		COUNT(DISTINCT cus.customer_id) BETWEEN 5 AND 15
ORDER BY 	amount_of_sales ASC
LIMIT 10;

--4
--SELECTS Three most rented categories
SELECT		cat.name,
			COUNT(rnt.rental_id)	AS rentals_amount
FROM		category cat
INNER JOIN	film_category f_cat	ON
			f_cat.category_id = cat.category_id
INNER JOIN	inventory inv		ON
			inv.film_id = f_cat.film_id
INNER JOIN	rental rnt			ON
			rnt.inventory_id = inv.inventory_id
GROUP BY	cat.category_id
ORDER BY	rentals_amount DESC
LIMIT		3;