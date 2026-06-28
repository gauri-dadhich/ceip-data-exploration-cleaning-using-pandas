# Week 6 - Apache Spark Architecture & Data Processing

## Objective: 
Understand Spark architecture and perform efficient data processing using transformations, filtering, schema handling, and optimized file formats. Steps: Understand Spark architecture (Driver, Cluster Manager, Executors) and execution modes. Learn Lazy Evaluation and how it optimizes execution using DAG (Lineage Graph). Read data from files (CSV, Parquet) with proper schema handling. Perform filtering and selection of required columns. Modify DataFrames (rename columns, cast data types, add new columns). Apply transformations and actions appropriately. Understand wide transformations and performance concepts (Shuffle, Predicate Pushdown). Work with different file formats (CSV vs Parquet) and their impact on performance. Handle null values and filter datasets efficiently. Build data pipelines (read → transform → filter → write). Save processed data into required formats (CSV/Parquet). Follow best practices for large datasets (avoid collect(), use show()). Output: Spark code (PySpark/Scala) + execution results + brief insights on performance and architecture.

## Topics Covered
- Spark Architecture
- Driver, Cluster Manager, Executors
- Lazy Evaluation
- DAG (Lineage Graph)
- CSV vs Parquet
- DataFrame Transformations
- Filtering
- Schema Modification
- Predicate Pushdown

## Files
- Week6_Assignment.ipynb
- source.csv
- source_parquet/

## Tools Used
- Google Colab
- PySpark


Performance Insights
Spark uses lazy evaluation, meaning transformations are not executed until an action is called. This allows Spark to optimize the execution plan.
Parquet files provide better performance than CSV because they use columnar storage, reducing disk I/O and improving query speed.
Predicate Pushdown minimizes the amount of data read from storage by filtering records before they are loaded into memory.
Using .show(5) instead of .collect() is safer for large datasets because it retrieves only a small sample of data, preventing memory issues.
DataFrames are optimized using Spark's Catalyst Optimizer, which improves query execution automatically.

Architecture Insights
The Driver coordinates the Spark application, creates execution plans, and assigns tasks.
The Cluster Manager allocates resources and manages the executors across the cluster.
Executors perform the actual computations and store intermediate data during processing.
Spark maintains a Directed Acyclic Graph (DAG) to track transformations, optimize execution, and provide fault tolerance by recomputing only lost data partitions if a failure occurs.
Client Mode is suitable for development and debugging, while Cluster Mode is preferred for production because the Driver runs inside the cluster, improving reliability.
