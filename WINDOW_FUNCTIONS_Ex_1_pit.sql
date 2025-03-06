/*Q1
SELECTS employee info, and average bonus for each employee 
where the salary is 10,000 below and above the employee salary.
*/
SELECT		dpt.deptname 							AS "department name",
			emp.firstname ||' '|| emp.lastname 		AS "employee name",
			emp.salary,
			emp.bonus,
			ROUND(AVG(emp.bonus) OVER	(
											PARTITION BY	dpt.deptno
											ORDER BY		emp.salary
											RANGE BETWEEN 	10000 PRECEDING 
											AND 10000 FOLLOWING
								 		), 2) 		AS "avg_bonus"
								 
FROM		liat.t_empl emp
INNER JOIN	liat.t_depart dpt	ON
			emp.deptno = dpt.deptno;


/*Q2
SELECTS department name and employee name where the difference 
of the highest salary in the department and the current salary 
is higher than a third of the current salary.
*/
-- Option 1 with FIRST_VALUE()
WITH
	emp(deptno, "employee name", "third of salary", "diff from high")
AS
	(
		SELECT		deptno,
					firstname ||' '|| lastname 				AS "employee name", 
					salary / 3 								AS "third of salary",
					FIRST_VALUE(salary) OVER 	(	
													PARTITION BY 	deptno 
													ORDER BY		salary DESC
												) - salary	AS "diff from high"
		FROM		liat.t_empl
	)

------ Main Query ------
	
SELECT 		dpt.deptname,
			emp."employee name"
FROM		emp
INNER JOIN	liat.t_depart dpt	ON
			emp.deptno = dpt.deptno
WHERE		"diff from high" < "third of salary";

-- Option 2 with MAX()
WITH
	emp(deptno, "employee name", "third of salary", "diff from high")
AS
	(
		SELECT		deptno,
					firstname ||' '|| lastname 		AS "employee name", 
					salary / 3 						AS "third of salary",
					MAX(salary) OVER 	(	
											PARTITION BY 	deptno 
										) - salary	AS "diff from high"
		FROM		liat.t_empl
	)

------ Main Query ------
	
SELECT 		dpt.deptname,
			emp."employee name"
FROM		emp
INNER JOIN	liat.t_depart dpt	ON
			emp.deptno = dpt.deptno
WHERE		"diff from high" < "third of salary";


/*Q3
SELECTS department name, employee name and rank of salary, where 
the employee salary is higher than twice the lowest salary.
*/
-- Option 1 with FIRST_VALUE()
WITH
	emp_info("department name", "employee name", salary, "twice the lowest salary")
AS
	(
		SELECT		dpt.deptname 							AS "department name", 
					emp.firstname ||' '|| emp.lastname 		AS "employee name",
					emp.salary,
					FIRST_VALUE(emp.salary) OVER 	(	
														PARTITION BY 	dpt.deptname 
														ORDER BY		emp.salary ASC
													) * 2	AS "twice the lowest salary"
		FROM		liat.t_empl emp
		INNER JOIN	liat.t_depart dpt	ON
					emp.deptno = dpt.deptno
	)

------ Main Query ------
	
SELECT		"department name", 
			"employee name"
FROM		emp_info
WHERE		salary > "twice the lowest salary";

-- Option 2 with LAST_VALUE()
WITH
	emp_info("department name", "employee name", salary, "twice the lowest salary")
AS
	(
		SELECT		dpt.deptname 							AS "department name", 
					emp.firstname ||' '|| emp.lastname 		AS "employee name",
					emp.salary,
					LAST_VALUE(emp.salary) OVER 	(	
														PARTITION BY 	dpt.deptname 
														ORDER BY		emp.salary DESC
														ROWS BETWEEN UNBOUNDED PRECEDING 
														AND UNBOUNDED FOLLOWING
													) * 2	AS "twice the lowest salary"
		FROM		liat.t_empl emp
		INNER JOIN	liat.t_depart dpt	ON
					emp.deptno = dpt.deptno
	)

------ Main Query ------
	
SELECT		"department name", 
			"employee name"
FROM		emp_info
WHERE		salary > "twice the lowest salary";

-- Option 3 with MIN()
WITH
	emp_info("department name", "employee name", salary, "twice the lowest salary")
AS
	(
		SELECT		dpt.deptname 							AS "department name", 
					emp.firstname ||' '|| emp.lastname 		AS "employee name",
					emp.salary,
					MIN(emp.salary) OVER 	(	
												PARTITION BY 	dpt.deptname
											) * 2  			AS "twice the lowest salary" 
		FROM		liat.t_empl emp
		INNER JOIN	liat.t_depart dpt	ON
					emp.deptno = dpt.deptno
	)

------ Main Query ------

SELECT		"department name", 
			"employee name"
FROM		emp_info
WHERE		salary > "twice the lowest salary";


/*Q4
SELECTS for every job the average ed level and the majority of the sex in every job. 
If equel shows Female.
*/
WITH 
	emp_data(job,sex,emp_count)
AS
	(
		SELECT 		job,
                    sex, 
					COUNT(emp.empno) AS emp_count
		FROM 		liat.t_empl emp
		GROUP BY 	job,sex
	),

	emp_rank(gender_rank, job, sex)
AS
 	(
		SELECT 	ROW_NUMBER() OVER 	(
										PARTITION BY job 
										ORDER BY emp_count DESC, sex ASC
									) AS gender_rank,
				emp_data.job,
				emp_data.sex
		FROM 	emp_data
	)

------------ MAIN QUERY ------------

SELECT 		emp_r.job,
			(
				SELECT 	ROUND(AVG(edlevel), 2) AS ed_avg
				FROM    liat.t_empl emp
				WHERE   emp_r.job = emp.job
			),
			emp_r.sex
FROM		emp_rank emp_r
WHERE 		emp_r.gender_rank = 1
ORDER BY 	ed_avg ASC;