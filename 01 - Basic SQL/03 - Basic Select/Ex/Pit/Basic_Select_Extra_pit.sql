-- 1
-- SELECTS managers that their education level is more then 16
-- or that there salary is more then 25000.
SELECT		firstname, 
			lastname
FROM		liat.t_empl
WHERE		(job = 'MANAGER')		AND
			((edlevel > '16')	OR
			(salary > 25000))
ORDER BY	salary	DESC;

-- 2
-- SELECTS projects from D21 or D11 and that their responsible
-- employee code is 000220 or 000060.
SELECT		projno, 
			projname, 
			deptno, 
			respemp
FROM		liat.t_proj
WHERE		((deptno = 'D21')	    OR 
             (deptno = 'D11'))	        AND
			((respemp = '000220')	OR
			 (respemp = '000060'));

-- 3
-- SELECTS female employees salary and bonus +25%
-- only of female employees that there education level is more then
-- 16.
SELECT		firstname, 
			lastname, 
			(salary + bonus) * 1.25
FROM		liat.t_empl
WHERE		(sex = 'F')	AND
			(edlevel > 16);






