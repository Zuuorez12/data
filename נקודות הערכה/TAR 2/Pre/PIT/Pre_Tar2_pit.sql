--1

WITH
	monthly_sum_per_emp(employee_id,ord_year, ord_month, diff)
AS
	(
		SELECT		ord.employee_id,
					DATE_PART('year', ord.order_date)	AS ord_year,
					DATE_PART('month', ord.order_date) 	AS ord_month,
					SUM(ord_det.unit_price * ord_det.quantity * (1 - ord_det.discount)) - 
						LAG(SUM(ord_det.unit_price * ord_det.quantity * (1 - ord_det.discount))) OVER 	
														(
                                                            PARTITION BY 	ord.employee_id
                                                            ORDER BY		DATE_PART('year', ord.order_date) ASC, 
                                                                            DATE_PART('month', ord.order_date) ASC
														)
		FROM		order_details ord_det
		INNER JOIN	orders	ord		ON
					ord.order_id = ord_det.order_id	
		GROUP BY	ord.employee_id, ord_year, ord_month
	)
	
--- Main Query ---

SELECT		emp.first_name || ' ' || emp.last_name 	AS employee_name,
			ROUND(AVG(mdiff.diff::NUMERIC), 2)		AS avg_improvment
FROM		employees emp
LEFT JOIN	monthly_sum_per_emp mdiff ON
			mdiff.employee_id = emp.employee_id
GROUP BY	emp.employee_id;


-- 2

WITH
	salary_steps(employee_name, count_orders, salary_step)
AS
	(
		SELECT		emp.first_name || ' ' || emp.last_name,
					COUNT(ord.order_id),
					NTILE(3) OVER 	(
									    ORDER BY salary DESC 
							  		)
		FROM		employees emp
		LEFT JOIN	orders ord		ON
					emp.employee_id = ord.employee_id
		GROUP BY	emp.employee_id
	)

--- Main Query ---
SELECT		employee_name,
			sal.salary_step,
			ROUND(count_orders / SUM(count_orders) OVER (
														    PARTITION BY sal.salary_step
														) *100, 2) || '%' 	AS orders_precent
FROM		salary_steps sal;

-- another option
WITH
	monthly_sum_per_emp(employee_id, ord_year, ord_month, amount)
AS
	(
		SELECT		ord.employee_id,
					DATE_PART('year', ord.order_date)	AS ord_year,
					DATE_PART('month', ord.order_date) 	AS ord_month,
					SUM(ord_det.unit_price * ord_det.quantity * (1 - ord_det.discount)) 
		FROM		order_details ord_det
		INNER JOIN	orders	ord		ON
					ord.order_id = ord_det.order_id	
		GROUP BY	ord.employee_id, ord_year, ord_month
	),
	diff_per_month(employee_id, diff)
AS
	(
		SELECT		employee_id,
					amount - LAG(amount) OVER (
												PARTITION BY 	employee_id
												ORDER BY		ord_year ASC, ord_month ASC
											  )
		FROM		monthly_sum_per_emp
	)
	
--- Main Query ---

SELECT		emp.first_name || ' ' || emp.last_name 	AS employee_name,
			ROUND(AVG(mdiff.diff::NUMERIC), 2)		AS avg_improvment
FROM		employees emp
LEFT JOIN	diff_per_month mdiff ON
			mdiff.employee_id = emp.employee_id
GROUP BY	emp.employee_id;


--3
SELECT      CASE
                WHEN cst.country = emp.country THEN 'COUNTRY MATCHES'
                ELSE 'COUNTRY DOESNT MATCH'
            END AS "match",
			COUNT(ord.order_id) AS order_count
FROM        customers cst 
INNER JOIN  orders ord  	ON
            cst.customer_id =  ord.customer_id
INNER JOIN  employees emp   ON
            emp.employee_id =  ord.employee_id
WHERE       cst.country IN	(
                                SELECT  country
                                FROM    employees
                           	)
GROUP BY    "match";

--4
SELECT      title,
            first_name || ' ' || last_name 				AS emp_name,
            ROUND((salary / 
				   AVG(salary) OVER	(
                                        PARTITION BY    title
                                        ORDER BY        hire_date
                                        RANGE BETWEEN INTERVAL '6 months'  
                                        PRECEDING AND INTERVAL '6 months' 
                                        FOLLOWING
				   					)), 2)	            AS salary_ratio
FROM        employees emp
WHERE		title IN	(
                            SELECT      title
                            FROM        employees
                            GROUP BY    title
                            HAVING      COUNT(employee_id) > 1
                       	);


