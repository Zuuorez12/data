
-- 4
--SELECT only the paid rentals and the date the movie was rented and the date of payment
SELECT		rnt.rental_id,
			rnt.rental_date,
			pay.payment_date
FROM		rental rnt
INNER JOIN	payment pay	ON
			rnt.rental_id = pay.rental_id;

-- 5
-- SELECTS top 10 actors who acted in the most movies
SELECT 		act.first_name || ' ' || act.last_name	AS actor,
			COUNT(filact.film_id) 					AS movies_played
FROM		actor act 
INNER JOIN	film_actor filact ON 
			filact.actor_id = act.actor_id
GROUP BY	act.actor_id
ORDER BY 	movies_played DESC
LIMIT 10;

-- 6
-- SELECTS the amount of rentals each employee commited
SELECT		stf.first_name || ' ' || stf.last_name	AS staff,
			COUNT(rnt.rental_id)					AS rents_amount
FROM 		staff stf
LEFT JOIN 	rental rnt	ON
			rnt.staff_id = stf.staff_id
GROUP BY	stf.staff_id;

-- 7
-- SELECTS movies per every language
SELECT		lan.name			AS lang,
			COUNT(film.film_id)	AS films
FROM 		"language" lan
LEFT JOIN	film ON 
			lan.language_id = film.language_id
GROUP BY 	lan.language_id;