#  Pizza Sales Analysis — SQL Portfolio Project

## Overview
This project analyzes pizza order data using **MySQL**, showcasing SQL proficiency across multiple levels — from basic aggregations to advanced revenue analysis using CTEs and window functions. It’s designed to extract business insights and support BI storytelling, with optional Power BI dashboard integration.


##  Objectives
- Query and analyze pizza sales data using MySQL
- Answer business questions across product, time, and revenue dimensions
- Apply advanced SQL techniques like CTEs and window functions
- Prepare insights for visualization in Power BI or Excel

## Database Schema

-- **Table: pizza_types**
 Database
 CREATE TABLE pizza_types (
 pizza_type_id INT PRIMARY KEY,
 name VARCHAR(50),
 category VARCHAR(50)
 );
 Table: pizzas
 CREATE TABLE pizzas (
 pizza_id INT PRIMARY KEY,
 pizza_type_id INT,
 size VARCHAR(10),
 price DECIMAL(5,2),
 FOREIGN KEY (pizza_type_id) REFERENCES pizza_types(pizza_type_id)
 );
 
 -- **Table: orders**
 CREATE TABLE orders (
 order_id INT PRIMARY KEY,
 order_date DATE,
 order_time TIME
 );
 
-- **Table: order_details**
 CREATE TABLE order_details (
 order_details_id INT PRIMARY KEY,
 order_id INT,
 pizza_id INT,
 quantity INT,
 Schema
 FOREIGN KEY (order_id) REFERENCES orders(order_id),
 FOREIGN KEY (pizza_id) REFERENCES pizzas(pizza_id)
 )

##  Database Structure
The project uses four normalized tables:
- orders: Contains order timestamps and dates
- order_details: Links orders to pizzas and quantities
- pizzas: Contains pizza size, price, and type ID
- pizza_types: Contains pizza name and category


##  Business Questions Answered

###  Basic
- Total number of orders placed
- Total revenue generated from pizza sales
- Highest-priced pizza
- Most common pizza size ordered
- Top 5 most ordered pizza types

### Intermediate
- Quantity of pizzas ordered by category
- Distribution of orders by hour of the day
- Category-wise pizza distribution
- Average pizzas ordered per day
- Top 3 pizza types by revenue

### Advanced
- Percentage contribution of each category to total revenue
- Cumulative revenue over time
- Top 3 pizza types by revenue within each category


## Sample Business Insights

- **Total Revenue:** Calculated using SUM(quantity × price) across all orders
- **Peak Order Hours:** Identified using HOUR(order_time) aggregation
- **Top Categories:** Ranked by total quantity and revenue
- **Cumulative Revenue:** Tracked over time using window functions
- **Top Pizza Types by Category:** Ranked using RANK() over partitions

## SQL Techniques Used
- JOIN, GROUP BY, ORDER BY, LIMIT
- ROUND(), SUM(), COUNT(), AVG()
- Common Table Expressions (CTEs)
- Window functions: RANK(), OVER()
- Subqueries and nested aggregations


## Tools Used
- MySQL
- MySQL Workbench 

LINK:https://github.com/reddydilip207/pizza_sales_sql_project/blob/main/Pizza%20Sales%20project.sql
