--1
-- SELECT the tracks that are not belong to albums 1 or 3 
--and were not composed by F. Baltes
SELECT 		"Name",
			"AlbumId",
			"Composer",
			"UnitPrice"
FROM		"Track"	
WHERE		("AlbumId" IN (1, 3)) AND
			("Composer" NOT LIKE '%F. Baltes%');

--2
--SELECT the tracks that contain 'man' in their name
SELECT		"Name",
			"GenreId"
FROM		"Track"
WHERE		"Name" ILIKE '%man%';

--3
--SELECT all the customers that there email length is greater than or equal to 18
---and their fax is not null
SELECT		"FirstName" || ' ' || "LastName",
			"Email",
			"Country"
FROM		"Customer"	
WHERE		(LENGTH("Email") <= 18) AND
			("Fax" IS NOT NULL);
--4
--SELECT the tracks that contain the word Rock or Pop in their name
SELECT 	"Name",
		"Composer",
		"MediaTypeId"
FROM 	"Track" 
WHERE 	"Name" SIMILAR TO '(Rock|Pop)%';

		