SHOW DATABASES;
use gauri;
CREATE TABLE customers ( 
    customer_id   INT           PRIMARY KEY, 
    first_name    VARCHAR(50)   NOT NULL, 
    last_name     VARCHAR(50)   NOT NULL, 
    email         VARCHAR(100)  UNIQUE NOT NULL, 
    city          VARCHAR(50)   NOT NULL, 
    state         VARCHAR(50)   NOT NULL, 
    join_date     DATE          NOT NULL, 
    is_premium    BOOLEAN       DEFAULT FALSE 
); 
 
-- Index for filtering by city/state 
CREATE INDEX idx_customers_city ON customers(city); 
CREATE INDEX idx_customers_state ON customers(state); 

CREATE TABLE products ( 
    product_id    INT           PRIMARY KEY, 
    product_name  VARCHAR(100)  NOT NULL, 
    category      VARCHAR(50)   NOT NULL, 
    brand         VARCHAR(50)   NOT NULL, 
    unit_price    DECIMAL(10,2) NOT NULL  CHECK (unit_price > 0), 
    stock_qty     INT           NOT NULL  DEFAULT 0  CHECK (stock_qty >= 0) 
); 
 
-- Index for filtering by category 
CREATE INDEX idx_products_category ON products(category); 

CREATE TABLE orders ( 
    order_id      INT           PRIMARY KEY, 
    customer_id   INT           NOT NULL, 
    order_date    DATE          NOT NULL, 
    status        VARCHAR(20)   NOT NULL  DEFAULT 'Pending' 
                  CHECK (status IN ('Pending','Shipped','Delivered','Cancelled')), 
    total_amount  DECIMAL(12,2) NOT NULL  CHECK (total_amount >= 0), 
     
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id) 
); 
 
-- Index for date-based filtering and sorting 
CREATE INDEX idx_orders_date ON orders(order_date); 
CREATE INDEX idx_orders_status ON orders(status); 

CREATE TABLE order_items ( 
    item_id       INT           PRIMARY KEY, 
    order_id      INT           NOT NULL, 
    product_id    INT           NOT NULL, 
    quantity      INT           NOT NULL  CHECK (quantity > 0), 
    unit_price    DECIMAL(10,2) NOT NULL  CHECK (unit_price > 0), 
    discount_pct  DECIMAL(5,2)  DEFAULT 0 CHECK (discount_pct BETWEEN 0 AND 100), 
     
    FOREIGN KEY (order_id)   REFERENCES orders(order_id), 
    FOREIGN KEY (product_id) REFERENCES products(product_id) 
);

-- ========== INSERT: customers ========== 
INSERT INTO customers VALUES 
(101, 'Aarav',  'Sharma', 'aarav.s@email.com',  'Mumbai',    'Maharashtra', '2024-01-15', TRUE), 
(102, 'Priya',  'Patel',  'priya.p@email.com',  'Ahmedabad', 'Gujarat',     '2024-02-20', FALSE), 
(103, 'Rohan',  'Gupta',  'rohan.g@email.com',  'Delhi',     'Delhi',       '2024-03-10', TRUE), 
(104, 'Sneha',  'Reddy',  'sneha.r@email.com',  'Hyderabad', 'Telangana',   '2024-04-05', FALSE), 
(105, 'Vikram', 'Singh',  'vikram.s@email.com', 'Jaipur',    'Rajasthan',   '2024-05-12', TRUE), 
(106, 'Ananya', 'Iyer',   'ananya.i@email.com', 'Chennai',   'Tamil Nadu',  '2024-06-18', FALSE), 
(107, 'Karan',  'Mehta',  'karan.m@email.com',  'Pune',      'Maharashtra', '2024-07-22', TRUE), 
(108, 'Divya',  'Nair',   'divya.n@email.com',  'Kochi',     'Kerala',      '2024-08-30', FALSE); 
SELECT* FROM customers;

