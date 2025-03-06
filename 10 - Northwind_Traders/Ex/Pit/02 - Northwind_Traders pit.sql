--1. SELECT products ordered in 1996
SELECT 	   	DISTINCT prod.product_name
FROM       	order_details ord
INNER JOIN 	products prod	ON
		   	prod.product_id = ord.product_id
INNER JOIN 	orders ords		ON
		   	ords.order_id = ord.order_id
WHERE      	DATE_PART('YEAR', ords.order_date) = 1996;
	
--2. SELECT customers ordered by most orders
SELECT     cust.contact_name,
		   COUNT(ords.order_id) AS "orders"
FROM   	   orders ords
RIGHT JOIN customers cust	ON
		   cust.customer_id = ords.customer_id
GROUP BY   cust.customer_id
ORDER BY   orders DESC;

--3.SELECT product count for each product per supplier
SELECT 	   sup.contact_name 	  AS "sup_name",
		   cat.category_name	  AS "cat_name",
		   COUNT(prod.product_id) AS "pro_count"
FROM       suppliers sup
LEFT JOIN  products prod	ON
		   sup.supplier_id = prod.supplier_id
LEFT JOIN  categories cat	ON
		   cat.category_id = prod.category_id
GROUP BY   sup.supplier_id, cat.category_id
ORDER BY   "pro_count" DESC;

--4 SELECTS the sum income from each customer from france
SELECT		cus.company_name,
			ROUND(SUM(or_det.unit_price * 
					  or_det.quantity * 
					  (1 - or_det.discount))::NUMERIC, 2) AS sum_income
FROM		order_details or_det
INNER JOIN	orders	ord		ON
			ord.order_id = or_det.order_id	
RIGHT JOIN	customers cus	ON
			cus.customer_id = ord.customer_id
WHERE		cus.country = 'France'		
GROUP BY	cus.customer_id
ORDER BY	sum_income DESC NULLS LAST;
	   	