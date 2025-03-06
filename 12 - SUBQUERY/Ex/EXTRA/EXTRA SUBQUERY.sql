--1 
-- SELECT the average number of songs per playlist
WITH
	number_of_tracks("PlaylistId", count_of_tacks)
AS
	(
		SELECT 		ply."PlaylistId",
					COUNT(pltc."TrackId")
		FROM		"Playlist" ply
		INNER JOIN	"PlaylistTrack" pltc ON
					ply."PlaylistId" = pltc."PlaylistId"
		GROUP BY	ply."PlaylistId"	
	)	
--- MAIN QUERY ---	
SELECT		ROUND(AVG(count_of_tacks), 2)	AS avg_tracks_per_ply
FROM		number_of_tracks;

--2
-- SELECT the artists whose total sales sum is higher than
-- the average of the sales sum of all artists
WITH
	artist_sales(total_artist_sales)
AS
	(
			SELECT 		  SUM(il2."UnitPrice" * il2."Quantity")
			FROM   		  "Artist" art2
			INNER JOIN    "Album" alb2 	  	 	ON
			 			  art2."ArtistId" = alb2."ArtistId"
			INNER JOIN    "Track" trc2   	  	ON 
						  alb2."AlbumId" = trc2."AlbumId"
			INNER JOIN    "InvoiceLine" il2 	ON 
						  trc2."TrackId" = il2."TrackId"
			GROUP BY 	  art2."ArtistId"														
	)
--- MAIN QUERY ---	
SELECT 			art."ArtistId",
       			art."Name",
       			SUM(il."UnitPrice" * il."Quantity") AS total_sales
FROM   			"Artist" art
INNER JOIN   	"Album" alb 			ON
			  	art."ArtistId" = alb."ArtistId"
INNER JOIN   	"Track" trc 			ON
				alb."AlbumId" = trc."AlbumId"
INNER JOIN   	"InvoiceLine" il 	    ON
				trc."TrackId" = il."TrackId"
GROUP BY 		art."ArtistId"
HAVING 			SUM(il."UnitPrice" * il."Quantity") > (
												         SELECT AVG(total_artist_sales) 
												         FROM   artist_sales
      												   )
ORDER BY 		total_sales DESC;


--3
-- SELECT for each customer the ratio between the amount of his purchases 
-- and the general average of the total purchases of all customers in the company 
WITH 
	customer_totals(CustomerId, total_sales) 
AS
	(
	    SELECT 		"CustomerId",
	            	SUM("Total") 
	    FROM 		"Invoice"
	    GROUP BY 	"CustomerId"
	)
--- MAIN QUERY ---	
SELECT 		cus."CustomerId",
		    cus."FirstName" || ' ' || cus."LastName" 	AS full_name,
		    SUM(inv."Total") 							AS total_sales,
		    COUNT(inv."InvoiceId") 						AS num_invoices,
		    ROUND(AVG(inv."Total"), 2) 				AS avg_invoice_total,
		    ROUND(SUM(inv."Total") / 
				(
					SELECT AVG(total_sales) 
					FROM customer_totals
				), 2) 									AS sales_to_avg_customer_ratio
FROM 		"Customer" cus
INNER JOIN  "Invoice" inv ON
			cus."CustomerId" = inv."CustomerId"
GROUP BY 	cus."CustomerId"
ORDER BY    sales_to_avg_customer_ratio DESC;


--4
-- SELECT the playlists where the TRACK with the lowest price (UnitPrice)
-- is higher than the cheapest price of at least one other playlist
SELECT 		ply."PlaylistId",
			ply."Name"
FROM 		"Playlist" ply
INNER JOIN 	"PlaylistTrack" pt 			ON
			ply."PlaylistId" = pt."PlaylistId"
INNER JOIN 	"Track" trc 				ON
			pt."TrackId" = trc."TrackId"
GROUP BY 	ply."PlaylistId"
HAVING 		MIN(trc."UnitPrice") > ANY(
										SELECT 		MIN(trc2."UnitPrice")
    									FROM		"PlaylistTrack" pt2 
    									INNER JOIN 	"Track" trc2 		ON 
													pt2."TrackId" = trc2."TrackId"
    									GROUP BY 	pt2."PlaylistId"
									 	);







