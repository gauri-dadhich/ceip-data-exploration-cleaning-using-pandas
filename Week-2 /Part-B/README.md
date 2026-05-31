# Part B - E-Commerce Sales Database

## Objective

Design and implement an E-Commerce Sales Database using SQL while demonstrating database design principles, constraints, indexing, querying, joins, aggregations, transactions, and optimization techniques and applied the necessary queries for given questions.

## Database Schema

The database consists of four related tables:

### Customers

Stores customer information including:

* Customer ID
* Name
* Email
* City and State
* Join Date
* Premium Membership Status

### Products

Stores product details including:

* Product ID
* Product Name
* Category
* Brand
* Unit Price
* Stock Quantity

### Orders

Stores order information including:

* Order ID
* Customer ID
* Order Date
* Order Status
* Total Amount

### Order Items

Stores item-level order details including:

* Item ID
* Order ID
* Product ID
* Quantity
* Unit Price
* Discount Percentage

## Database Features Implemented

### Constraints

* Primary Keys
* Foreign Keys
* Unique Constraints
* NOT NULL Constraints
* CHECK Constraints
* Default Values

### Indexing

Created indexes to improve query performance on:

* Customer City
* Customer State
* Product Category
* Order Date
* Order Status

### Data Validation

Demonstrated:

* UNIQUE constraint violation
* CHECK constraint violation
* FOREIGN KEY constraint violation

## SQL Concepts Covered

### Data Retrieval

* SELECT
* DISTINCT
* Filtering with WHERE
* Date Range Queries

### Aggregate Functions

* COUNT()
* SUM()
* AVG()
* MIN()
* MAX()

### Grouping

* GROUP BY
* HAVING
* ORDER BY

### Joins

* INNER JOIN
* LEFT JOIN
* RIGHT JOIN
* FULL OUTER JOIN (using UNION)

### Conditional Logic

* CASE WHEN statements
* Order Classification
* Product Price Categorization



### Database Transactions

Implemented transaction handling using:

* START TRANSACTION
* UPDATE
* INSERT
* COMMIT

### ACID Properties

Explained:

* Atomicity
* Consistency
* Isolation
* Durability

## Tools Used

* MySQL
* vs code
* SQL
* GitHub

## Files

* Week2_ECommerce_Sales_Database.sql
