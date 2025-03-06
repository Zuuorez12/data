-- 1.
-- SELECTS number of employees at each bonus level
SELECT   	bonus,
			COUNT(empno) 	AS "number of employees"
FROM     	liat.t_empl
GROUP BY 	bonus
ORDER BY	bonus DESC;


-- 2.
-- SELECTS number of projects under each project
SELECT	 	majproj, 
			COUNT(projno) 	AS "nummber of projects"
FROM	 	liat.t_proj
WHERE	 	majproj IS NOT NULL
GROUP BY 	majproj;


-- 3.
-- SELECTS number of employees and salary data for each job
SELECT 	 	job, 
			ROUND(AVG(salary), 2) 			AS "avg salary", 
		 	ROUND(AVG(bonus), 2) 			AS "avg bonus", 
		 	SUM(salary + bonus + comm) 		AS "salaries expense",
		 	COUNT(empno) 					AS "number of employees"
FROM 	 	liat.t_empl
GROUP BY 	job
ORDER BY 	"salaries expense" DESC, "number of employees" DESC;


-- 4.
-- SELECTS avg hire, number of employees and education level data for each department
SELECT    	deptno, 
			ROUND(AVG(DATE_PART('year',
                AGE(hiredate, birthdate))::INT), 2)     AS "avg hire age", 
		  	MIN(edlevel) 								AS "min ed level", 
		  	ROUND(AVG(edlevel), 2) 						AS "avg edlevel",
		  	MAX(edlevel) 								AS "max ed level", 
		  	COUNT(empno) 								AS "num of employees"
FROM      	liat.t_empl
GROUP BY  	deptno
HAVING	  	AVG(salary) > 28000
ORDER BY 	"avg hire age" DESC;


-- 5.
-- SELECTS number of employed Females & Males each day of the week
SELECT	 	DATE_PART('dow', hiredate) + 1 	AS "day in week", 
			sex, 
			COUNT(empno) 					AS "employed"
FROM	 	liat.t_empl
GROUP BY 	"day in week", sex
ORDER BY 	"day in week" ASC;



