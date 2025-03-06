--1
--SELECTS the name and the unit_price and the average unit price (include discount)
SELECT 	product_name,
		unit_price,
    	(
			SELECT 	ROUND(AVG(unit_price * (1 - discount))::NUMERIC, 2)
			FROM 	order_details
		)	AS avg_unit_price
FROM 	products;

--2
--SELECTS the average amount of types of products in order
SELECT		ROUND(AVG(prod_count_order.prod_count), 2) AS avg_prod
FROM 		(
				SELECT		order_id, 
							COUNT(product_id)          AS prod_count
	  			FROM		order_details
				GROUP BY	order_id
			)	prod_count_order;

-- 3 
-- SELECTS customers and their amount of orders that are above avg shipment time
SELECT      ord.customer_id,
            COUNT(ord.order_id)                            AS order_amount
FROM        orders ord 
INNER JOIN  (
                SELECT      customer_id,
                            AVG(shipped_date - order_date) AS avg_shipping_time
                FROM        orders
                GROUP BY    customer_id
            ) ord_cus ON
            ord.customer_id = ord_cus.customer_id
WHERE       (ord.shipped_date - ord.order_date) < ord_cus.avg_shipping_time
GROUP BY    ord.customer_id;