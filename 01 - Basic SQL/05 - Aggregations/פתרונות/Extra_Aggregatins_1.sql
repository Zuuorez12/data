-- 1
-- SELECTS hiredate before a month and 10 days for employees in E11 department
SELECT	firstname ||' '|| lastname 				AS emp_name,
		hiredate,
		hiredate - INTERVAL '1 month 10 day' 	AS fixed_hiredate
FROM	liat.t_empl
WHERE	(deptno = 'E11');	
			
-- 2
-- SELECTS amount of projects, avg staff amount and min prendate
-- for each department with less then 3 employees on avg in a project
SELECT		deptno,
			COUNT(projno) 	AS project_amount,
			AVG(prstaff)	AS avg_prstaff,
			MIN(prendate)	AS min_prendate
FROM		liat.t_proj	
GROUP BY	deptno
HAVING		AVG(prstaff) < 3;

-- 3
-- SELECTS for each hire age the avg bonus
SELECT		DATE_PART('YEAR', AGE(hiredate, birthdate)) AS hire_age,
			ROUND(AVG(bonus))							AS avg_bonus
FROM		liat.t_empl
GROUP BY	hire_age
ORDER BY	hire_age ASC;

-- 4
-- SELECTS amount of female employees with salary higher than 10000, their avg salary
-- their max bonus and the min hire age
SELECT		COUNT(empno) 										AS employee_amount,
			AVG(salary)  										AS avg_salary,
			MAX(bonus)											AS max_bonus,
			MIN(EXTRACT(YEAR FROM AGE(hiredate, birthdate)) * 12 +
				EXTRACT(MONTH FROM AGE(hiredate, birthdate))) 	AS min_hire_age
FROM		liat.t_empl
WHERE		(salary > 10000) AND
			(sex = 'F');
