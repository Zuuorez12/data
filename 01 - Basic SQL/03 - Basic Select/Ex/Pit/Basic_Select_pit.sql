-- 1
SELECT 	empno, 
		firstname, 
		lastname, 
		deptno, 
		hiredate, 
		job, 
		edlevel, 
		sex, 
		birthdate,
	    salary, 
		bonus, 
		comm
FROM	liat.t_empl;

-- 2
SELECT 	 deptno,
		 deptname, 
		 mgrno, 
		 admrdept
FROM	 liat.t_depart
ORDER BY deptno DESC;

-- 3
-- SELECTS employees that their salary is less then 20000 or
-- more then 60000.
SELECT 	firstname, 
		lastname
FROM	liat.t_empl
WHERE	(salary > 60000)	OR
	    (salary < 20000);

-- 4
-- SELECTS female employees that their salary is more 
-- then 25000.
SELECT 	 firstname, 
		 lastname, 
		 salary
FROM	 liat.t_empl
WHERE	 (sex = 'F')		AND
	     (salary > 25000)
ORDER BY lastname DESC, salary ASC;

-- 5
-- SELECTS all departments without a manager.
SELECT	deptname 
FROM	liat.t_depart
WHERE	mgrno IS NULL;

-- 6
-- SELECTS salary with 10 percent increase.
SELECT	salary * 1.10
FROM 	liat.t_empl;

-- 7
-- SELECTS all the employees that there salary and bonus is more then
-- 25000 and start working after 01/01/1975.
SELECT	 firstname, 
		 lastname, 
		 hiredate
FROM 	 liat.t_empl
WHERE 	 ((salary+bonus) > 25000)	AND
		 (hiredate > '01/01/1975')
ORDER BY firstname DESC, hiredate ASC;

-- 8
-- SELECTS female employees and edlevel of employees that their salary 
-- is more then 2000 per month.
SELECT	lastname, 
		edlevel
FROM 	liat.t_empl
WHERE 	((salary / 12) > 2000)	AND
	 	(sex = 'F');