INSERT INTO products VALUES 
(201, 'Wireless Earbuds',     'Electronics', 'BoAt',          1499.00, 250), 
(202, 'Cotton T-Shirt',       'Clothing',    'Levis',         799.00,  500), 
(203, 'Smart Watch',          'Electronics', 'Noise',         2999.00, 150), 
(204, 'Running Shoes',        'Clothing',    'Nike',          4599.00, 120), 
(205, 'Bluetooth Speaker',    'Electronics', 'JBL',           3499.00, 200), 
(206, 'Bedsheet Set',         'Home',        'Spaces',        1299.00, 300), 
(207, 'Laptop Stand',         'Electronics', 'AmazonBasics',  899.00,  180), 
(208, 'Cushion Covers (Set)', 'Home',        'HomeCenter',    599.00,  400);

INSERT INTO orders VALUES 
(1001, 101, '2024-08-01', 'Delivered',  4498.00), 
(1002, 102, '2024-08-03', 'Delivered',  799.00), 
(1003, 103, '2024-08-05', 'Shipped',    7498.00), 
(1004, 101, '2024-08-10', 'Delivered',  3499.00), 
(1005, 104, '2024-08-12', 'Cancelled',  2999.00), 
(1006, 105, '2024-08-15', 'Delivered',  5898.00), 
(1007, 106, '2024-08-18', 'Pending',    1299.00), 
(1008, 103, '2024-08-20', 'Delivered',  899.00), 
(1009, 107, '2024-08-25', 'Shipped',    6098.00), 
(1010, 108, '2024-08-28', 'Delivered',  1598.00); 

-- ========== INSERT: order_items ========== 
INSERT INTO order_items VALUES 
(5001, 1001, 201, 2, 1499.00, 0), 
(5002, 1001, 207, 1, 899.00,  10), 
(5003, 1002, 202, 1, 799.00,  0), 
(5004, 1003, 203, 1, 2999.00, 0), 
(5005, 1003, 204, 1, 4599.00, 5), 
(5006, 1004, 205, 1, 3499.00, 0), 
(5007, 1005, 203, 1, 2999.00, 0), 
(5008, 1006, 201, 1, 1499.00, 10), 
(5009, 1006, 204, 1, 4599.00, 5), 
(5010, 1007, 206, 1, 1299.00, 0), 
(5011, 1008, 207, 1, 899.00,  0), 
(5012, 1009, 205, 1, 3499.00, 0), 
(5013, 1009, 208, 2, 599.00,  15), 
(5014, 1010, 206, 1, 1299.00, 0), 
(5015, 1010, 208, 1, 599.00,  0); 

-- SECTION A
-- Q1)
SELECT * FROM customers;
-- Q2)
SELECT first_name, last_name, city
FROM   customers;

-- Q3)
SELECT DISTINCT category
FROM   products;

-- Q4)
DESCRIBE customers;
DESC products;
DESC orders;
DESC order_items;
 /*
Primary keys were identified using the DESC command on each table.
The primary keys are customer_id in the customers table, product_id in the products table,
order_id in the orders table, and order_item_id in the order_items table. In the DESC output,
the Key column displays 'PRI' for the primary key attribute.
A Primary Key is used to uniquely identify each record in a table. It must be UNIQUE because
no two rows should have the same identifier; otherwise, it would be difficult to distinguish
between records. A Primary Key must also be NOT NULL because every row must have a valid
identifier. If NULL values were allowed, some records would not have a unique identity,
which would compromise data integrity and make it difficult to establish relationships
between tables.
*/

-- Q5)
/*
The email column in the customers table has a UNIQUE constraint applied to it.
This constraint ensures that each customer has a distinct email address and
prevents duplicate email values from being stored in the table.
If an attempt is made to insert a record with an email address that already
exists in the customers table, MySQL will reject the insertion and generate
an error indicating a duplicate entry for the UNIQUE key. This helps maintain
data uniqueness by ensuring that each email address is associated with only
one customer record.
*/
INSERT INTO customers VALUES
(209, 'Gauri', 'Dadhich', 'aarav.s@email.com', 'jaipur','Rajasthan','2024-05-12',TRUE);

