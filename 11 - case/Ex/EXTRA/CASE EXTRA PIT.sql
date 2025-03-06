--1
-- SELECT For each employee the total sales, if the total sales exceeds 
-- 750 the employee receives a commission of 5%.
SELECT 			emp."FirstName" || ' ' || emp."LastName"	AS full_name,
		       	SUM(inv."Total") 							AS total_sales,
		       	CASE
		           	WHEN SUM(inv."Total") > 750 THEN SUM(inv."Total") * 0.05
		           	ELSE 0
		       	END 										AS commission
FROM 			"Employee" emp 
LEFT JOIN  		"Customer" cus 	ON 
				cus."SupportRepId" = emp."EmployeeId" 
LEFT JOIN 		"Invoice" inv 	ON 
				inv."CustomerId" = cus."CustomerId"
GROUP BY 		emp."EmployeeId"
ORDER BY 		total_sales DESC;


--2
-- The classification of the invoices into different categories, based
-- on the amount of each invoice, in the country and the special cities of the shipments.
SELECT 	"InvoiceId",
       	"Total",
       	CASE
           	WHEN "Total" > 25 							THEN 'Premium High'
           	WHEN "Total" > 20 							THEN 'Premium'
           	WHEN ("Total" BETWEEN 10 AND 20) AND 
			   ("BillingCountry" IN ('USA', 'Canada')) THEN 'Standard (North America)'
           	WHEN ("Total" BETWEEN 5 AND 10)  AND 
			   ("BillingCity" NOT LIKE 'A%') 			THEN 'Basic (Non-A Cities)'
           	ELSE 'Low'
       	END	 AS total_classification
FROM 		"Invoice" 
WHERE 		"Total" IS NOT NULL   
ORDER BY 	"Total" DESC;  


--3
-- SELECT country, the year and the amount of sales classified  to categories,
-- for each year and country separately and for
-- the combination of each country and year together.
SELECT 		cus."Country",
		    EXTRACT(YEAR FROM inv."InvoiceDate") 	AS "Year",
		    SUM(inv."Total") 					  	AS TotalSales,
		    CASE
		        WHEN SUM(inv."Total") > 30 				THEN 'High Sales'
		        WHEN SUM(inv."Total") BETWEEN 20 AND 30 	THEN 'Medium Sales'
		        WHEN SUM(inv."Total") < 20 				THEN 'Low Sales'
		        ELSE 'No Sales'
		    END 									AS SalesClassification
FROM  		"Invoice" inv
LEFT JOIN 	"Customer" cus ON 
			inv."CustomerId" = cus."CustomerId"
GROUP BY 	CUBE (cus."Country", EXTRACT(YEAR FROM inv."InvoiceDate"))
ORDER BY 	cus."Country", "Year";


--4
-- Analysis of global sales by countries and media types
SELECT  	cus."Country", 
    		COALESCE(mdt."Name", 'Total') 				AS MediaType, 
    		SUM(invl."UnitPrice" * invl."Quantity") 	AS TotalSales
FROM 		"InvoiceLine" invl
INNER JOIN 	"Track" trc 	ON
			invl."TrackId" = trc."TrackId"
INNER JOIN 	"MediaType" mdt ON
			trc."MediaTypeId" = mdt."MediaTypeId"
INNER JOIN 	"Invoice" inv 	ON
			invl."InvoiceId" = inv."InvoiceId"
INNER JOIN 	"Customer" cus 	ON
			inv."CustomerId" = cus."CustomerId"
GROUP BY 	ROLLUP(cus."Country", mdt."Name")
ORDER BY 	cus."Country" ASC, mdt."Name" ASC;


--5  
-- SELECT customer ID, name, average by each category invoice amount
--  and total sales and overall average
SELECT 		cus."CustomerId",
		    cus."FirstName" || ' ' || cus."LastName"	AS full_name,
		    ROUND(COALESCE(AVG(CASE WHEN inv."Total" > 10 THEN inv."Total" END), 0),2)
														AS avg_high_sales,
		    ROUND(COALESCE(AVG(CASE WHEN inv."Total" BETWEEN 5 AND 10 THEN inv."Total" END), 0),2)
														AS avg_medium_sales,
		    ROUND(COALESCE(AVG(CASE WHEN inv."Total" < 5 THEN inv."Total" END), 0),2)
														AS avg_low_sales,
		    SUM(inv."Total") 							AS total_sales,
		    ROUND(AVG(inv."Total"),2) 					AS avg_sales
FROM  		"Customer" cus
INNER JOIN  "Invoice"  inv ON
			cus."CustomerId" = inv."CustomerId"
GROUP BY 	cus."CustomerId"
ORDER BY 	cus."CustomerId";

