--1
SELECT		CASE
				WHEN ord.freight < 50 				 THEN 'Light order'
				WHEN ord.freight BETWEEN 50 AND 101 THEN 'medium order'
				WHEN ord.freight > 100 				 THEN 'heavy order'
			END 	AS weight_category,
			COUNT(
				CASE 
					WHEN emp.title_of_courtesy IN ('Ms.', 'Mrs.') THEN 1
				END 
				 ) 	AS women,
			COUNT(
				CASE
					WHEN emp.title_of_courtesy = 'Mr.' THEN 1
				END
				 ) 	AS men,
			COUNT(
				CASE
					WHEN emp.title_of_courtesy NOT IN ('Ms.', 'Mrs.', 'Mr.') THEN 1
				END 
				 ) 	AS unknown
FROM		employees emp
INNER JOIN	orders ord ON
			emp. employee_id = ord.employee_id
GROUP BY 	weight_category;

-- 2
SELECT		CASE
				WHEN product_name ~ '^\w+$'				THEN 'one word'
				WHEN product_name ~ '^\w+\s\w+$'		THEN 'two words'
				WHEN product_name ~ '^(\w+\s){2}\w+$'	THEN 'three words'
				ELSE 'different length'
			END 							AS word_count,
			ROUND(AVG(units_in_stock),2) 	AS avg_units_in_stock,
			MAX(unit_price)					AS max_price
FROM		products
GROUP BY	word_count;


--3
SELECT  	COALESCE(boss.first_name || ' ' || boss.last_name, 'Total for Boss') 	AS boss_name,  
		    COALESCE(emp.first_name || ' ' || emp.last_name, 'Total for Boss') 		AS employee_name,  
		    COUNT(CASE WHEN ord.ship_country = 'USA' THEN 1 END) 					AS usa_count,  
		    COUNT(CASE WHEN ord.ship_country = 'UK' THEN 1 END) 					AS uk_count,  
		    COUNT(CASE WHEN ord.ship_country = 'Germany' THEN 1 END) 				AS germany_count  
FROM 		employees emp 
INNER JOIN  employees boss 	ON
			emp.reports_to = boss.employee_id  
LEFT JOIN 	orders ord 		ON
			ord.employee_id = emp.employee_id   
GROUP BY 	ROLLUP(boss.first_name || ' ' || boss.last_name,
				   emp.first_name || ' ' || emp.last_name)  
ORDER BY 	boss_name ASC, employee_name ASC;