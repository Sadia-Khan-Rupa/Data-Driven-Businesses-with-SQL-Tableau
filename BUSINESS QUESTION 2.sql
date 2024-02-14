use magist;

#3.2.1 How many months of data are included in the magist database?
SELECT 
    TIMESTAMPDIFF(MONTH,
        MIN(order_purchase_timestamp),
        MAX(order_purchase_timestamp)) AS months_of_data
FROM
    orders;

#25 months

#3.2.2How many sellers are there? How many Tech sellers are there? What percentage of overall sellers are Tech sellers?

##How many sellers are there? 
SELECT DISTINCT
    COUNT(seller_id)
FROM
    sellers
        LEFT JOIN
    order_items USING (seller_id)
        LEFT JOIN
    products USING (product_id)
        LEFT JOIN
    product_category_name_translation USING (product_category_name)
;
#112650

##How many Tech sellers are there? 
SELECT DISTINCT
    COUNT(seller_id)
FROM
    sellers
        LEFT JOIN
    order_items USING (seller_id)
        LEFT JOIN
    products USING (product_id)
        LEFT JOIN
    product_category_name_translation USING (product_category_name)
WHERE
    product_category_name_english IN ('fixed_telephony' , 'telephony',
        'computers',
        'watches_gifts',
        'pc_gamers',
        'audio',
        'computers_accessories',
        'electronics',
        'consoles_games');
#23098

SELECT 
    (SELECT DISTINCT
            COUNT(seller_id)
        FROM
            sellers
                LEFT JOIN
            order_items USING (seller_id)
                LEFT JOIN
            products USING (product_id)
                LEFT JOIN
            product_category_name_translation USING (product_category_name)
        WHERE
            product_category_name_english IN ('fixed_telephony' , 'telephony',
                'computers',
                'watches_gifts',
                'pc_gamers',
                'audio',
                'computers_accessories',
                'electronics',
                'consoles_games')) / (SELECT DISTINCT
            COUNT(seller_id)
        FROM
            sellers
                LEFT JOIN
            order_items USING (seller_id)
                LEFT JOIN
            products USING (product_id)
                LEFT JOIN
            product_category_name_translation USING (product_category_name)) * 100 AS percentage_of_tech_sellers;

#20 percenatage

#3.2.3 What is the total amount earned by all sellers? What is the total amount earned by all Tech sellers?

 #What is the total amount earned by all sellers?
select  (sum(payment_value) - sum(price)) as Total_amount_all_sellers
 from order_payments
 left join orders using (order_id)
 left join order_items using (order_id)
 left join sellers using (seller_id)
 left join products using (product_id)
 left join product_category_name_translation using (product_category_name);
 
 #'13591643.701720357' or 13.59 million / 6 million after subtract

#What is the total amount earned by all Tech sellers?
SELECT 
    (SUM(payment_value) - SUM(price)) AS Total_amount_Tech_sellers
FROM
    order_payments
        LEFT JOIN
    orders USING (order_id)
        LEFT JOIN
    order_items USING (order_id)
        LEFT JOIN
    sellers USING (seller_id)
        LEFT JOIN
    products USING (product_id)
        LEFT JOIN
    product_category_name_translation USING (product_category_name)
WHERE
    product_category_name_english IN ('fixed_telephony' , 'telephony',
        'computers',
        'watches_gifts',
        'pc_gamers',
        'audio',
        'computers_accessories',
        'electronics',
        'consoles_games');
;

#3091574.1136877537 or 3.09 million withiut subtracting the price from payment value
#'1278546.1360858735' after subtract

#Can you work out the average monthly income of all sellers? Can you work out the average monthly income of Tech sellers?
select  (sum(payment_value) - sum(price))/25 as avg_monthly_income_all_sellers
 from order_payments
 left join orders using (order_id)
 left join order_items using (order_id)
 left join sellers using (seller_id)
 left join products using (product_id)
 left join product_category_name_translation using (product_category_name);
 
 #Can you work out the average monthly income of Tech sellers?
 SELECT 
    (SUM(payment_value) - SUM(price)) / 25 AS avg_monthly_income_all_techsellers
FROM
    order_payments
        LEFT JOIN
    orders USING (order_id)
        LEFT JOIN
    order_items USING (order_id)
        LEFT JOIN
    sellers USING (seller_id)
        LEFT JOIN
    products USING (product_id)
        LEFT JOIN
    product_category_name_translation USING (product_category_name)
WHERE
    product_category_name_english IN ('fixed_telephony' , 'telephony',
        'computers',
        'watches_gifts',
        'pc_gamers',
        'audio',
        'computers_accessories',
        'electronics',
        'consoles_games');
;
 