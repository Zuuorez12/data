-- 1
--SELECT the names of the employees and the name of the department where each one works
SELECT		emp.firstname  || ' ' || emp.lastname	AS full_name,
			dpt.deptname
FROM		liat.t_empl emp
INNER JOIN	liat.t_depart dpt ON
			emp.deptno = dpt.deptno;
			
-- 2			
-- SELECTS for every project it's responsible employee
SELECT  	prj.projname, 
			emp.firstname || ' ' || emp.lastname	AS reponsible_emp
FROM 		liat.t_proj prj
LEFT JOIN	liat.t_empl emp	ON
			emp.empno = prj.respemp;

-- 3
-- SELECTS a list of departments in a descending order 
-- according to the amount of projects they are responsible for
SELECT		dpt.deptname,
			COUNT(prj.projno)	AS proj_amount
FROM 		liat.t_depart dpt
LEFT JOIN	liat.t_proj	prj 	ON
			dpt.deptno = prj.deptno
GROUP BY	dpt.deptno
ORDER BY 	proj_amount DESC;
