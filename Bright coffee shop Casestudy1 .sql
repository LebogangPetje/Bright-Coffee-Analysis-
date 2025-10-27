
--To check columns in data 
SELECT *
FROM BRIGHTCOFFEE.PUBLIC.COFFEE_SHOP
LIMIT 10;

--to check categorical column
SELECT DISTINCT store_location
FROM brightcoffee.public.coffee_shop;

SELECT DISTINCT product_category
FROM brightcoffee.public.coffee_shop;

SELECT MIN(transaction_date) AS first_operating_date
FROM brightcoffee.public.coffee_shop;

SELECT MAX(transaction_date) AS last_operating_day
FROM brightcoffee.public.coffee_shop;

--to check operating times (6am to 9pm)
SELECT MIN(transaction_time) AS first_operating_hour
FROM brightcoffee.public.coffee_shop;

SELECT MAX(transaction_time) AS last_operating_hour
FROM brightcoffee.public.coffee_shop;

---average order value (revenue/number_of_sales)
---count ID's
SELECT COUNT(DISTINCT transaction_id) AS number_of_sales, 
---revenue 
      SUM(transaction_qty*unit_price) AS revenue, 
---revenue per product category
     product_category,
     FROM brightcoffee.public.coffee_shop
GROUP BY 
product_category
ORDER BY revenue DESC;

---main code

SELECT store_location,
product_category, product_detail, product_type,
SUM(transaction_qty*unit_price) AS revenue, 
COUNT(DISTINCT transaction_id) AS number_of_sales,
transaction_date, DAYNAME( transaction_date) AS day_name,
    MONTHNAME(transaction_date) AS month_name,
    HOUR(transaction_time) AS hour_of_day, 
  CASE
   WHEN day_name IN ('Sun','Sat') THEN 'Weekend'
   ELSE 'Weekday'
   END AS day_classification,
   transaction_time,
 CASE
  WHEN transaction_time BETWEEN '6:00:00' AND '11:59:59' THEN 'Morning'
  WHEN transaction_time BETWEEN '12:00:00' AND '15:59:59' THEN 'Afternoon'
  WHEN transaction_time BETWEEN '16:00:00' AND '19:59:59' THEN 'Evening'
  WHEN transaction_time >= '20:00:00' THEN 'Night'
  END AS time_categorisations,
FROM brightcoffee.public.coffee_shop
GROUP BY 
store_location,
product_type,
product_detail,
product_category,
transaction_date,
transaction_qty,
transaction_time,
unit_price,
time_categorisations;