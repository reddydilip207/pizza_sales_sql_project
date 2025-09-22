-- SQL Pizza Sales Project 

-- Basic questions

-- 1. Retrive the total number of orders placed.

select count(order_id) as total_orders
from orders;


-- 2. Calculate the total revenue generated from pizza sales.

SELECT 
    ROUND(SUM(order_details.quantity * pizzas.price),
            2) AS total_sales
FROM
    order_details
        JOIN
    pizzas ON pizzas.pizza_id = order_details.pizza_id;


-- 3. Identifiy the higest-priced pizza.

SELECT 
    pizza_types.name, pizzas.price
FROM
    pizza_types
        JOIN
    pizzas ON pizzas.pizza_type_id = pizza_types.pizza_type_id
ORDER BY pizzas.price DESC
LIMIT 1;


-- 4. Identify the most common pizza size ordered.

SELECT 
    pizzas.size,
    COUNT(order_details.order_details_id) AS order_count
FROM
    pizzas
        JOIN
    order_details ON order_details.pizza_id = pizzas.pizza_id
GROUP BY pizzas.size
ORDER BY order_count DESC;

-- 5. List the top 5 most ordered pizza types along with their quantites.

SELECT 
    pizza_types.name, SUM(order_details.quantity) AS quantity
FROM
    pizza_types
        JOIN
    pizzas ON pizzas.pizza_type_id = pizza_types.pizza_type_id
        JOIN
    order_details ON order_details.pizza_id = pizzas.pizza_id
GROUP BY pizza_types.name
ORDER BY quantity DESC
LIMIT 5;


-- Itermediate questions

-- 1. join the necessary tables to find the total quantity of each pizza category ordered.

SELECT 
    pizza_types.category,
    SUM(order_details.quantity) AS quantity
FROM
    pizza_types
        JOIN
    pizzas ON pizzas.pizza_type_id = pizza_types.pizza_type_id
        JOIN
    order_details ON order_details.pizza_id = pizzas.pizza_id
GROUP BY pizza_types.category
ORDER BY quantity DESC;

-- 2. Determine the distribution of orders by hour of the day

select hour(order_time) as hour, count(order_id) as order_count 
from orders
group by hour(order_time);


-- 3. join relevent table to find the category--wise distribution of pizzas.

select category,count(name) 
from pizza_types
group by category;


-- 4. Group the orders by date and calulate the average number of pizzas ordered per day.

SELECT 
    ROUND(AVG(quantity), 0) as avg_pizza_order_per_day
FROM
    (SELECT 
        orders.order_date, SUM(order_details.quantity) AS quantity
    FROM
        orders
    JOIN order_details ON order_details.order_id = orders.order_id
    GROUP BY orders.order_date) AS order_quantity;


-- 5. Determine the top 3 most ordered pizza types based on revenue.

select pizza_types.name, sum(order_details.quantity * pizzas.price) as revenue
from pizza_types
join pizzas on pizzas.pizza_type_id = pizza_types.pizza_type_id
join order_details on order_details.pizza_id= pizzas.pizza_id
group by pizza_types.name 
order by revenue desc
limit 3;


-- Advance questions.

-- 1.calculate the percentage contriubution of each pizza type to total revenue.


WITH total_sales_cte AS (
    SELECT 
        SUM(order_details.quantity * pizzas.price) AS total_sales
    FROM order_details
    JOIN pizzas ON pizzas.pizza_id = order_details.pizza_id
),
category_sales_cte AS (
    SELECT 
        pizza_types.category,
        SUM(order_details.quantity * pizzas.price) AS category_sales
    FROM pizza_types
    JOIN pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
    JOIN order_details ON pizzas.pizza_id = order_details.pizza_id
    GROUP BY pizza_types.category
)
SELECT 
    category_sales_cte.category,
    ROUND(category_sales_cte.category_sales / total_sales_cte.total_sales * 100, 2) AS revenue
FROM category_sales_cte
CROSS JOIN total_sales_cte
ORDER BY revenue DESC;

-- 2. Analyze the cumulative revenue generated over time,

select order_date,
round(sum(revenue) over(order by order_date),2) as cum_revenue
from
(select orders.order_date,sum(order_details.quantity * pizzas.price) as revenue
from order_details
join pizzas ON pizzas.pizza_id = order_details.pizza_id
join orders on orders.order_id=order_details.order_id
group by orders.order_date) as sales;


-- 3. determaine the top 3 most ordered pizza types based on revenue for each pizza category

select name, revenue from
(select category,name,revenue,
rank() over(partition by category order by revenue desc) rn
from
(select pizza_types.category,pizza_types.name,
sum(order_details.quantity * pizzas.price) as revenue
from pizza_types
join pizzas on pizzas.pizza_type_id = pizza_types.pizza_type_id
join order_details on order_details.pizza_id = pizzas.pizza_id
group by pizza_types.category,pizza_types.name) as a) as b
where rn <= 3;

