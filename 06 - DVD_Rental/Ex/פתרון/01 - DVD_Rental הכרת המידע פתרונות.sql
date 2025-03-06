--1
-- ?מה כמות הסרטים שאורכם יותר מ-120 דקות 
SELECT 	COUNT(film_id)
FROM 	film
WHERE 	length > 120;

--2
-- ?מה הסרט שתעריפו המוגדר הכי גבוה
SELECT		title
FROM		film
ORDER BY	rental_rate DESC
LIMIT 1;

--3
-- ?כמה פריטי מלאי זמינים בכל חנות
SELECT 		store_id,
			COUNT(inventory_id)	AS count_of_inventory_id
FROM    	inventory
GROUP BY	store_id;

--4
--- מה הם המזהים של שלושת השחקנים המובילים ביותר?
--כלומר השחקנים שכמות הסרטים שעשו היא הגבוהה ביותר
SELECT		actor_id,
			COUNT(film_id)	AS count_of_movies
FROM		film_actor	
GROUP BY	actor_id
ORDER BY	count_of_movies DESC
LIMIT 3;

---6
-- ?מהו סך התשלום הגבוה ביותר שנעשה? ומהו מזהה הלקוח שביצע זאת
SELECT		customer_id,
			SUM(amount)	AS total_payment
FROM		payment		
GROUP BY	customer_id
ORDER BY	total_payment DESC
LIMIT 1;

---7
--?האם יש סרטים שיש להם כמה קטגוריות
SELECT		film_id,
			COUNT(category_id)	AS amount_of_categories
FROM		film_category
GROUP BY	film_id
HAVING		COUNT(category_id) > 1 ;
		
--8
--מצא את העובד שטיפל בהכי הרבה תשלומים
SELECT     staff_id ,
		   COUNT(payment_id) AS total_handle_payment
FROM	   payment
GROUP BY   staff_id
ORDER BY   total_handle_payment DESC
LIMIT 1;


--9
---?לכמה תשלומים לא קיים תאריך תשלום
SELECT	COUNT(payment_id)	AS count_of_payments
FROM	payment
WHERE	payment_date IS NULL



-- כמה הזמנות ששילמו עליהן ביותר מתשלום יחיד יש?
-- 10
SELECT		rental_id,
			COUNT(payment_id) AS cus_amount
FROM 		payment
GROUP BY 	rental_id
HAVING		COUNT(payment_id) > 1;
-- או --
SELECT      rental_id,
            COUNT(rental_id) AS rental_payments
FROM        payment
GROUP BY    rental_id
ORDER BY    rental_payments DESC;


-- 11
-- חיקרו את הלקוח הרביעי ברשימת הלקוחות בעלי הכי הרבה השכרות. האם יש לו השכרה שלא הוחזרה? של איזה סרט?
-- Alone Trip
SELECT 		customer_id, 
			COUNT(rental_id) AS amount
FROM		rental
GROUP BY 	customer_id
ORDER BY	amount DESC;

SELECT 		rental_id, rental_date, return_date, inventory_id, customer_id
FROM 		rental
WHERE 		customer_id = 236 AND return_date ISNULL;

SELECT 		inventory_id, film_id
FROM 		inventory
WHERE 		inventory_id = 81;

SELECT 		film_id, title
FROM 		film
WHERE 		film_id = 17;


-- 13
-- מה כמות העותקים לסרט המקסימלית לחנות?
-- 13
SELECT 		store_id,
			film_id, 
			COUNT(inventory_id) AS copies
FROM 		inventory
GROUP BY	store_id, film_id
ORDER BY	copies DESC;


-- 16
-- האם 'Betty White', 'Annie Russell', 'Rosa Reynolds', 'Elaine Stevens'
-- הן שחקניות, לקוחות, סרטים או עובדות?
-- לקוחות
SELECT 		customer_id
FROM 		customer
WHERE 		((first_name = 'Annie') 	AND (last_name = 'Russell'))	OR
			((first_name = 'Betty') 	AND (last_name = 'White'))		OR
			((first_name = 'Rosa') 		AND (last_name = 'Reynolds'))	OR
			((first_name = 'Elaine') 	AND (last_name = 'Stevens'));

SELECT 		actor_id
FROM 		actor
WHERE 		((first_name = 'Annie') 	AND (last_name = 'Russell'))	OR
			((first_name = 'Betty') 	AND (last_name = 'White'))		OR
			((first_name = 'Rosa') 		AND (last_name = 'Reynolds'))	OR
			((first_name = 'Elaine') 	AND (last_name = 'Stevens'));

SELECT 		staff_id
FROM 		staff
WHERE 		((first_name = 'Annie') 	AND (last_name = 'Russell'))	OR
			((first_name = 'Betty') 	AND (last_name = 'White'))		OR
			((first_name = 'Rosa') 		AND (last_name = 'Reynolds'))	OR
			((first_name = 'Elaine') 	AND (last_name = 'Stevens'));

SELECT 		film_id
FROM 		film
WHERE 		title IN ('Betty White', 'Annie Russell', 
					  'Rosa Reynolds', 'Elaine Stevens');

-- אופציה נוספת
SELECT		first_name ||' '|| last_name AS name
FROM		staff
WHERE		first_name ||' '|| last_name IN ('Betty White', 'Annie Russell', 'Rosa Reynolds', 'Elaine Stevens')

-- 18
-- מה אורך הסרט (בדקות) ללא טריילרים בתוכו, 
-- בעל אורך ההשכרה האפשרי מהקטנים, מתוך הסרטים בעלי מחיר ההשכרה הכי גבוה?
-- 144
SELECT 		title, "length", special_features, rental_rate, rental_duration
FROM		film
WHERE 		NOT (special_features::TEXT LIKE '%Trailers%')
ORDER BY 	rental_rate DESC, rental_duration ASC;


-- 19
-- האם יש אותו הלקוח פעמיים בטבלה בחנויות שונות?
SELECT 		first_name || last_name || email || address_id 	AS new_cus_id
FROM 		customer
GROUP BY 	new_cus_id
HAVING		COUNT(store_id) > 1;
