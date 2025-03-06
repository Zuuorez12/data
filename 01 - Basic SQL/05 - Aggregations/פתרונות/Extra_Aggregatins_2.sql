-- 1
SELECT		job,
			MIN(AGE(birthdate)) AS min_age
FROM		liat.t_empl
GROUP BY	job
HAVING		AVG(AGE(birthdate)) < INTERVAL '80 YEARS';

-- 2
SELECT		DISTINCT job, 
			edlevel
FROM		liat.t_empl
WHERE		EXTRACT(month FROM birthdate) < EXTRACT(month FROM hiredate)
ORDER BY 	job, 
			edlevel;
-- 3			
SELECT		respemp,
			COUNT(projno) 	AS count_proj,
			SUM(prstaff)	AS sum_staff
FROM		liat.t_proj
GROUP BY	respemp
HAVING		COUNT(projno) > 1