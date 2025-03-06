-- Pit.sql
-- 1
-- SELECTS avg salary of department E01.
SELECT	AVG(salary) AS avg_salary
FROM 	liat.t_empl
WHERE 	deptno = 'E01';

-- 2
-- SELECTS the sum salaries of females.
SELECT 	SUM(salary + bonus) AS sum_payments
FROM 	liat.t_empl
WHERE 	sex = 'F';

-- 3
-- SELECTS the first and the last hiredates.
SELECT 	MIN(hiredate)   AS min_hiredate, 
		MAX(hiredate)   AS max_hiredate
FROM	liat.t_empl;

-- 4
-- SELECTS avg, max, min and number of employees of department A00.
SELECT 	AVG(salary) 	AS avg_salary, 
		MAX(salary) 	AS max_salary, 
		MIN(salary) 	AS min_salary, 
		COUNT(empno) 	AS emp_count
FROM 	liat.t_empl
WHERE 	deptno = 'A00';

-- 5
-- SELECTS name, job and age of employees with 
-- job name with length between 4 to 5.
SELECT 	firstname, 
		lastname,
		job, 
		AGE(birthdate)  AS "age"
FROM 	liat.t_empl
WHERE 	LENGTH(job) BETWEEN 4 AND 5;


-- 6
-- SELECTS name, hiredate and salary of employees 
-- started work in 1972 between jan to june. 
SELECT 	firstname, 
		lastname, 
		hiredate,
		salary
FROM 	liat.t_empl
WHERE 	DATE_TRUNC('month', hiredate) BETWEEN '1972-01-01' AND '1972-06-01';

-- 7
-- SELECTS name and number of months he worked.
SELECT 		firstname, 
			(EXTRACT(YEAR from AGE(NOW(),hiredate)) * 12) + 
                       (EXTRACT(MONTH from AGE(NOW(), hiredate)))   AS month_between
FROM 		liat.t_empl
ORDER BY 	month_between;

-- 8
-- SELECTS max difference between hiredate to birthdate by weeks.
SELECT 	MAX(hiredate - birthdate) / 7   AS max_diff
FROM 	liat.t_empl
WHERE 	(deptno LIKE 'A%') 	OR
		(deptno LIKE 'D%')	OR
		(deptno LIKE '%01');



