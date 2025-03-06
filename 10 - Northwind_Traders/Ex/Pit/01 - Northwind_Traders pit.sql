-- 1
-- מה תפקיד העובד הכי בכיר?
--ANSERS: Vice President, Sales
SELECT 		employee_id,
			title,
			reports_to
FROM 		employees
ORDER BY 	employee_id ASC;

-- 2
-- כמה לקוחות מזמינים הזמנות לעיר שונה מעיר כתובת הבית שלהם?
--ANSERS: 1
SELECT 		cus.customer_id, COUNT(ord.order_id)
FROM 		shippers shp
INNER JOIN	orders ord		ON
			ord.ship_via = shp.shipper_id
INNER JOIN	customers cus	ON 
			cus.customer_id = ord.customer_id
WHERE 		NOT ord.ship_city = cus.city
GROUP BY	cus.customer_id;

-- 3
-- מה הכמות הכי גדולה של מכירות למוצר מספק יחיד?
--ANSERS: 54
SELECT		sup.company_name		AS supplier,
			prd.product_name,
			COUNT(ordt.order_id)	AS ord_amount
FROM 		order_details ordt 
INNER JOIN	products prd	ON
			prd.product_id = ordt.product_id
INNER JOIN	suppliers sup 	ON
			sup.supplier_id = prd.supplier_id
GROUP BY 	sup.supplier_id, prd.product_id
ORDER BY	ord_amount DESC;

-- 4
-- מה הזמן (בימים) הממוצע לאורך הזמנה רצוי?
--ANSERS: 27.88
SELECT		AVG(required_date - order_date)
FROM		orders;

-- 5
-- כמה מוצרים יש שלא נמכרו מעולם?
--ANSERS: 2
SELECT 		prd.product_id
FROM		products prd
LEFT JOIN 	order_details ordt	ON
			ordt.product_id = prd.product_id
WHERE 		ordt.order_id ISNULL;

-- 6
-- איזה עובד מכר מגוון הכי גדול של מוצרים? מכר הכי הרבה מוצרים שונים?
--ANSERS: Margaret Peacock
SELECT 		emp.first_name || ' ' || emp.last_name	AS employee,
			COUNT(DISTINCT ordt.product_id)			AS diversity,
			emp.salary
FROM 		products prd
INNER JOIN	order_details ordt	ON 
			ordt.product_id = prd.product_id
INNER JOIN	orders ord 			ON 
			ord.order_id = ordt.order_id
INNER JOIN	employees emp		ON 
			emp.employee_id = ord.employee_id
GROUP BY	emp.employee_id
ORDER BY	diversity DESC;

-- 7
-- האם יש מוצרים שבעמודת units_on_order רשום שהוזמנו אך לא נמצאים ברשימת ההזמנות? 
--ANSERS: כן
SELECT 		prd.product_id,
			prd.units_on_order,
			ordt.order_id
FROM		products prd
LEFT JOIN	order_details ordt	ON
			ordt.product_id = prd.product_id
WHERE		prd.units_on_order != 0 AND 
			ordt.order_id ISNULL;

--8
--כמה לקוחות לא ביצעו הזמנה מעולם?
--ANSERS: 2
SELECT		cus.customer_id
FROM		customers cus
LEFT JOIN	orders ord	ON
			cus.customer_id = ord.customer_id
WHERE		ord.customer_id IS NULL;


--9
--האם יש עובדים שלא שלחו הזמנה מימיהם? 
--ANSERS: כן
SELECT		emp.employee_id,
			COUNT(ord.order_id)	AS count_of_orders
FROM		employees emp
LEFT JOIN	orders ord ON
			emp.employee_id = ord.employee_id	
GROUP BY	emp.employee_id
ORDER BY	count_of_orders ASC;