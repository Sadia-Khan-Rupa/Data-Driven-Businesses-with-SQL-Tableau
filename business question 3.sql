use magist;
#What’s the average time between the order being placed and the product being delivered?
select *from orders;

select avg(timestampdiff(day, order_purchase_timestamp, order_delivered_customer_date)) as averge_time
from orders;

#12 days


#How many orders are delivered on time vs orders delivered with a delay?

SELECT 
    COUNT(order_id) AS order_count,
    CASE 
        WHEN timestampdiff(day, order_delivered_customer_date, order_estimated_delivery_date) >= 0 THEN 'DELIVERED ON TIME'
        ELSE 'DELIVERED DELAY'
    END AS DELIVERY_DELAYED_OR_NOT
FROM ORDERS
GROUP BY DELIVERY_DELAYED_OR_NOT;
#9500 delivered delay, 89941 delivered on time


#Is there any pattern for delayed orders, e.g. big products being delayed more often?


#Working
SELECT 
    CASE 
        WHEN (product_length_cm * product_height_cm * product_width_cm) > 4000 THEN 'BIG Product'
        ELSE 'Small Product'
    END AS Product_size,
    COUNT(order_items.order_id) AS order_count,
    AVG(timestampdiff(day, orders.order_delivered_customer_date, orders.order_estimated_delivery_date)) AS average_delay_days
FROM products
LEFT JOIN order_items ON products.product_id = order_items.product_id
LEFT JOIN orders ON order_items.order_id = orders.order_id
WHERE
    orders.order_delivered_customer_date IS NOT NULL  -- Exclude orders that have not been delivered yet
GROUP BY 
    Product_size;

#big product avg delay 11.22 days small , small product avg delay 10,8998  days