--1
SELECT 		emp.first_name || ' ' || emp.last_name	AS employee, 
			CASE 
				WHEN rep.title_of_courtesy = 'Dr.'  THEN 'Doctor' 
				WHEN rep.title_of_courtesy = 'Mr.'  THEN 'Mister' 
				WHEN rep.title_of_courtesy = 'Ms.'  THEN 'Miss'
				WHEN rep.title_of_courtesy = 'Mrs.' THEN 'Mistress'
				ELSE '' 
			END || ' ' || rep.last_name 			AS "reports to"			
FROM 		employees emp
LEFT JOIN 	employees rep ON 
			rep.employee_id = emp.reports_to;

--2
SELECT		CASE
				WHEN notes ~ '\sBA\s' THEN 'BA'
				ELSE 'Other'
			END 								AS "Degree",
			COUNT(DISTINCT emp.employee_id) 	AS "employees",
			COUNT(ord.order_id)
FROM 		employees emp
LEFT JOIN	orders ord ON
			emp.employee_id = ord.employee_id
GROUP BY	"Degree";

-- 3 
SELECT		CASE
				WHEN cst.contact_title ~* 'manager'	THEN 'manager'
				ELSE 'employee'
			END 													AS job,
			ROUND(COUNT(CASE 
							WHEN ord.required_date < ord.shipped_date THEN 1 
						END) / 
				  COUNT(ord.order_id)::NUMERIC * 100, 2)  || '%'	AS late_ord
FROM		customers cst
INNER JOIN	orders ord	ON
			ord.customer_id = cst.customer_id		
GROUP BY	job;

-- 4
SELECT		title,
			CASE
				WHEN AGE(hire_date, birth_date) < INTERVAL '35 years' 									THEN 'young hire'
				WHEN AGE(hire_date, birth_date) BETWEEN INTERVAL '35 years' 
					AND INTERVAL '50 years'																THEN 'middle aged hire'
				WHEN AGE(hire_date, birth_date) > INTERVAL '50 years' 									THEN 'old hire'						
			END 					AS hire_status,
			ROUND(AVG(salary), 2) 	AS avg_salary
FROM		employees
GROUP BY	ROLLUP(title, hire_status)
ORDER BY	title ASC, hire_status ASC;

-- 5
SELECT		emp.title_of_courtesy ||' '|| emp.last_name 						 AS emp_name,
			emp.country,
			ROUND((COUNT(CASE 
							WHEN ord.ship_country = emp.country THEN 1
						 END)::NUMERIC / COUNT(ord.order_id)) * 100, 2) 		 AS order_percent_to_home_country	
FROM		employees emp
INNER JOIN	orders ord	ON
			ord.employee_id = emp.employee_id
GROUP BY	emp.employee_id
ORDER BY	order_percent_to_home_country DESC;