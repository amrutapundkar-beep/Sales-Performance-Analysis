CREATE DATABASE sales_project;
USE sales_project;

CREATE TABLE sales_data (
    order_id VARCHAR(50),
    product VARCHAR(255),
    category VARCHAR(255),
    sub_category VARCHAR(255),
    region VARCHAR(50),
    customer_id VARCHAR(50),
    customer_name VARCHAR(100),
    order_date DATE,
    quantity INT,
    price FLOAT,
    total_sales FLOAT,
    payment_method VARCHAR(50)
);

#Retrieve total sales per region
SELECT region,
       SUM(total_sales) AS total_sales_amount
FROM sales_data
GROUP BY region;


#Find top 5 best-selling products
SELECT product,
       SUM(quantity) AS total_quantity_sold
FROM sales_data
GROUP BY product
ORDER BY total_quantity_sold DESC
LIMIT 5;


#Calculate monthly revenue
SELECT 
    YEAR(order_date) AS year,
    MONTH(order_date) AS month,
    SUM(total_sales) AS monthly_revenue
FROM sales_data
GROUP BY YEAR(order_date), MONTH(order_date)
ORDER BY year, month;


#Identify repeat customers
SELECT customer_id,
       customer_name,
       COUNT(order_id) AS number_of_orders
FROM sales_data
GROUP BY customer_id, customer_name
HAVING COUNT(order_id) > 1;


#Find average order value per region
SELECT region,
       AVG(total_sales) AS average_order_value
FROM sales_data
GROUP BY region;


#Determine peak sales day
SELECT order_date,
       SUM(total_sales) AS daily_sales
FROM sales_data
GROUP BY order_date
ORDER BY daily_sales DESC
LIMIT 1;


# Rank products by sales within each category
SELECT 
    category,
    product,
    SUM(total_sales) AS product_sales,
    RANK() OVER (PARTITION BY category ORDER BY SUM(total_sales) DESC) AS sales_rank
FROM sales_data
GROUP BY category, product;


# Payment method-wise sales
SELECT payment_method,
       SUM(total_sales) AS total_sales
FROM sales_data
GROUP BY payment_method;


#Category-wise sales
SELECT category,
       SUM(total_sales) AS total_sales
FROM sales_data
GROUP BY category
ORDER BY total_sales DESC;
