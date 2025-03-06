--0
SELECT 		supp.company_name 		AS supplier, 
			AVG(prod.unit_price) 	AS avg_price
FROM 		products prod
INNER JOIN	suppliers supp	ON 
			supp.supplier_id = prod.supplier_id
GROUP BY	supplier;


--1 
SELECT 		supp.company_name 	AS supplier, 
			prod.product_name 	AS product,
 			prod.unit_price  	AS price,
			(
			SELECT		AVG(avgProd.unit_price) AS "avg price" 
		 	FROM		products avgProd 
		 	WHERE 		avgProd.supplier_id = prod.supplier_id
			)
FROM 		products prod
INNER JOIN	suppliers supp	ON 
			supp.supplier_id = prod.supplier_id
ORDER BY 	supplier;

--2 
SELECT 		supp.company_name  			AS supplier, 
			prod.product_name  			AS product,
			prod.unit_price    			AS price,
			AVG(unit_price) OVER 	(
									PARTITION BY supp.supplier_id
									) 	AS "avg price"
FROM 		suppliers supp
INNER JOIN	products prod ON
			prod.supplier_id = supp.supplier_id;

-- 3
SELECT 		cat.category_name, 
      		prod.product_name, 
      		prod.unit_price,
			SUM(prod.unit_price) OVER 	(
     				          			PARTITION BY 	cat.category_id 
					          			ORDER BY 		prod.unit_price
					          			ROWS BETWEEN UNBOUNDED PRECEDING 
										AND 1 FOLLOWING
 				         				) 	AS "ROWS",
			SUM(prod.unit_price) OVER 	(
     					          		PARTITION BY 	cat.category_id 
					          			ORDER BY 		prod.unit_price
					          			RANGE BETWEEN UNBOUNDED PRECEDING 
										AND 1 FOLLOWING
 				          				) 	AS "RANGE"
FROM 		categories cat
INNER JOIN 	products prod ON
			prod.category_id = cat.category_id;

-- 4
SELECT		cat.category_name  			AS category, 
			prod.product_name  			AS product,
			prod.unit_price    			AS price,
			SUM(unit_price) OVER 	(
									PARTITION BY 	cat.category_id 
 				 					ORDER BY 		unit_price
									)	AS "sum"
FROM 		categories cat
INNER JOIN	products prod ON
			prod.category_id = cat.category_id;
		
-- 5
SELECT 		cat.category_name 		AS category, 
			prod.product_name 		AS product,
			RANK() OVER			(
								PARTITION BY 	cat.category_id
   			 					ORDER BY 		unit_price DESC
								)	AS "rank",
			DENSE_RANK() OVER	(
								PARTITION BY 	cat.category_id 
   			 					ORDER BY 		unit_price DESC
								) 	AS "dense_rank",
			ROW_NUMBER() OVER	(
								PARTITION BY 	cat.category_id 
   			 					ORDER BY 		unit_price DESC
								) 	AS "row_number"
FROM 		categories cat
INNER JOIN	products prod ON
			prod.category_id = cat.category_id;
			
			
SELECT 		cat.category_name  		AS category, 
			prod.product_name  		AS product,
			prod.unit_price,
			RANK() OVER			cat AS "rank",
			DENSE_RANK() OVER	cat AS "dense_rank",
			ROW_NUMBER() OVER	cat AS "row_number"
FROM 		categories cat
INNER JOIN	products prod ON
			prod.category_id = cat.category_id
WINDOW		cat AS	(
					PARTITION BY 	cat.category_id 
   			 		ORDER BY 		unit_price DESC
					);

		
-- 6
SELECT 		cat.category_name 	AS category, 	
			prod.product_name  	AS product,
			prod.unit_price,
			NTILE(4) OVER 	(
							PARTITION BY	cat.category_id
							ORDER BY 		prod.unit_price DESC
							) 	AS "bucket"
FROM 		categories cat
INNER JOIN	products prod ON
			prod.category_id = cat.category_id
ORDER BY	cat.category_name, prod.unit_price DESC;  

-- 7	
SELECT 		cat.category_name  AS category, 
			prod.product_name  AS product,
			prod.unit_price    AS price,
			LAG(prod.unit_price, 1) 	OVER	cat AS "higher price",
			LEAD(prod.unit_price, 1) 	OVER	cat AS "lower price"
FROM 		categories cat
INNER JOIN	products prod ON
			prod.category_id = cat.category_id 
WINDOW		cat AS	(
					PARTITION BY 	cat.category_id 
					ORDER BY 		unit_price DESC
					);
			
			
SELECT 		cat.category_name  					AS category, 
			prod.product_name 					AS product,
			prod.unit_price    					AS price,
			LAG(prod.unit_price, 1) OVER	(
											PARTITION BY 	cat.category_id 
						     	    		ORDER BY 		unit_price DESC
											)	AS "higher price",
			LEAD(prod.unit_price, 1) OVER	(
											PARTITION BY 	cat.category_id 
						     	    		ORDER BY 		unit_price DESC
											) 	AS "lower price"
FROM 		categories cat
INNER JOIN	products prod ON
			prod.category_id = cat.category_id;  

-- 8
SELECT 		cat.category_name  	AS category, 
			prod.product_name  	AS product,
			prod.unit_price    	AS price,
			FIRST_VALUE(unit_price) OVER 	(
											PARTITION BY 	cat.category_id 
											ORDER BY 		prod.unit_price DESC
											) 
			- prod.unit_price 	AS "difference"
FROM 		categories cat
INNER JOIN	products prod ON
			prod.category_id = cat.category_id;

-- 9
SELECT 		cat.category_name  						AS category, 
			prod.product_name  						AS product,
			prod.unit_price    						AS price,
			prod.unit_price - 
			LAST_VALUE(prod.unit_price) OVER 	(
												PARTITION BY 	cat.category_id
												ORDER BY 		prod.unit_price DESC
												) 	AS "difference"
FROM 		categories cat
INNER JOIN	products prod ON
			prod.category_id = cat.category_id;

SELECT 		cat.category_name  					AS category, 
			prod.product_name  					AS product,
			prod.unit_price    					AS price,
			prod.unit_price - 
			LAST_VALUE(prod.unit_price) OVER(
											PARTITION BY 	cat.category_id
											ORDER BY 		prod.unit_price DESC
											ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING
											)	AS "difference"
FROM 		categories cat
INNER JOIN	products prod ON
			prod.category_id = cat.category_id;
