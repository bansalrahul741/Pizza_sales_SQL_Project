-- TOTAL SALES -- 

WITH sales1 AS
(SELECT o.order_id, d.quantity, p.price, (d.quantity * p.price) AS Amount
FROM pizza..orders$ as o
	JOIN pizza..order_details$ AS d
	JOIN pizza..pizzas$ AS p
		ON d.pizza_id = p.pizza_id
		ON o.order_id = d.quantity
)
-- -- Total Sales -- ROUNDING to two decimal places
SELECT ROUND(SUM(Amount),2) AS Total_Sales_Amount
FROM sales1

-- AVG ORDER-- 

WITH average_order AS(
SELECT SUM(d.quantity*p.price) AS amount , COUNT(DISTINCT d.order_id) AS total_orders
FROM pizza..order_details$ AS d
JOIN pizza..pizzas$  AS p
	ON d.pizza_id = p.pizza_id
)
SELECT amount/total_orders AS Average_Value
FROM average_order


-- TOTAL PIZZA SOLD -- 
SELECT SUM(quantity) AS Pizza_Sold
FROM pizza..order_details$

-- TOTAL ORDER -- 
SELECT count(DISTINCT order_id)
FROM pizza..order_details$

-- Top 5 Pizza by Sales -- 
SELECT TOP 5(t.name), sum(d.quantity) AS total_pizza_sold
FROM pizza..order_details$ AS d
	JOIN pizza..pizzas$ AS p
	JOIN pizza..pizza_types$ AS t
		ON p.pizza_type_id = t.pizza_type_id
		ON d.pizza_id = p.pizza_id
GROUP BY t.name 
ORDER BY total_pizza_sold desc

-- Higest Order Date -- 
SELECT COUNT(order_id) as order_count, date 
FROM pizza..orders$
GROUP BY date
ORDER BY order_count desc

--How many pizza order each day -- 

SELECT COUNT(order_id) / COUNT(DISTINCT date) AS avg_per_day_order
FROM pizza..orders$

-- Peak Hour -- 
SELECT count(order_id) as order_count, DATEPART(hh, time) AS day_hour
FROM pizza..orders$
GROUP BY time
ORDER BY order_count desc

--UNIQUE PIZZA IN PIZZA MENU -- 

SELECT DISTINCT(Name)
FROM pizza..pizza_types$

-- CATEGORY WITH MOST PIZZA VARIETY -- 

SELECT category,COUNT(pizza_type_id) as type_count
FROM PIZZA..pizza_types$
GROUP BY category
ORDER BY type_count DESC




