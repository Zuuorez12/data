--1
-- SELECT the amount of tracks of each album
-- and find what the most expensive albums are
SELECT		alb."Title",
			COUNT(trc."TrackId")	AS tracks_amount,
			SUM(trc."UnitPrice")	AS total_amount
FROM		"Album"	alb
LEFT JOIN	"Track" trc ON
			alb."AlbumId" = trc."AlbumId"
GROUP BY	alb."AlbumId"			
ORDER BY	total_amount DESC;

--2
-- SELECT the title and the amount of customers for each employee
SELECT		emp."FirstName" || ' ' || emp."LastName"	AS full_name,
			emp."Title",
			COUNT(cus."CustomerId")						AS amount_cust_helped					
FROM		"Employee"	emp
LEFT JOIN	"Customer" cus ON
			 emp."EmployeeId" = cus."SupportRepId"
GROUP BY	 emp."EmployeeId"
ORDER BY	 amount_cust_helped DESC;

--3
-- SELECT for each country the total amount spent by its customers.
-- Only customers whose city does not begin with the letter L 
SELECT	  	cus."Country",
			SUM(inv."Total")	AS total
FROM		"Invoice" inv
INNER JOIN	"Customer" cus ON
			inv."CustomerId" = cus."CustomerId"
WHERE		cus."City" NOT LIKE 'L%'			
GROUP BY	cus."Country"
ORDER BY	total DESC;

--4
-- SELECT for each employee his title, the name of his boss and the title of the boss.
SELECT		emp."FirstName" || ' ' || emp."LastName"						AS emp_full_name,
			emp."Title"														AS emp_title,
			COALESCE(boss."FirstName" || ' ' || boss."LastName", 'CEO')	AS boss_full_name,
			COALESCE(boss."Title", 'CEO')									AS boss_title 
FROM		"Employee"	emp
LEFT JOIN	"Employee" boss ON
			emp."ReportsTo" = boss."EmployeeId";

			