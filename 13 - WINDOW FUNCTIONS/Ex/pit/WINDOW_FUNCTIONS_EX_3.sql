-- 1. SELECTS for each product its price, sum prices of all the products in its category 
--and average price of all the products in its category
SELECT		cat.category_name,
			pro.product_name,
			pro.unit_price,
			ROUND((SUM(pro.unit_price)	OVER cat_g)::NUMERIC, 2)	AS pro_sum,
			ROUND((AVG(pro.unit_price) 	OVER cat_g)::NUMERIC, 2)	AS pro_avg
FROM		products pro
INNER JOIN	categories cat	ON
			pro.category_id = cat.category_id
WINDOW		cat_g AS (PARTITION BY	cat.category_id);


-- 2. SELECTS for each city the average age diff between the youngest employee to the
--rest of the employees, and the average salary in the city
--only for cities with more than 1 employee
WITH
	age_by_city(employee_id, city,salary, age_diff)
AS
	(
		SELECT		employee_id,
                    city,
					salary,
					AGE(birth_date) - 
						FIRST_VALUE(AGE(birth_date)) OVER	(
																PARTITION BY	city
																ORDER BY		AGE(birth_date) ASC
															)
		FROM		employees
	)

--- Main Query ---

SELECT		city,
			AVG(CASE WHEN age_diff > INTERVAL '00:00:00' THEN age_diff END)	 	AS avg_age_diff,
			ROUND(AVG(salary), 2)												AS avg_salary
FROM		age_by_city abc
GROUP BY	city
HAVING      COUNT(employee_id) > 1;


-- 3. SELECTS for each customer his percentage from his country's incomes, the company's
--name and the country's name. Order the company by country in ascending order
WITH
	sales_per_customer(company_name, country, sum_sales)
AS
	(
		SELECT		cus.company_name,
					cus.country,
					SUM(or_det.unit_price * or_det.quantity * (1 - or_det.discount))::NUMERIC
		FROM		order_details or_det
		INNER JOIN	orders	ord		ON
					ord.order_id = or_det.order_id	
		RIGHT JOIN	customers cus	ON
					cus.customer_id = ord.customer_id	
		GROUP BY	cus.customer_id
	)

--- Main Query ---

SELECT		company_name,
			country,
			ROUND((sum_sales / 
				  SUM(sum_sales) OVER	(
					  						PARTITION BY 	country		
				  					  	)) * 100, 2) AS percent_from_country
FROM		sales_per_customer
ORDER BY	country ASC, percent_from_country ASC;