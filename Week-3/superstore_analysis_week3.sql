CREATE DATABASE superstore;
USE superstore;
-- Step 1: Setup Data 

SELECT * FROM superstore_raw LIMIT 10;
-- reviewing coloumns to create tables 
select* from superstore_raw LIMIT 1;
-- 1) TABLE CREATION
-- CUSTOMERS TABLE 
CREATE TABLE customers (
customer_id VARCHAR(20),
customer_name VARCHAR(100),
segment VARCHAR(50),
country VARCHAR(50),
city VARCHAR(50),
state VARCHAR(50),
postal_code INT,
region VARCHAR(50)
);

-- products table 
CREATE TABLE products (
product_id VARCHAR(30),
product_name VARCHAR(255),
category VARCHAR(50),
sub_category VARCHAR(50)
);
-- ORDERS TABLE 
CREATE TABLE orders (
order_id VARCHAR(30),
order_date DATE,
ship_date DATE,
ship_mode VARCHAR(50),
customer_id VARCHAR(20),
product_id VARCHAR(30),
sales DECIMAL(10,2),
quantity INT,
discount DECIMAL(5,2),
profit DECIMAL(10,2)
);
-- 3)Insert data into these tables using SELECT DISTINCT.
INSERT INTO customers
SELECT DISTINCT
`Customer ID`,
`Customer Name`,
Segment,
Country,
City,
State,
`Postal Code`,
Region FROM superstore_raw;

INSERT INTO products
SELECT DISTINCT
    `Product ID`,
    `Product Name`,
    Category,
    `Sub-Category`
FROM superstore_raw;
TRUNCATE TABLE orders;

INSERT INTO orders(
order_id,
order_date,
ship_date,
ship_mode,
customer_id,
product_id,
sales,
quantity,
discount,
profit)
SELECT DISTINCT
`Order ID`,
STR_TO_DATE(`Order Date`, '%c/%e/%Y'),
STR_TO_DATE(`Ship Date`, '%c/%e/%Y'),
`Ship Mode`,
`Customer ID`,
`Product ID`,
Sales,
Quantity,
Discount,
Profit FROM superstore_raw;

SELECT COUNT(*) AS customer_count FROM customers;

SELECT COUNT(*) AS product_count FROM products;

SELECT COUNT(*) AS order_count FROM orders;
-- Step 2: Perform Required Queries 

-- 1) Find all orders where sales are greater than the average sales. (Subquery) 
SELECT * FROM orders WHERE sales > (SELECT AVG(sales) FROM orders);

-- 2)Find the highest sales order for each customer. (Subquery)  
SELECT o.customer_id,o.order_id,o.sales FROM orders o JOIN (
SELECT customer_id,MAX(sales) AS max_sales FROM orders GROUP BY customer_id) m
ON o.customer_id = m.customer_id
AND o.sales = m.max_sales;

-- 3) Calculate total sales for each customer. (CTE)  
-- using group by:- select customer_id, sum(sales) from orders group by customer_id;
with cust_sales as
(select customer_id,sum(sales) AS total_sales from orders GROUP BY customer_id)
select* from cust_sales;

--  4)Find customers whose total sales are above average. (CTE + Subquery)  
with Total as(
select customer_id,sum(sales) As total_sales from orders  group by customer_id)
select * from Total where total_sales>(select AVG(total_sales) from Total);

-- 5) Rank all customers based on total sales. (Window Function)  
with Total as(
select customer_id,sum(sales) As total_sales from orders group by customer_id)
select * ,
rank() over (ORDER BY total_sales DESC) as sales_rank from Total;
 
 -- 6)Assign row numbers to each order within a customer. (Window Function + PARTITION BY)  
 select* from(
 select *,row_number() over(partition by customer_id order by sales DESC) AS row_num
 from orders) t;
 
 -- 7) Display top 3 customers based on total sales. (Window Function)  
 with Total as(
select customer_id,sum(sales) As total_sales from orders group by customer_id)
select * from(
select   customer_id,total_sales,RANK() over( order by total_sales desc) as sales_rank
from Total) rnk
where sales_rank<=3;

 
-- STEP 3 FINAL COMBINED QUERY
-- Write one final query that shows: 
-- Customer Name  ,Total Sales ,Rank  (Use JOIN + CTE + Window Function together)

with customer_Sales as(
select customer_id,SUM(sales) as total_Sales from orders group by customer_id)
select DISTINCT
c.customer_name,cs.total_sales,rank() over (order by cs.total_sales desc) as sales_rank
from customer_sales cs
JOIN customers c ON cs.customer_id=c.customer_id;

-- Mini Project: Customer Sales Insights -- 
-- 1) Who are the top 5 customers?  
WITH customer_sales AS (
SELECT customer_id,SUM(sales) AS total_sales FROM orders GROUP BY customer_id)
SELECT *
FROM (SELECT customer_id,total_sales,RANK() OVER (ORDER BY total_sales DESC) AS sales_rank
FROM customer_sales
) t
WHERE sales_rank <= 5;

-- 2) Who are the bottom 5 customers?  
WITH customer_sales AS (
SELECT customer_id,SUM(sales) AS total_sales FROM orders GROUP BY customer_id)
SELECT *
FROM (SELECT customer_id,total_sales,RANK() OVER (ORDER BY total_sales ASC) AS sales_rank FROM customer_sales
) t
WHERE sales_rank <= 5;
-- 3) Which customers made only one order?  
 SELECT customer_id
FROM orders
GROUP BY customer_id
HAVING COUNT(*) = 1;
 
-- 4) Which customers have above-average sales?  
WITH customer_sales AS (
SELECT customer_id,SUM(sales) AS total_sales FROM orders GROUP BY customer_id)
SELECT customer_id,total_sales FROM customer_sales WHERE total_sales > (SELECT AVG(total_sales)
FROM customer_sales
); 

-- 5)What is the highest order value per customer? 
SELECT customer_id,MAX(sales) AS highest_order_value
FROM orders GROUP BY customer_id; 