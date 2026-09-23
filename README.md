# 🛍️ Retail Sales Analysis — SQL Project

## 📌 Project Overview

This project focuses on analyzing retail sales data using **SQL**. The goal was to practice SQL concepts commonly used in data analyst roles, including data exploration, data cleaning, aggregation, filtering, grouping, and business-oriented analysis.

This is my **first SQL data analysis project**, where I worked with a retail sales dataset and used SQL queries to answer practical business questions about sales, customers, product categories, and purchasing patterns.

---

## 🎯 Objectives

* Explore and understand the retail sales dataset
* Check and clean missing data
* Analyze sales performance across product categories
* Understand customer purchasing behavior
* Identify high-value transactions and top customers
* Analyze monthly sales trends
* Analyze sales based on different time shifts
* Practice writing SQL queries for business questions

---

## 🗃️ Dataset & Database

**Database:** MySQL
**Table:** `retail_sales`

### Table Structure

| Column            | Description                     |
| ----------------- | ------------------------------- |
| `transactions_id` | Unique transaction identifier   |
| `sale_date`       | Date of the transaction         |
| `sale_time`       | Time of the transaction         |
| `customer_id`     | Unique customer identifier      |
| `gender`          | Customer gender                 |
| `age`             | Customer age                    |
| `category`        | Product category                |
| `quantity`        | Number of items purchased       |
| `price_per_unit`  | Price of one unit               |
| `cogs`            | Cost of goods sold              |
| `total_sale`      | Total amount of the transaction |

---

## 🔍 Data Exploration & Cleaning

Before performing the analysis, I explored the dataset to understand its structure and check data quality.

### Tasks Performed

* Counted the total number of transactions
* Counted unique customers
* Identified available product categories
* Checked for missing/null values
* Removed records containing missing values where required

Example:

```sql
SELECT COUNT(*)
FROM retail_sales;
```

Null-value check:

```sql
SELECT *
FROM retail_sales
WHERE 
    sale_date IS NULL
    OR sale_time IS NULL
    OR customer_id IS NULL
    OR gender IS NULL
    OR age IS NULL
    OR category IS NULL
    OR quantity IS NULL
    OR price_per_unit IS NULL
    OR cogs IS NULL;
```

---

## 📊 Business Questions & Analysis

I used SQL to answer several business-related questions.

### 1. Sales on a Specific Date

Retrieved all transactions made on `2022-11-05`.

```sql
SELECT *
FROM retail_sales
WHERE sale_date = '2022-11-05';
```

### 2. Clothing Sales in November 2022

Identified clothing transactions where the quantity sold was at least 4 during November 2022.

```sql
SELECT *
FROM retail_sales
WHERE category = 'Clothing'
  AND sale_date >= '2022-11-01'
  AND sale_date < '2022-12-01'
  AND quantity >= 4;
```

### 3. Total Sales by Category

Calculated total sales and number of orders for each product category.

```sql
SELECT 
    category,
    SUM(total_sale) AS total_sales,
    COUNT(*) AS total_orders
FROM retail_sales
GROUP BY category;
```

### 4. Average Customer Age — Beauty Category

Calculated the average age of customers who purchased Beauty products.

```sql
SELECT
    ROUND(AVG(age), 2) AS average_age
FROM retail_sales
WHERE category = 'Beauty';
```

### 5. High-Value Transactions

Identified transactions where the total sale amount was greater than 1000.

```sql
SELECT *
FROM retail_sales
WHERE total_sale > 1000;
```

### 6. Transactions by Gender and Category

Analyzed the number of transactions made by each gender across product categories.

```sql
SELECT 
    category,
    gender,
    COUNT(*) AS total_transactions
FROM retail_sales
GROUP BY category, gender
ORDER BY category;
```

### 7. Best-Selling Month in Each Year

Analyzed average sales by month and identified the highest-performing month for each year using a window function.

```sql
SELECT 
    year,
    month,
    avg_sale
FROM
(
    SELECT 
        YEAR(sale_date) AS year,
        MONTH(sale_date) AS month,
        AVG(total_sale) AS avg_sale,
        RANK() OVER (
            PARTITION BY YEAR(sale_date)
            ORDER BY AVG(total_sale) DESC
        ) AS ranking
    FROM retail_sales
    GROUP BY YEAR(sale_date), MONTH(sale_date)
) AS monthly_sales
WHERE ranking = 1;
```

### 8. Top 5 Customers by Total Spending

Identified the five customers with the highest total sales.

```sql
SELECT 
    customer_id,
    SUM(total_sale) AS total_sales
FROM retail_sales
GROUP BY customer_id
ORDER BY total_sales DESC
LIMIT 5;
```

### 9. Unique Customers by Category

Calculated the number of unique customers purchasing from each category.

```sql
SELECT 
    category,
    COUNT(DISTINCT customer_id) AS unique_customers
FROM retail_sales
GROUP BY category;
```

### 10. Sales by Time Shift

Grouped transactions into Morning, Afternoon, and Evening shifts to understand when most orders were placed.

```sql
WITH hourly_sales AS
(
    SELECT *,
        CASE
            WHEN HOUR(sale_time) < 12 THEN 'Morning'
            WHEN HOUR(sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
            ELSE 'Evening'
        END AS shift
    FROM retail_sales
)
SELECT 
    shift,
    COUNT(*) AS total_orders
FROM hourly_sales
GROUP BY shift;
```

---

## 🧠 SQL Concepts Practiced

Through this project, I practiced:

* `SELECT`
* `WHERE`
* `AND` / `OR`
* `DISTINCT`
* `COUNT()`
* `COUNT(DISTINCT)`
* `SUM()`
* `AVG()`
* `ROUND()`
* `GROUP BY`
* `ORDER BY`
* `LIMIT`
* `CASE`
* `CTE (Common Table Expression)`
* `RANK()`
* Window Functions
* Date and time functions
* Data cleaning and null-value handling

---

## 💡 Key Learning Outcomes

This project helped me understand how SQL can be used beyond simply retrieving data.

I practiced how to:

* Explore an unfamiliar dataset before analyzing it
* Check data quality before generating insights
* Convert business questions into SQL queries
* Aggregate data to find useful patterns
* Analyze customers, categories, and sales performance
* Use CTEs and window functions for more advanced analysis
* Think about SQL from a **data analyst/business perspective**

---

## 🚀 Future Improvements

As I continue improving my SQL and data analytics skills, I plan to extend this project by:

* Adding more complex business questions
* Performing deeper customer segmentation
* Analyzing repeat customers
* Comparing revenue and profit using COGS
* Creating additional time-based analysis
* Connecting the analysis to **Power BI** for visualization
* Adding more independently developed SQL queries

---

## 🛠️ Tools Used

* **MySQL**
* **SQL**
* **GitHub**

---

## 📁 Project Structure

```text
Retail-Sales-Analysis/
│
├── README.md
├── database_setup.sql
└── analysis_queries.sql
```

---

## 👩‍💻 About the Project

This project is part of my journey toward becoming a **Data Analyst**.

It was my first hands-on SQL project and helped me build a foundation in SQL-based data exploration, cleaning, and business analysis.

I am continuing to work on SQL, Excel, Power BI, and other data analytics projects to strengthen my practical skills.

---

⭐ **Thanks for checking out my project!**
