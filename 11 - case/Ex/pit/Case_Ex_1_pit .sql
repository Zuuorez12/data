--1.
-- SELECTS a count of orders of each delivery duration type
SELECT		CASE 	
				WHEN (required_date - order_date) > 28 				THEN 'long' 
			 	WHEN (required_date - order_date) BETWEEN 21 AND 28 	THEN 'medium' 
				WHEN (required_date - order_date) < 21 				THEN 'short' 
			END 			AS delivery_duration,
			COUNT(order_id) AS order_count
FROM		orders
GROUP BY	delivery_duration;

--2.
-- SELECTS the avg freight in orders of every customer's abbreviation
SELECT		CASE
				WHEN cus.contact_name ~* '^[A-M]' THEN REGEXP_REPLACE(cus.contact_name, '^\w+\s', 'A ')
				WHEN cus.contact_name ~* '^[N-Z]' THEN REGEXP_REPLACE(cus.contact_name, '\w+$', 'Z')
			END 									AS contact_abbreviation,
			ROUND(AVG(ord.freight)::DECIMAL, 2) 	AS avg_freight
FROM		customers cus
INNER JOIN	orders ord ON
			ord.customer_id = cus.customer_id
GROUP BY	cus.customer_id
ORDER BY	contact_abbreviation ASC;

--3.
-- SELECTS a frequency distribution table of orders freight groups
SELECT		CASE
				WHEN freight < 101 					THEN '0 - 100' 
				WHEN freight BETWEEN 101 AND 201  	THEN '101 - 200' 
				WHEN freight BETWEEN 201 AND 301  	THEN '201 - 300' 
				WHEN freight BETWEEN 301 AND 401  	THEN '301 - 400'
				WHEN freight BETWEEN 401 AND 501  	THEN '401 - 500'
				WHEN freight BETWEEN 501 AND 601  	THEN '501 - 600'
				WHEN freight BETWEEN 601 AND 701  	THEN '601 - 700'
				WHEN freight BETWEEN 701 AND 801  	THEN '701 - 800'
				WHEN freight BETWEEN 801 AND 901  	THEN '801 - 900'
				WHEN freight BETWEEN 901 AND 1001 	THEN '901 - 1000'
				WHEN freight > 1000  				THEN '1000 <'
			END 			AS "freight range",
			COUNT(order_id) AS "Orders"
FROM 		orders
GROUP BY	"freight range"
ORDER BY	MIN(freight) ASC;

--4.
-- SELECTS Pivot Table of employees sales per month in 1996
SELECT 		CASE
				WHEN emp.first_name || ' ' || emp.last_name IS NULL   THEN 'Total'
				ELSE emp.first_name || ' ' || emp.last_name 
			END 																   AS employee,
			COUNT(CASE WHEN DATE_PART('month', ord.order_date) = '01' THEN 1 END) AS "January",
			COUNT(CASE WHEN DATE_PART('month', ord.order_date) = '02' THEN 1 END) AS "February",
			COUNT(CASE WHEN DATE_PART('month', ord.order_date) = '03' THEN 1 END) AS "March",
			COUNT(CASE WHEN DATE_PART('month', ord.order_date) = '04' THEN 1 END) AS "April",
			COUNT(CASE WHEN DATE_PART('month', ord.order_date) = '05' THEN 1 END) AS "May",
			COUNT(CASE WHEN DATE_PART('month', ord.order_date) = '06' THEN 1 END) AS "June",
			COUNT(CASE WHEN DATE_PART('month', ord.order_date) = '07' THEN 1 END) AS "July",
			COUNT(CASE WHEN DATE_PART('month', ord.order_date) = '08' THEN 1 END) AS "August",
			COUNT(CASE WHEN DATE_PART('month', ord.order_date) = '09' THEN 1 END) AS "September",
			COUNT(CASE WHEN DATE_PART('month', ord.order_date) = '10' THEN 1 END) AS "October",
			COUNT(CASE WHEN DATE_PART('month', ord.order_date) = '11' THEN 1 END) AS "November",
			COUNT(CASE WHEN DATE_PART('month', ord.order_date) = '12' THEN 1 END) AS "December",
			COUNT(ord.order_id) 												   AS "Total Orders"
FROM		employees emp
LEFT JOIN	orders ord ON 
			ord.employee_id = emp.employee_id
WHERE		DATE_PART('year', ord.order_date) = '1996'
GROUP BY	ROLLUP(emp.first_name || ' ' || emp.last_name);

--5.
-- SELECTS List of suppliers from usa, australia, uk and france and their international phone number
SELECT	company_name, 
		contact_name, 
		city, 
		CASE 
			WHEN country = 'USA'		THEN '+1'
			WHEN country = 'UK'			THEN '+44'
			WHEN country = 'Australia' 	THEN '+61'
			WHEN country = 'France' 	THEN '+33'
		END || ' - ' || REGEXP_REPLACE(phone, '\D', '', 'g') AS "international phone"
FROM 	suppliers
WHERE 	country IN ('USA', 'France', 'UK', 'Australia');