-- Q6)
INSERT INTO products VALUES
(209, 'Broken Item', 'Electronics', 'FakeBrand', -50.00, 100);
--  Shows "Check constraint 'products_chk_1' is violated" ERROR,the insertion
-- fails because the products table has a CHECK constraint on the unit_price
-- column that ensures the price must be greater than zero.
-- The CHECK constraint validates the value before inserting the record.
-- Since -50 is a negative value, it violates the constraint condition and
-- MySQL rejects the insertion.

-- SECTION B
-- Q7)
SELECT*
FROM   orders
WHERE  status = 'Delivered';
-- Q8)
SELECT* FROM   products WHERE  category = 'Electronics' AND  unit_price > 2000;
-- Q9)
SELECT* FROM   customers WHERE  join_date >= '2024-01-01'
  AND  join_date <  '2025-01-01'
  AND  state = 'Maharashtra';
-- Q10)
SELECT* FROM   orders WHERE  order_date BETWEEN '2024-08-10' AND '2024-08-25' AND  status != 'Cancelled';
-- Q11)
/*
The idx_orders_date index is created on the order_date column of the orders table.
It helps MySQL find records for a particular date faster instead of checking every row
in the table,It assigns a seprate memory to the column where data is orgainized in ordered format hence takes (log n) time
and there is a pointer to the memory location of the row containing that column.
This improves query performance, especially when the table contains a 
large number of orders.

Example:
SELECT * FROM orders
WHERE order_date = '2024-08-15';
*/

-- Q12)
/*
No, the index on join_date would not be used efficiently in the query
WHERE YEAR(join_date) = 2024 because MySQL first has to calculate the
YEAR value for every row and then compare it with 2024. Since a function
is applied on the indexed column, MySQL cannot directly use the index and
may end up scanning the whole table.

A better approach is to use a date range:
*/

SELECT * FROM customers
WHERE join_date >= '2024-01-01'
AND join_date < '2025-01-01';
/*

This query gives the same result but allows MySQL to use the index on
join_date directly. Instead of checking every row, it can quickly find
all records whose join_date falls within the given range, making the
query faster and more efficient.
*/

-- SECTION C
-- Q13)
SELECT COUNT(*) AS total_order FROM orders;
-- Q14)
select sum(total_amount) AS total_revenue from orders where status='Delivered';
-- Q15)
select category,AVG(unit_price) AS AVG_PRICE from products group BY category;
-- Q16)
SELECT status,count(*) AS count_of_orders,sum(total_amount) AS total_revenue from orders GROUP BY status ORDER BY total_revenue DESC;
-- Q17)
SELECT category,MAX(unit_price) AS most_expensive,MIN(unit_price) AS less_expensive from products GROUP BY category;
-- Q18)
SELECT category,avg(unit_price) AS avg_price FROM products GROUP BY category having avg_price>2000;

