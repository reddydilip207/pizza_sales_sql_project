## Pizza Sales SQL Analytics Project
A SQL-based data analysis project that explores pizza sales data to uncover business insights such as revenue trends, customer ordering behavior, 
and product performance. This project demonstrates practical SQL skills including joins, aggregations, CTEs, and window functions.

 ## STAR Breakdown ##
– **Situation** :
-- A fictional pizza chain needed to understand its sales performance, customer preferences, and product profitability using historical order data.

– ** Task Design **:
-- Design and execute a SQL-based analytics solution to answer 12 targeted business questions related to revenue, order volume, pizza popularity, and category contributions.

- ** Action **
-- Created a normalized database schema with four tables: orders, order_details, pizzas, and pizza_types.
-- Wrote SQL queries using JOIN, GROUP BY, CTE, RANK(), and SUM() OVER() to analyze total revenue, peak order hours, most popular pizza sizes, and top-selling pizza types.
-- Performed time-based analysis, category-wise breakdowns, and cumulative revenue tracking to uncover trends and performance metrics.

- ** Result **
-- Analyzed 21,350 orders and calculated ₹8.17 lakh in total revenue.
-- Identified Large pizzas as the most popular size and Thai Chicken Pizza as the top revenue generator.
-- Delivered a reusable SQL portfolio project showcasing advanced querying techniques and actionable business insights.


## Database Schema ##

## sql ##

-- pizza_types
CREATE TABLE pizza_types (
  pizza_type_id INT PRIMARY KEY,
  name VARCHAR(50),
  category VARCHAR(50)
);

-- pizzas
CREATE TABLE pizzas (
  pizza_id INT PRIMARY KEY,
  pizza_type_id INT,
  size VARCHAR(10),
  price DECIMAL(5,2),
  FOREIGN KEY (pizza_type_id) REFERENCES pizza_types(pizza_type_id)
);

-- orders
CREATE TABLE orders (
  order_id INT PRIMARY KEY,
  order_date DATE,
  order_time TIME
);

-- order_details 
CREATE TABLE order_details (
  order_details_id INT PRIMARY KEY,
  order_id INT,
  pizza_id INT,
  quantity INT,
  FOREIGN KEY (order_id) REFERENCES orders(order_id),
  FOREIGN KEY (pizza_id) REFERENCES pizzas(pizza_id)
);


## Key Business Questions Answered ##

-- Total number of orders placed
-- Total revenue generated from pizza sales
-- Highest-priced pizza
-- Most common pizza size ordered
-- Top 5 most ordered pizza types
-- Total quantity of each pizza category ordered
-- Distribution of orders by hour of the day
-- Category-wise distribution of pizzas
-- Average number of pizzas ordered per day
-- Top 3 pizza types based on revenue
-- Percentage contribution of each category to total revenue
-- Cumulative revenue generated over time


## How to Use ##

-- Clone the repository
-- Import the schema and sample data into your SQL environment (MySQL)
-- Run the queries in your SQL editor to explore the insights

