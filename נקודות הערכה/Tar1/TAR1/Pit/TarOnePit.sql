-- 1
-- SELECTS total earnings per category for month july & august.
SELECT		cat.name, 
			SUM(pay.amount) AS earnings
FROM 		category cat
INNER JOIN 	film_category flmcat 	ON
			flmcat.category_id = cat.category_id
INNER JOIN  film                    ON
            film.film_id = flmcat.film_id  
INNER JOIN 	inventory inv 		 	ON
			inv.film_id = film.film_id
INNER JOIN	rental rnt				ON
			inv.inventory_id = rnt.inventory_id
INNER JOIN	payment pay			 	ON
			pay.rental_id = rnt.rental_id
WHERE 		DATE_PART('month', rnt.rental_date) IN (7, 8)
GROUP BY 	cat.category_id
ORDER BY	earnings DESC
LIMIT       5;


-- 2
-- SELECTS movies labeled "must" and profit from each one.
SELECT 		film.title		AS film_title,  
			SUM(pay.amount) AS earnings
FROM 		film
INNER JOIN 	inventory inv ON
			inv.film_id = film.film_id
LEFT JOIN 	rental rnt	  ON
			rnt.inventory_id = inv.inventory_id
LEFT JOIN 	payment pay	  ON
			pay.rental_id = rnt.rental_id
WHERE 		film.fulltext::TEXT ~ '.*(''must'':1[4-6]).*'
GROUP BY 	film.film_id
ORDER BY 	earnings DESC NULLS LAST;


-- 3
-- SELECTS the store with the most delays.
SELECT		inv.store_id, 
			COUNT(rnt.rental_id) AS rents_late
FROM		film
INNER JOIN 	inventory inv 	ON
			inv.film_id = film.film_id
INNER JOIN 	rental rnt		ON
			rnt.inventory_id = inv.inventory_id
WHERE 		((rnt.return_date::DATE - rnt.rental_date::DATE) > film.rental_duration)        OR
			((rnt.return_date IS NULL)                                                  AND
			((NOW()::DATE -  rnt.rental_date::DATE) > film.rental_duration))
GROUP BY	inv.store_id
ORDER BY	rents_late DESC
LIMIT 1;

-- Another Option
SELECT		inv.store_id, 
			COUNT(rnt.rental_id) AS rents_late
FROM		film
INNER JOIN 	inventory inv 	ON
			inv.film_id = film.film_id
INNER JOIN 	rental rnt		ON
			rnt.inventory_id = inv.inventory_id
WHERE 		COALESCE(rnt.return_date, NOW()) - rnt.rental_date > INTERVAL '1' DAY * film.rental_duration
GROUP BY	inv.store_id
ORDER BY	rents_late DESC
LIMIT 1;

-- 4
-- SELECTS movies earnings/movie acted in for each actor.
SELECT 		act.first_name || ' ' || act.last_name		AS actor_name, 
			ROUND(SUM(pay.amount) / 
				  COUNT(DISTINCT film.film_id), 2) 	AS avg_earn_per_movie
FROM		actor act
INNER JOIN 	film_actor flmact ON
			flmact.actor_id = act.actor_id
INNER JOIN	film			  ON
			film.film_id = flmact.film_id
INNER JOIN 	inventory inv 	  ON
			inv.film_id = flmact.film_id
LEFT JOIN 	rental rnt 		  ON
			rnt.inventory_id = inv.inventory_id
LEFT JOIN 	payment pay 	  ON
			pay.rental_id = rnt.rental_id
GROUP BY 	act.actor_id
ORDER BY 	avg_earn_per_movie DESC;

