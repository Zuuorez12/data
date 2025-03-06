--1
--SELECT all the names of the customers and actors.
SELECT	  first_name
FROM	  customer	
WHERE	  first_name LIKE 'A%' 
UNION ALL
SELECT	  first_name
FROM	  actor	
WHERE	  first_name LIKE 'A%'  


--2
-- SELECTS for staff and customers name email and data.
SELECT 	stf.first_name || ' ' || stf.last_name AS full_name,
		stf.email,
		stf.address_id,
		'staff'								   AS "type"
FROM 	staff stf
UNION
SELECT 	cstm.first_name || ' ' || cstm.last_name AS full_name,
		cstm.email,
		cstm.address_id,
		'customer'								 AS "type"
FROM 	customer cstm