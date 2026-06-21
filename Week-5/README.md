# Week 5 – Apache Spark Data Cleaning and Aggregation

## Objective
Objective: Understand Spark fundamentals and perform data cleaning, transformation, and aggregation using DataFrames. 
Steps: Understand limitations of MapReduce and advantages of Spark (in-memory processing, speed). Learn Spark DataFrame concepts and immutability. 
Perform data cleaning operations (remove duplicates, handle null values). Apply filtering conditions on datasets (age range, category, region). 
Use aggregation functions (count, sum, avg, min, max). Group data using groupBy 
and apply conditions on aggregated results. Understand wide transformations and shuffle operations. Modify schema (casting, renaming columns). 
Handle inconsistent data (nulls, empty values, schema issues). Build a complete data processing pipeline combining cleaning and aggregation.
Output: Spark code (PySpark/Scala) + query results + brief insights on data processing and transformations.

## Tasks Performed
- Created a Spark Session and loaded the dataset into a DataFrame.
- Explored the dataset using `show()`, `printSchema()`, and `describe()`.
- Removed duplicate records using `dropDuplicates()`.
- Handled missing values using `.na.drop()` and `.na.fill()`.
- Applied filters based on region, age, and subscription type.
- Renamed columns and cast timestamp fields to the appropriate data type.
- Performed aggregations using `count()`, `sum()`, `avg()`, `min()`, and `max()`.
- Grouped data using `groupBy()` to generate summary statistics.
- Built a complete processing pipeline to remove duplicates, fill missing prices, and calculate total revenue by `store_id`.

## Files Included
- `Assignment_5.ipynb` – Notebook containing theory answers and PySpark code.
- `Sales_dataset_timestamp_fixed.csv` – Dataset used for the assignment.
- `revenue_by_store.csv` – Output generated from the final aggregation pipeline .

## Key Learning Outcomes
- Understood Spark DataFrames and their immutability.
- Learned the advantages of Spark over MapReduce.
- Practiced data cleaning and schema transformation.
- Implemented filtering, grouping, and aggregation operations.
- Built an end-to-end data processing workflow using PySpark.
