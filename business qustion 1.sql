use magist;

#1What categories of tech products does Magist have?
SELECT 
    product_category_name_english
FROM
    product_category_name_translation;
#cds_dvds_musicals, dvds_blue_ray, electronics, computers_accessories, pc_gamer, computers, signalling_and_security, tablets_printing_image, telephony, fixed_telephony




#2How many products of these tech categories have been sold (within the time window of the database snapshot)? What percentage does that represent from the overall number of products sold?
SELECT 
    COUNT(products.product_id) AS product_count,
    product_category_name_english
FROM
    products
        LEFT JOIN
    order_items ON products.product_id = order_items.product_id
        LEFT JOIN
    product_category_name_translation ON products.product_category_name = product_category_name_translation.product_category_name
        LEFT JOIN
    orders ON order_items.order_id = orders.order_id
WHERE
    product_category_name_english IN ('cds_dvds_musicals' , 'dvds_blue_ray',
        'electronics',
        'computers_accessories',
        'pc_gamer',
        'computers',
        'signalling_and_security',
        'tablets_printing_image',
        'telephony',
        'fixed_telephony')
        AND order_purchase_timestamp BETWEEN '2017-04-01 00:00:00' AND '2018-03-31 00:00:00'
GROUP BY product_category_name_english
ORDER BY COUNT(products.product_id) DESC;
#computer-accessories and telephony are sold in highest

#3What’s the average price of the products being sold?

SELECT 
    AVG(price)
FROM
    order_items
        LEFT JOIN
    products ON order_items.product_id = products.product_id;
#120


#4 Are expensive tech products popular? *

SELECT 
    COUNT(products.product_id) AS product_count,
    product_category_name_english, order_items.price,
    CASE
        WHEN order_items.price > 1000 THEN 'expensive'
        ELSE 'non-expensive'
    END AS Expanses,
    case 
        when COUNT(products.product_id)>10 then 'popular'
        else 'not popular'
	end as popularity
FROM
    products
        LEFT JOIN
    order_items ON products.product_id = order_items.product_id
        LEFT JOIN
    product_category_name_translation ON products.product_category_name = product_category_name_translation.product_category_name
        LEFT JOIN
    orders ON order_items.order_id = orders.order_id
WHERE
    product_category_name_english IN ('cds_dvds_musicals' , 'dvds_blue_ray',
        'electronics',
        'computers_accessories',
        'pc_gamer',
        'computers',
        'signalling_and_security',
        'tablets_printing_image',
        'telephony',
        'fixed_telephony')
        AND order_purchase_timestamp BETWEEN '2017-04-01 00:00:00' AND '2018-03-31 00:00:00'
GROUP BY order_items.price, product_category_name_english
order by product_count desc, order_items.price desc;
#the majority shows non expensive tech products are popular


