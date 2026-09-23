-- SQL Retail Sales Analysis
CREATE DATABASE sql_project_1;

-- Create Table
DROP TABLE IF EXISTS retail_sales; 
CREATE TABLE retail_sales
(
    transactions_id INT PRIMARY KEY, 
    sale_date DATE, 
    sale_time TIME, 
    customer_id INT, 
    gender VARCHAR(15), 
    age INT, 
    category VARCHAR(15), 
    quantiy INT,
    price_per_unit FLOAT, 
    cogs FLOAT, 
    total_sale FLOAT
);

SELECT * FROM retail_sales
LIMIT 10;

SELECT COUNT(*) FROM retail_sales;

-- Data Cleaning 
-- Handle missing/NULL values (delete, impute, or flag)
-- Remove duplicate records
-- Fix data type mismatches & inconsistent formats (dates, text case)
-- Validate logical accuracy (e.g., outliers, calculated fields matching)

SELECT * FROM retail_sales 
WHERE  transactions_id IS NULL;

-- one by one with this query we will check all the coloumns 
SELECT * FROM retail_sales 
WHERE  sale_date IS NULL;

SELECT * FROM retail_sales 
WHERE  sale_time IS NULL;

-- if any rows is null then show it 
SELECT * FROM retail_sales
WHERE 
       transactions_id IS NULL 
	   OR 
       sale_date IS NULL 
       OR 
       sale_time IS NULL 
       OR 
       customer_id IS NULL 
       OR 
       gender IS NULL 
       OR 
       category IS NULL 
       OR 
       quantiy IS NULL 
       OR 
       price_per_unit IS NULL
       OR 
       cogs IS NULL 
       OR 
       total_sale IS NULL; 
       
-- Delete the rows which has null value 
DELETE FROM retail_sales
WHERE 
       transactions_id IS NULL 
	   OR 
       sale_date IS NULL 
       OR 
       sale_time IS NULL 
       OR 
       customer_id IS NULL 
       OR 
       gender IS NULL 
       OR 
       category IS NULL 
       OR 
       quantiy IS NULL 
       OR 
       price_per_unit IS NULL
       OR 
       cogs IS NULL 
       OR 
       total_sale IS NULL; 

-- Data Exploration 
-- How many sales we have ?
SELECT COUNT(*) AS total_sale FROM retail_sales;

-- How many unique customer we have ?
SELECT  COUNT(DISTINCT customer_id) AS total_sale FROM retail_sales;

-- Unique category we have ?
SELECT DISTINCT category FROM retail_sales;

-- Data Analytics Key Problem & Business Insight 

-- My Analysis & Findings
-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05
-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 10 in the month of Nov-2022
-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.
-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.
-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year
-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 
-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.
-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)

-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05
SELECT * FROM retail_sales WHERE sale_date = '2022-11-05';

-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 10 in the month of Nov-2022
SELECT * FROM retail_sales 
WHERE 
    category = 'Clothing' 
    AND 
    DATE_FORMAT(sale_date, '%Y - m%') = '2022-11'
    AND
    quantiy > 10;
        
--     Code	Matlab	Example Output
-- %Y	Full year (4 digit)	2022
-- %y	Short year (2 digit)	22
-- %m	Month as number	11
-- %M	Month as full name	November
-- %d	Day of month (number)	05
-- %D	Day with suffix	5th
-- %H	Hour (24-hour format)	18
-- %h	Hour (12-hour format)	06

-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.
SELECT 
    category,
    SUM(total_sale) as total_sales
FROM retail_sales
GROUP BY category;

-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
SELECT 
   ROUND(AVG(age), 2) AS Customer_age 
   FROM retail_sales
   WHERE category = 'Beauty';
   
-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.
SELECT * FROM retail_sales
WHERE total_sale > 1000;

-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
SELECT 
category , 
gender , 
COUNT(*) as total_trans
FROM retail_sales
group by category , gender 
ORDER BY 1;

-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year
SELECT 
       year,
       month,
    avg_sale
FROM 
(    
SELECT 
    EXTRACT(YEAR FROM sale_date) as year,
    EXTRACT(MONTH FROM sale_date) as month,
    AVG(total_sale) as avg_sale,
    RANK() OVER(PARTITION BY EXTRACT(YEAR FROM sale_date) ORDER BY AVG(total_sale) DESC) as rank
FROM retail_sales
GROUP BY 1, 2
) as t1
WHERE rank = 1

-- ORDER BY 1, 3 DESC

-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 

SELECT 
    customer_id,
    SUM(total_sale) as total_sales
FROM retail_sales
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5

-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.
SELECT 
    category,    
    COUNT(DISTINCT customer_id) as cnt_unique_cs
FROM retail_sales
GROUP BY category

-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17)

WITH hourly_sale
AS
(
SELECT *,
    CASE
        WHEN EXTRACT(HOUR FROM sale_time) < 12 THEN 'Morning'
        WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
        ELSE 'Evening'
    END as shift
FROM retail_sales
)
SELECT 
    shift,
    COUNT(*) as total_orders    
FROM hourly_sale
GROUP BY shift

-- End of project


   
   



