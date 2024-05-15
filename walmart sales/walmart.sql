CREATE DATABASE IF NOT EXISTS salesWalmart;
USE salesWalmart;
CREATE TABLE IF NOT EXISTS sales(
     invoice_id VARCHAR(30) NOT NULL PRIMARY KEY,
     branch VARCHAR(5) NOT NULL,
     city VARCHAR(30) NOT NULL,
     customer_type  VARCHAR(30) NOT NULL,
     gender  VARCHAR(10) NOT NULL,
     product_line  VARCHAR(100) NOT NULL,
     unit_price  DECIMAL(10,2) NOT NULL,
     quantity INT NOT NULL,
     vat FLOAT(6,4) NOT NULL,
     total DECIMAL(10,2) NOT NULL,
     date DATETIME NOT NULL,
     time TIME NOT NULL,
     payment_method VARCHAR(15) NOT NULL,
     cogs DECIMAL(10,2) NOT NULL,
     gross_mrgin_pct FLOAT(11, 9),
     gross_income DECIMAL(12,4) NOT NULL,
     rating FLOAT(2,1)
);
ALTER TABLE salesWalmart.sales
MODIFY COLUMN date DATETIME NOT NULL;

-- ----------------------------------------------------------------------
-- ------------------Feature Engineering --------------------------------
-- time of day

-- SELECT 
--       time,
--       (CASE 
--            WHEN `time` BETWEEN "00:00:00" AND "12:00:00" THEN "Morning"
--            WHEN `time` BETWEEN "12:01:00" AND "16:00:00" THEN "Afternoon"
--            ELSE "Evening"
-- 	   END
-- 	   )  AS time_of_date
-- FROM sales;

ALTER TABLE sales ADD COLUMN time_of_day VARCHAR(20);

UPDATE sales 
SET time_of_day = (
	CASE 
		WHEN `time` BETWEEN "00:00:00" AND "12:00:00" THEN "Morning"
		WHEN `time` BETWEEN "12:01:00" AND "16:00:00" THEN "Afternoon"
		ELSE "Evening"
    END
);


--  day name
-- SELECT 
--       date, 
--       DAYNAME(date)
-- FROM sales;
SET SQL_SAFE_UPDATES = 0;

ALTER TABLE sales ADD COLUMN day_name VARCHAR(20);

UPDATE sales 
SET day_name = DAYNAME(date);

-- month name

ALTER TABLE sales ADD COLUMN month_name VARCHAR(20);

UPDATE sales 
SET month_name = MONTHNAME(date);

-- ----------------------------------------------------------------------

-- ----------------------------------------------------------------------
-- -----------------------Generic----------------------------------------
-- How many unique cities does the data have?
SELECT 
      DISTINCT city
FROM sales;

-- In which city is each branch?
SELECT 
      DISTINCT city,
      branch
FROM sales;

-- ----------------------------------------------------------------------
-- -----------------------Product----------------------------------------

-- How many unique product lines does the data have?

SELECT 
      COUNT(DISTINCT product_line)
FROM sales;

-- What is the most common payment method?

SELECT 
       payment_method,
       COUNT(payment_method) AS cnt
FROM sales
GROUP BY payment_method
ORDER BY cnt DESC;

-- What is the most selling product line?

SELECT 
       product_line,
       COUNT(product_line) AS cnt
FROM sales
GROUP BY product_line
ORDER BY cnt DESC;

-- What is the total revenue by month?

SELECT 
       month_name AS month,
       SUM(total) AS total_revenue
FROM sales
GROUP BY month
ORDER BY total_revenue DESC;

-- What month had the largest COGS?
SELECT 
       month_name AS month,
       SUM(cogs) AS cogs
FROM sales
GROUP BY month
ORDER BY cogs DESC;

-- What product line had the largest revenue?
SELECT 
       product_line,
       SUM(total) AS total_revenue
FROM sales
GROUP BY product_line
ORDER BY total_revenue DESC;

-- What is the city with the largest revenue?

SELECT 
       city,
       SUM(total) AS total_revenue
FROM sales
GROUP BY city
ORDER BY total_revenue DESC;

-- What product line had the largest VAT?

SELECT 
       product_line,
       AVG(vat) AS avg_vat
FROM sales
GROUP BY product_line
ORDER BY avg_vat DESC;

-- Which branch sold more products than average product sold
SELECT 
       branch,
       SUM(quantity) 
FROM sales
GROUP BY branch
HAVING SUM(quantity) > (SELECT AVG(quantity) FROM sales);

-- What is the most common product line by gender?
SELECT 
       gender,
       product_line,
       COUNT(gender) AS total_cnt
FROM sales
GROUP BY product_line, gender
ORDER BY total_cnt DESC;

-- What is the average rating of each product line?
SELECT 
      ROUND(AVG(rating),2) AS avg_rating,
	  product_line
FROM sales
GROUP BY product_line
ORDER BY avg_rating DESC;

-- ----------------------------------------------------------------------
-- -----------------------Sales----------------------------------------

-- Number of sales made in each time of the day per weekday
SELECT 
      time_of_day,
	  COUNT(*) AS total_sales
FROM sales
WHERE day_name = "Sunday"
GROUP BY time_of_day
ORDER BY total_sales DESC;

-- Which of the customer types brings the most revenue?
SELECT 
      customer_type,
	  SUM(total) AS total_revenue
FROM sales
GROUP BY customer_type
ORDER BY total_revenue DESC;

-- Which city has the largest tax percent/ VAT (Value Added Tax)?
SELECT 
       city,
       AVG(vat) AS avg_vat
FROM sales
GROUP BY city
ORDER BY avg_vat DESC;

-- Which customer type pays the most in VAT?
SELECT 
       customer_type,
       AVG(vat) AS avg_vat
FROM sales
GROUP BY customer_type
ORDER BY avg_vat DESC;


-- ----------------------------------------------------------------------
-- -----------------------Customer----------------------------------------
-- How many unique customer types does the data have?

SELECT 
       DISTINCT customer_type
FROM sales;

-- How many unique payment methods does the data have?

SELECT 
       DISTINCT payment_method
FROM sales;

-- What is the most common customer type?
SELECT 
	customer_type,
    COUNT(*) AS cstm_cnt
FROM sales
GROUP BY customer_type
ORDER BY cstm_cnt DESC;

-- Which customer type buys the most?

SELECT 
	customer_type,
    COUNT(*) AS cstm_cnt
FROM sales
GROUP BY customer_type
ORDER BY cstm_cnt DESC;

-- What is the gender of most of the customers?

SELECT 
       gender,
       COUNT(gender) AS gender_cnt
FROM sales
GROUP BY gender
ORDER BY gender_cnt DESC;

-- What is the gender distribution per branch?

SELECT 
       gender,
       COUNT(gender) AS gender_cnt
FROM sales
WHERE branch = "C"
GROUP BY gender
ORDER BY gender_cnt DESC;

-- Which time of the day do customers give most ratings?


-- Which time of the day do customers give most ratings per branch?

SELECT 
       time_of_day,
       AVG(rating) AS avg_rating
FROM sales
WHERE branch = "C"
GROUP BY time_of_day
ORDER BY avg_rating DESC;

-- Which day fo the week has the best avg ratings?
SELECT 
       day_name,
       AVG(rating) AS avg_rating
FROM sales
WHERE day_name = "Sunday"
GROUP BY day_name
ORDER BY avg_rating DESC;


-- Which day of the week has the best average ratings per branch?

SELECT 
       day_name,
       AVG(rating) AS avg_rating
FROM sales
WHERE branch = "C"
GROUP BY day_name
ORDER BY avg_rating DESC;