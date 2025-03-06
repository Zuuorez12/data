--1. SELECT avg products for category
WITH 
	prod_by_category(count_product) 
AS 
	(
		SELECT 		COUNT(product_id)
		FROM 		products
		GROUP BY	category_id
	)
	
------------- Main Query -------------

SELECT		'avg products for category' 	AS "category", 
			ROUND(AVG(count_product), 2) 	AS "avg"
FROM		prod_by_category;


--2. SELECT US states with customers & number of customers
WITH
	country_count(country, customer_count)
AS
	(
		SELECT		country,
					COUNT(customer_id)
		FROM		customers
		GROUP BY	country	
	)
	
--- Main Query ---
SELECT		country,
			ROUND(customer_count - 	(
										SELECT		AVG(customer_count)
										FROM		country_count	
									), 2) AS diff_avg_customer_count
FROM		country_count
ORDER BY	diff_avg_customer_count DESC;


--3. SELECTS orders and days until they shipped above employee personal avg
--           for each employee
WITH
	employee_gap_days(employee_id, avg_gap_len)
AS
	(
		SELECT		employee_id,
					AVG(shipped_date - order_date)
		FROM		orders
		GROUP BY	employee_id
	)

---------- MAIN QUERY ----------- 

SELECT		emp.first_name ||' '|| emp.last_name	AS employee,
			ord.order_id,
			ord.shipped_date - ord.order_date		AS days_before_shipping
FROM		employees emp
INNER JOIN	orders ord		ON
			ord.employee_id = emp.employee_id
LEFT JOIN	employee_gap_days egd	ON
			egd.employee_id = emp.employee_id
WHERE		(ord.shipped_date - ord.order_date) > egd.avg_gap_len::NUMERIC
ORDER BY 	emp.employee_id ASC, days_before_shipping DESC;


--4. SELECTS for all products who sold at a final price above any of the top 10 orders on
--           the "Avg Item Price index", product name, num of sales above, total sales
WITH 
	prod_ord_total(product_id, total_orderd) 
AS 
	(
		SELECT		product_id, 
					COUNT(order_id)
		FROM 		order_details 
		GROUP BY	product_id
	)
	
------------- Main Query -------------
	
SELECT 		prod.product_name, 
			COUNT(ord_det.order_id)	AS order_count, 
			MAX(prod_ord_total.total_orderd)
FROM 		order_details ord_det
INNER JOIN	products prod 	ON
			prod.product_id = ord_det.product_id
LEFT JOIN 	prod_ord_total 	ON
			prod_ord_total.product_id = prod.product_id
WHERE 		ord_det.unit_price * 
			ord_det.quantity * 
			(1 - ord_det.discount) > ANY	(
												SELECT 		SUM(unit_price * quantity * (1 - discount)) / 
																COUNT(product_id) AS item_avg_price
												FROM 		order_details
												GROUP BY	order_id
												ORDER BY	item_avg_price DESC
												LIMIT 		10
											) 
GROUP BY 	prod.product_id;


--5. SELECT Côte de Blaye order rate by month
WITH 
	prod_month_orders(year, jan, feb, mar, apr, may, jun, jul, aug, sep, oct, nov, dec) 
AS
	(
		SELECT 		DATE_PART('year', ord.order_date) AS order_year,
					COUNT(CASE WHEN DATE_PART('month', ord.order_date) = '01' THEN 1 END) AS "JAN",
					COUNT(CASE WHEN DATE_PART('month', ord.order_date) = '02' THEN 1 END) AS "FEB",
					COUNT(CASE WHEN DATE_PART('month', ord.order_date) = '03' THEN 1 END) AS "MAR",
					COUNT(CASE WHEN DATE_PART('month', ord.order_date) = '04' THEN 1 END) AS "APR",
					COUNT(CASE WHEN DATE_PART('month', ord.order_date) = '05' THEN 1 END) AS "MAY",
					COUNT(CASE WHEN DATE_PART('month', ord.order_date) = '06' THEN 1 END) AS "JUN",
					COUNT(CASE WHEN DATE_PART('month', ord.order_date) = '07' THEN 1 END) AS "JUL",
					COUNT(CASE WHEN DATE_PART('month', ord.order_date) = '08' THEN 1 END) AS "AUG",
					COUNT(CASE WHEN DATE_PART('month', ord.order_date) = '09' THEN 1 END) AS "SEP",
					COUNT(CASE WHEN DATE_PART('month', ord.order_date) = '10' THEN 1 END) AS "OCT",
					COUNT(CASE WHEN DATE_PART('month', ord.order_date) = '11' THEN 1 END) AS "NOV",
					COUNT(CASE WHEN DATE_PART('month', ord.order_date) = '12' THEN 1 END) AS "DEC"
		FROM		products prod 
		LEFT JOIN	order_details ord_det	ON
					prod.product_id = ord_det.product_id 
		LEFT JOIN	orders ord 				ON
					ord_det.order_id = ord.order_id
		WHERE		prod.product_name = 'Côte de Blaye'
		GROUP BY	DATE_PART('year', ord.order_date)
	)

------------- Main Query -------------

SELECT 		ROUND(AVG(jan), 2) AS january, 
			ROUND(AVG(feb), 2) AS february, 
			ROUND(AVG(mar), 2) AS march,
			ROUND(AVG(apr), 2) AS april,   
			ROUND(AVG(may), 2) AS may,      
			ROUND(AVG(jun), 2) AS june,
			ROUND(AVG(jul), 2) AS july,    
			ROUND(AVG(aug), 2) AS august,   
			ROUND(AVG(sep), 2) AS september,
			ROUND(AVG(oct), 2) AS october, 
			ROUND(AVG(nov), 2) AS november, 
			ROUND(AVG(dec), 2) AS december
FROM 		prod_month_orders;