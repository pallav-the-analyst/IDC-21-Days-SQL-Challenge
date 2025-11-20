--The Great Pizza Analytics Challenge

--List all unique pizza categories (DISTINCT).
SELECT DISTINCT category FROM pizza_types;

--Display pizza_type_id, name, and ingredients, replacing NULL ingredients with "Missing Data". Show first 5 rows.
SELECT
pizza_type_id,
name AS pizza_name,
COALESCE(ingredients,'Missing_Data') AS ingredients
FROM pizza_types LIMIT 5;

--Check for pizzas missing a price (IS NULL).
SELECT * FROM pizzas
WHERE price IS NULL;

--Orders placed on '2015-01-01' (SELECT + WHERE).
SELECT
date,order_id
FROM orders
WHERE date='2015-01-01';

--List pizzas with price descending.
SELECT
name AS pizza_name,price AS pizza_price
FROM pizza_types pt
JOIN pizzas p
ON pt.pizza_type_id=p.pizza_type_id;

--Pizzas sold in sizes 'L' or 'XL'.
SELECT
pt.name AS pizza_name,
p.size
FROM pizza_types pt
JOIN pizzas p
ON pt.pizza_type_id=p.pizza_type_id
WHERE p.size IN ('L', 'XL');

--Pizzas priced between $15.00 and $17.00.
SELECT
pt.name AS pizza_name,
p.price
FROM pizza_types pt
JOIN pizzas p
ON pt.pizza_type_id=p.pizza_type_id
WHERE p.price BETWEEN '15.00' AND '17.00';

--Pizzas with "Chicken" in the name.
SELECT
name AS pizza_name
FROM pizza_types
WHERE name LIKE '%Chicken%'

--Orders on '2015-02-15' or placed after 8 PM.
SELECT * FROM orders
WHERE date='2015-02-15' OR EXTRACT(HOUR FROM time)>20;

--Total quantity of pizzas sold (SUM).
SELECT
SUM(quantity) AS total_quantiy_of_pizza_sold
FROM order_details;

--Average pizza price (AVG).
SELECT
ROUND(AVG(price),2) AS average_pizza_price
FROM pizzas;

--Total order value per order (JOIN, SUM, GROUP BY).
SELECT
od.order_id,
ROUND(SUM(od.quantity*p.price),2) AS order_value
FROM order_details od
JOIN pizzas p
ON od.pizza_id=p.pizza_id
GROUP BY od.order_id
ORDER BY od.order_id;

--Total quantity sold per pizza category (JOIN, GROUP BY).
SELECT
pt.category,
SUM(od.quantity) AS total_quantity_sold
FROM order_details od
JOIN pizzas p
ON od.pizza_id=p.pizza_id
JOIN pizza_types pt
ON p.pizza_type_id=pt.pizza_type_id
GROUP BY pt.category;

--Categories with more than 5,000 pizzas sold (HAVING).
SELECT
pt.category,
SUM(od.quantity) AS quantity_sold
FROM order_details od
JOIN pizzas p
ON od.pizza_id=p.pizza_id
JOIN pizza_types pt
ON p.pizza_type_id=pt.pizza_type_id
GROUP BY pt.category
HAVING SUM(od.quantity)>5000;

--Pizzas never ordered (`LEFT/RIGHT JOIN`).
SELECT
pt.name AS pizzas_never_ordered
FROM order_details od
RIGHT JOIN pizzas p
ON od.pizza_id=p.pizza_id
JOIN pizza_types pt
ON p.pizza_type_id=pt.pizza_type_id
WHERE quantity IS NULL;

--Price differences between different sizes of the same pizza (`SELF JOIN`).
SELECT
pt.name AS pizza,(p2.price-p1.price) AS s_to_m,(p3.price-p2.price) AS m_to_l,
(p4.price-p3.price) AS l_to_xl,(p5.price-p4.price) AS xl_to_xxl
FROM pizza_types pt
LEFT JOIN pizzas p1
ON p1.pizza_type_id=pt.pizza_type_id AND p1.size='S'
LEFT JOIN pizzas p2
ON p2.pizza_type_id=pt.pizza_type_id AND p2.size='M'
LEFT JOIN pizzas p3
ON p3.pizza_type_id=pt.pizza_type_id AND p3.size='L'
LEFT JOIN pizzas p4
ON p4.pizza_type_id=pt.pizza_type_id AND p4.size='XL'
LEFT JOIN pizzas p5
ON p5.pizza_type_id=pt.pizza_type_id AND p5.size='XXL';
