-- Identify the highest-priced pizza.

SELECT 
MAX(price) AS max_price
FROM pizzas;

-- Identify the most common pizza size ordered.

USE pizzahut;
SELECT pizzas.size, COUNT(order_details.order_details_id) AS order_count
FROM pizzas JOIN order_details
ON pizzas.pizza_id = order_details.pizza_id
GROUP BY pizzas.size
ORDER BY order_count DESC LIMIT 1; 

-- List the top 5 most ordered pizza types along with their quantities.

SELECT pizza_types.name, COUNT(order_details.quantity) AS order_quantity
FROM pizzas JOIN pizza_types
ON pizzas.pizza_type_id = pizza_types.pizza_type_id
JOIN order_details ON order_details.pizza_id = pizzas.pizza_id
GROUP BY pizza_types.name
ORDER BY order_quantity DESC LIMIT 5; 

-- Join the necessary tables to find the total quantity of each pizza category ordered.
SELECT pizza_types.category ,COUNT(order_details.quantity) AS cat_qty
FROM pizzas JOIN pizza_types
ON pizzas.pizza_type_id = pizza_types.pizza_type_id
JOIN order_details ON order_details.pizza_id = pizzas.pizza_id
GROUP BY pizza_types.category
ORDER BY cat_qty; 

-- Determine the distribution of orders by hour of the day.(no of orders in an hour)

SELECT HOUR(order_time) AS hour , COUNT(order_id) AS order_count
FROM orders 
GROUP BY hour;

-- Join relevant tables to find the category-wise distribution of pizzas.

SELECT category , COUNT(pizza_type_id) AS cat_count
FROM pizza_types
GROUP BY category;

-- Group the orders by date and calculate the average number of pizzas ordered per day.

SELECT ROUND(AVG(order_quantity),0) FROM
(SELECT orders.order_date, SUM(order_details.quantity) AS order_quantity
FROM orders JOIN order_details
ON orders.order_id = order_details.order_id
GROUP BY order_date) AS or_qty;

-- Determine the top 3 most ordered pizza types based on revenue.
 
SELECT pizza_types.name ,
SUM(order_details.quantity * pizzas.price) AS revenue
FROM order_details JOIN pizzas
ON order_details.pizza_id = pizzas.pizza_id
JOIN pizza_types ON pizza_types.pizza_type_id = pizzas.pizza_type_id
GROUP BY pizza_types.name 
ORDER BY revenue DESC LIMIT 3;

-- Calculate the percentage contribution of each pizza type to total revenue.

SELECT pizza_types.category,
ROUND(SUM(order_details.quantity * pizzas.price) / (SELECT 
ROUND(SUM(order_details.quantity * pizzas.price), 2) AS total_revenue
FROM order_details JOIN pizzas ON pizzas.pizza_id = order_details.pizza_id)* 100,2) AS revenue
FROM order_details JOIN pizzas
ON order_details.pizza_id = pizzas.pizza_id
JOIN pizza_types ON pizza_types.pizza_type_id = pizzas.pizza_type_id
GROUP BY pizza_types.category
ORDER BY revenue DESC;

-- Analyze the cumulative revenue generated over time.
SELECT order_date,
SUM(revenue) OVER (ORDER BY order_date) AS cum_rev
FROM
(SELECT orders.order_date,
SUM(order_details.quantity * pizzas.price) AS revenue
FROM order_details JOIN pizzas
ON order_details.pizza_id = pizzas.pizza_id
JOIN orders
ON orders.order_id = order_details.order_id
GROUP BY orders.order_date) AS sales;

-- Determine the top 3 most ordered pizza types based on revenue for each pizza category.(har pizza category ka top 3 nikalna h based on revenue)

SELECT name, revenue FROM
(SELECT category, name, revenue,
RANK() OVER (PARTITION BY category ORDER BY revenue DESC) AS rn
FROM
(SELECT pizza_types.category, pizza_types.name,
SUM((order_details.quantity) * pizzas.price) AS revenue
FROM pizza_types JOIN pizzas
ON pizza_types.pizza_type_id = pizzas.pizza_type_id
JOIN order_details
ON order_details.pizza_id = pizzas.pizza_id
GROUP BY pizza_types.category, pizza_types.name) AS a) AS b
WHERE rn<= 3;


