-- Pit.sql
-- 1
-- SELECTS number of projects per departments.
SELECT   	deptno, 
		 	COUNT(projno) AS project_count
FROM     	liat.t_proj
GROUP BY 	deptno;

-- 2
-- SELECTS departments with avg edlevel bigger then 16.
SELECT   	deptno, 
		 	AVG(edlevel) AS avg_edlevel
FROM     	liat.t_empl
GROUP BY 	deptno
HAVING   	AVG(edlevel) > 16;

-- 3
-- SELECTS number of employees per department and bonus.
SELECT   	deptno, 
			bonus, 
			COUNT(empno) AS emp_count
FROM     	liat.t_empl
GROUP BY 	deptno, bonus
ORDER BY 	bonus DESC;

-- 4
-- SELECTS number of men with bonus bigger then 500.
SELECT   	bonus, 
		 	COUNT(empno) AS emp_count
FROM     	liat.t_empl
WHERE    	(bonus > 500) AND 
         	(sex = 'M')
GROUP BY 	bonus;

-- 5
-- SELECTS number of employees per sex and department.
SELECT   	deptno, 
		 	sex, 
		 	COUNT(empno) AS emp_count
FROM     	liat.t_empl
GROUP BY 	deptno, sex
ORDER BY	deptno ASC;

-- 6
-- SELECTS max salary of clerks per department.
SELECT   	deptno, 
		 	MAX(salary) AS max_salary
FROM     	liat.t_empl
WHERE    	job = 'CLERK'
GROUP BY 	deptno
HAVING   	COUNT(deptno) >= 2;

-- 7
-- SELECTS min, avg and max salary per department.  
SELECT   	deptno, 
		 	MIN(salary) AS min_salary, 
		 	AVG(salary) AS avg_salary, 
		 	SUM(salary) AS sum_salary
FROM     	liat.t_empl
GROUP BY 	deptno
HAVING   	AVG(salary) < 35000;
