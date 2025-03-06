-- 1
SELECT		pro.product_name, 
			pro.unit_price, 
			pro.units_in_stock,
			COUNT(ord.order_id)	AS ord_count
FROM		products pro
INNER JOIN	order_details orde	ON
			pro.product_id = orde.product_id
INNER JOIN	orders ord			ON
			ord.order_id = orde.order_id
WHERE		(ord.ship_postal_code ~ '\D-.+') AND
			(pro.category_id IN	(
									SELECT	category_id
									FROM	categories
									WHERE	CHAR_LENGTH(description) > 20
								))
GROUP BY	pro.product_id
ORDER BY	ord_count DESC; 

--2 
WITH
	order_count(employee_id, product_id, order_year, jul, aug, sep)
AS
	(
		SELECT		ord.employee_id,
					orde.product_id,
					EXTRACT(YEAR FROM ord.order_date)	                               AS order_year,
					COUNT(CASE WHEN EXTRACT(MONTH FROM ord.order_date) = 7 THEN 1 END) AS jul,
					COUNT(CASE WHEN EXTRACT(MONTH FROM ord.order_date) = 8 THEN 1 END) AS aug,
					COUNT(CASE WHEN EXTRACT(MONTH FROM ord.order_date) = 9 THEN 1 END) AS sep
		FROM		orders ord
		INNER JOIN	order_details orde	ON
					ord.order_id = orde.order_id
		GROUP BY	order_year, ord.employee_id, orde.product_id
	)
	
--- Main Query ---

SELECT		emp.first_name ||' '|| emp.last_name 	AS employee_name,
			pro.product_name,
			ROUND(AVG(jul), 2)						AS avg_ord_jul,
			ROUND(AVG(aug), 2)						AS avg_ord_aug,
			ROUND(AVG(sep), 2)						AS avg_ord_sep
FROM		employees emp
INNER JOIN	order_count orc ON
			emp.employee_id = orc.employee_id
INNER JOIN	products pro	ON
			pro.product_id = orc.product_id
GROUP BY	emp.employee_id, pro.product_id
ORDER BY	employee_name ASC, pro.product_name ASC;
			
-- 3
WITH
	sum_quantity_per_product(category_id, product_name, sum_quantity)
AS
	(
		SELECT		prd.category_id,
					prd.product_name,
					CASE
                        WHEN SUM(ord.quantity) IS NULL THEN 0 ELSE SUM(ord.quantity)
                    END
		FROM		products prd
		LEFT JOIN	order_details ord	ON
					ord.product_id = prd.product_id
		GROUP BY	prd.product_id
	),

	sum_quantity_per_category(category_id, category_name, sum_quantity)
AS
	(
		SELECT		cat.category_id,
					cat.category_name,
					SUM(ord.quantity)
		FROM		order_details ord
		INNER JOIN	products prd	ON
					ord.product_id = prd.product_id
		INNER JOIN	categories cat	ON
					cat.category_id = prd.category_id
		GROUP BY	cat.category_id
	)
	
--- Main Query ---

SELECT		cat.category_name,
			prd.product_name,
			ROUND((prd.sum_quantity::NUMERIC / 
				   cat.sum_quantity) * 100, 2)  AS percent_quantity
FROM		sum_quantity_per_product prd
INNER JOIN	sum_quantity_per_category cat	ON
			prd.category_id = cat.category_id
ORDER BY	cat.category_name ASC, percent_quantity ASC;