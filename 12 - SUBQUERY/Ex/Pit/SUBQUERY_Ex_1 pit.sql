--1
-- SELECTS the average salary of salaries bigger then the average female salary
SELECT 		ROUND(AVG(emp.salary), 2) AS "salary"
FROM 		liat.t_empl emp
WHERE 		emp.salary > 	(	
								SELECT	AVG(empf.salary)
								FROM 	liat.t_empl empf
								WHERE 	empf.sex = 'F'
							);


--2
-- SELECTS employees with salary bigger then the average clean income 
-- and the gap from average clean income to theirs. 
SELECT		emp.firstname || ' ' || emp.lastname 	AS fullname,
			emp.job,
			emp.salary,
			ROUND((emp.salary + emp.bonus - emp.comm) 
					-	(
                            SELECT 	AVG(empl.salary
                                        + empl.bonus 
                                        - empl.comm)
                            FROM 	liat.t_empl     AS empl
						), 2)						AS income_above_avg
FROM 		liat.t_empl emp
WHERE		emp.salary > 	(
                                SELECT 	AVG(empl.salary
                                            + empl.bonus 
                                            - empl.comm)
                                FROM 	liat.t_empl AS empl
							)
ORDER BY	income_above_avg DESC;

--3
-- SELECTS the average salary of the employees 
-- with medium eduaction level
WITH 
	salary_level(emp_no, ed_level, sal, ed_desc)
AS
	(
		SELECT 	empno,
				edlevel,
				salary,
				CASE
					WHEN edlevel < 14  THEN 'LOW'
					WHEN edlevel >= 18 THEN 'HIGH'
					ELSE 'MEDIUM'
				END 
		FROM liat.t_empl
	)

------------- Main Query -------------

SELECT 		ROUND(AVG(sal), 2)
FROM 		salary_level
WHERE 		ed_desc = 'MEDIUM';


--4
-- SELECTS for every job the average ed level
-- and the majority of the sex in every job. 
-- If equel show Female.
WITH
	gender(job, male_count, female_count)
AS 
	(	
		SELECT     	job,
	     			COUNT(CASE WHEN sex = 'M' THEN 1 END) AS male_count,
	              	COUNT(CASE WHEN sex = 'F' THEN 1 END) AS female_count
	    FROM 		liat.t_empl
	    GROUP BY 	job
	)

------------ Main Query ------------

SELECT   	job,
			(
				SELECT 		ROUND(AVG(edlevel), 2) AS ed_avg
				FROM     	liat.t_empl emp
				WHERE    	emp.job = curremp.job
			),
         	(
				SELECT 	CASE
							WHEN gender.female_count >=  gender.male_count THEN 'F'
							ELSE 'M'
						END    	AS gender_count                
				FROM    gender 
				WHERE   gender.job = curremp.job
		 	)
FROM    	liat.t_empl curremp
GROUP BY 	job
ORDER BY 	ed_avg ASC;

--5
-- SELECTS employees with salary bigger then the average clean income 
-- of employees with lower salaries. 
SELECT 		emp.firstname || ' ' || emp.lastname AS "employee",
			salary
FROM 		liat.t_empl emp
WHERE 		salary > 	(	
							SELECT 	AVG(crr_emp.salary + crr_emp.bonus - crr_emp.comm)
							FROM 	liat.t_empl crr_emp
							WHERE 	crr_emp.salary < emp.salary
						);
