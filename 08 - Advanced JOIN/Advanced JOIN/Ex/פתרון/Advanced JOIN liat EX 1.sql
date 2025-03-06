-- 1
-- SELECTS for every department,
-- the project and the employee in charge of the project.
SELECT  	dpt.deptname,
			proj.projname,
			emp.firstname || ' ' || emp.lastname 	AS emp_name
FROM     	liat.t_depart dpt
LEFT JOIN 	liat.t_proj proj 	ON 
          	dpt.deptno = proj.deptno
LEFT JOIN 	liat.t_empl emp		ON
			emp.empno = proj.respemp;
-- 2
-- SELECTS for every employee his full name, 
-- his department name, and his project name.
SELECT 		emp.firstname || ' ' || emp.lastname AS emp_name,
			dpt.deptname, 
			proj.projname
FROM 		liat.t_empl emp
LEFT JOIN 	liat.t_depart dpt 	ON
			emp.deptno = dpt.deptno
LEFT JOIN 	liat.t_proj proj 	ON
			emp.empno = proj.respemp;
			
-- using USING.
SELECT 		emp.firstname || ' ' || emp.lastname AS emp_name,
			dpt.deptname, 
			proj.projname
FROM 		liat.t_empl emp
INNER JOIN 	liat.t_depart dpt USING (deptno)
INNER JOIN 	liat.t_proj proj  USING (deptno);


-- 3
-- SELECTS the project name, the project in charge
-- of the project, and the full name and salary of the 
-- employee of this project.
SELECT 		proj.projname, 
			maj_proj.projname						AS porjname_incharge,
			emp.firstname || ' ' || emp.lastname 	AS emp_name,
			emp.salary
FROM 		liat.t_proj proj
LEFT JOIN 	liat.t_proj maj_proj 	ON
			proj.majproj = maj_proj.projno
LEFT JOIN 	liat.t_empl emp 		ON
			maj_proj.respemp = emp.empno;

-- 4
-- SELECTS all the possible combinations of education level and job.
SELECT 		DISTINCT jobs.job,
			ed_levels.edlevel
FROM 		liat.t_empl jobs
CROSS JOIN 	liat.t_empl ed_levels
ORDER BY 	jobs.job ASC, ed_levels.edlevel ASC;