-- SECTION D
-- Q19)
SELECT c.customer_id,c.first_name,c.last_name,o.order_id,o.order_date,o.total_amount from orders as o
INNER JOIN customers as c ON o.customer_id=c.customer_id;
-- Q20)
SELECT c.first_name,c.last_name,c.customer_id,o.order_id from customers as c
LEFT JOIN orders as o ON c.customer_id=o.customer_id;
-- Q21)
SELECT o.order_id,p.product_name,oi.quantity,oi.unit_price,oi.discount_pct FROM orders AS o
JOIN order_items AS oi ON o.order_id=oi.order_id
JOIN products AS p ON oi.product_id=p.product_id;
/* Q22)
LEFT JOIN: LEFT JOIN returns all records from the left table and matching
records from the right table.
EX) SELECT c.customer_id, c.first_name, o.order_id
FROM   customers c LEFT JOIN orders o ON c.customer_id = o.customer_id;
 
RIGHT JOIN:returns all records from the right table and matching
records from the left table.
EX)SELECT c.customer_id, c.first_name, o.order_id
FROM   customers c RIGHT JOIN orders o ON c.customer_id = o.customer_id;
 
FULL OUTER JOIN:A FULL OUTER JOIN returns all records from both tables, whether
a match exists or not. It is useful when we want to see every
customer and every order, including unmatched records from both sides.
EX)SELECT c.customer_id, c.first_name, o.order_id
FROM   customers c LEFT  JOIN orders o ON c.customer_id = o.customer_id
UNION
SELECT c.customer_id, c.first_name, o.order_id
FROM   customers c RIGHT JOIN orders o ON c.customer_id = o.customer_id;
/*

-- Q23) implemented case when statement to identify foreign keys
SELECT
    TABLE_NAME,
    COLUMN_NAME,
    REFERENCED_TABLE_NAME,
    REFERENCED_COLUMN_NAME
FROM INFORMATION_SCHEMA.KEY_COLUMN_USAGE
WHERE TABLE_SCHEMA = 'gauri'
AND REFERENCED_TABLE_NAME IS NOT NULL;
-- /*
Foreign Keys create relationships between tables and ensure referential integrity.
If we try to insert an order with customer_id = 999 and no customer with customer_id = 999 exists in the customers table,
MySQL will reject the insertion and generate a Foreign Key
constraint error. This prevents orders from being linked to customers that do
not exist in the database.
*/
INSERT INTO orders VALUES (201, 999, '2024-06-20', 'Pending', 5000);
--  shows ERROR-"Cannot add or update a child row: a foreign key constraint fails (`gauri`.`orders`, CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`customer_id`))"

-- SECTION E

-- Q24) 
SELECT product_name,
       unit_price,
       CASE
           WHEN unit_price < 1000 THEN 'Budget'
           WHEN unit_price BETWEEN 1000 AND 3000 THEN 'Mid Range'
           ELSE 'Premium'
       END AS price_tier
FROM products;

-- Q25)
-- My thinking was to use this 
-- SELECT
--     CASE
--         WHEN status = 'Delivered' THEN 'Delivered'
--         ELSE 'Not Delivered'
--     END AS order_type,
--     COUNT(*) AS total_orders
-- FROM orders
-- GROUP BY order_type;
-- But it returns 2 rows and questions askr to return single row

SELECT
    COUNT(CASE WHEN status = 'Delivered' THEN 1 END) AS Delivered_Orders,
    COUNT(CASE WHEN status != 'Delivered' THEN 1 END) AS Not_Delivered_Orders
FROM orders;
-- Q26)

/*
A - Atomicity:
Atomicity means a transaction is treated as a single unit. Either all
operations succeed or none of them do.The transaction will be in single account.

C - Consistency:
Consistency ensures that data remains valid before and after a transaction.
Database rules and constraints like UNIQUE,CHECK  should never be violated.

I - Isolation:
Isolation ensures that multiple transactions running at the same time
do not interfere with each other.they runs parallely without interfering in each other.

D - Durability:
Durability ensures that once a transaction is committed, the changes
are permanently saved even if the system crashes.

Bank Transfer Example:

Suppose ₹1000 is transferred from Account A to Account B.

Atomicity:
If money is deducted from A but not added to B due to an error, the
entire transaction is rolled back.

Consistency:
The total amount of money in the system remains unchanged after the transfer and maintains the current balance.

Isolation:
Two transfers happening at the same time should not affect each other's results.

Durability:
Once the transfer is completed and committed, the updated balances remain
saved even if the database server suddenly shuts down.
*/

-- Q27)
START TRANSACTION;
INSERT INTO orders
VALUES (1011, 102, CURDATE(), 'Pending', 1598.00);
INSERT INTO order_items
VALUES
(5016, 1011, 201, 1, 234.00, 0),
(5017, 1011, 202, 1, 1234.00, 0);
UPDATE products
SET stock_qty = stock_qty - 1
WHERE product_id = 201;
UPDATE products
SET stock_qty = stock_qty - 1
WHERE product_id = 202;

COMMIT;
