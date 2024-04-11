CREATE DATABASE IF NOT EXISTS saleswalmart;
CREATE TABLE IF NOT EXISTS sales(
       invoice_id VARCHAR(50) NOT NULL PRIMARY KEY,
    branch VARCHAR(5) NOT NULL,
    city VARCHAR(30) NOT NULL,
    customer_type VARCHAR(50) NOT NULL,
    gender VARCHAR(10) NOT NULL,
    product_line VARCHAR(100) NOT NULL,
    unit_price DECIMAL (20, 10) NOT NULL,
    quantity INT NOT NULL,
    VAT FLOAT(6, 4) NOT NULL,
    total DECIMAL(12, 4) NOT NULL,
    date DATETIME NOT NULL,
    time TIME NOT NULL,
    payment_method VARCHAR(50) NOT NULL,
    cog DECIMAL(10, 2) NOT NULL,
    gross_margin_pct  FLOAT (11, 9),
    gross_income DECIMAL(12, 4),
    rating FLOAT(2, 1)
);

SELECT * FROM saleswalmart.sales;

-- ADDING THE TIME OF THE DAY


ALTER TABLE sales ADD column time_of_day VARCHAR(20);

		      SELECT
	time,
	(CASE
		WHEN `time` BETWEEN "00:00:00" AND "12:00:00" THEN "Morning"
        WHEN `time` BETWEEN "12:01:00" AND "16:00:00" THEN "Afternoon"
        ELSE "Evening"
    END) AS time_of_day
FROM sales;
 ALTER TABLE sales ADD COLUMN time_of_day VARCHAR(10);
 
 UPDATE sales
SET time_of_day = (
	CASE
		WHEN `time` BETWEEN "00:00:00" AND "12:00:00" THEN "Morning"
        WHEN `time` BETWEEN "12:01:00" AND "16:00:00" THEN "Afternoon"
        ELSE "Evening"
    END
);

SELECT time_of_day FROM sales;


 -- ADDING DAY NAME        
			
	SELECT 
          date,
               DAYNAME(date) AS day_name
     FROM sales;      
     
     ALTER TABLE sales ADD COLUMN day_name VARCHAR(10);
     UPDATE sales 
     SET day_name = DAYNAME(date);
     
     
     -- ADDING MONTH NAME WITH THE HELP OF THE DATE
     SELECT 
           date,
                MONTHNAME(date) AS month_name
	FROM sales;
    ALTER TABLE sales ADD COLUMN month_name VARCHAR(10);
    UPDATE sales
    SET month_name = MONTHNAME(date);
    
    SELECT * FROM saleswalmart.sales;



-- How many unique product line does the data have?
SELECT 
       COUNT(DISTINCT product_line) 
      FROM sales;
     
-- What is the most common method used in this data?
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
      
-- What is the total revenue by month ?
SELECT 
      month_name AS MONTH,
      SUM(total) AS total_revenue
   FROM sales
   GROUP BY MONTH
   ORDER BY total_revenue DESC;
   
   -- What month had the largest cogs?
   
   SELECT 
         month_name AS MONTH,
         SUM(cogs) AS Cogs
    FROM sales 
    GROUP BY MONTH,
    ORDER BY Cogs DESC;
    
-- What product line had the largest revenue?

SELECT 
      product_line,
      SUM(total) AS total_revenue
      FROM sales
      GROUP BY product_line
      ORDER BY total_revenue DESC;
      
-- What is the city with the largest revenue?

SELECT
      branch,
      city,
      SUM(total) AS total_revenue
      FROM sales 
      GROUP BY city , branch
      ORDER BY total_revenue DESC;
      
   -- What product had the largest VAT ?
   
   SELECT 
        product_line,
        AVG(VAT) AS avg_tax
        FROM sales
        GROUP BY product_line
        ORDER BY avg_tax DESC;
        
   SELECT * FROM saleswalmart.sales;
   -- Which brand sales the more product than the average sale product?
   
   SELECT 
         branch,
         SUM(quantity) AS qty
         FROM sales
         GROUP BY branch 
         HAVING SUM(quantity) > (SELECT AVG(quantity) FROM sales);

-- What is the most common product line by the gender?

SELECT 
      gender,
      product_line,
      COUNT(gender) AS total_cnt
      FROM sales
      GROUP BY gender, product_line
      ORDER BY total_cnt DESC;
      
      -- What is the average rating of the each product line?
      
   SELECT
          product_line,
		 ROUND(AVG(rating), 2) AS avg_rating
         FROM sales
         GROUP BY product_line
         ORDER BY avg_rating DESC;
      
      -- Questions regarding sales
      
      --  Numbers of sales made each time of the day per weekday
      SELECT
            time_of_day,
            COUNT(*) AS total_sales
            FROM sales
            WHERE day_name = "Sunday"
            GROUP BY time_of_day
            ORDER BY total_sales DESC;
            
-- Which of the customer type brings the most revenue?

SELECT 
     customer_type,
     SUM(total) AS total_rev
     FROM sales
     GROUP BY customer_type
     ORDER BY total_rev;
     
  -- Which city has the largest tax percent/VAT?
  SELECT
        city,
        SUM(VAT) AS total
        FROM sales
        GROUP BY city
        ORDER BY total DESC;
        
   -- Which customer type pays the most in VAT?
   
   SELECT 
          customer_type,
           ROUND(AVG(VAT), 2) AS total
          FROM sales
          GROUP BY customer_type
          ORDER BY total DESC;
          
	-- CUSTOMER RELATED QUESTIONS--
     
     -- How many unique customer types are there in the data?
     
     SELECT
           DISTINCT customer_type
           FROM sales;
	-- As same as above we can find unique types in the data using DISTINCT
    
    -- Which customer buys the most?
     SELECT 
           customer_type,
           COUNT(*) AS cst_cnt
           FROM sales
           GROUP BY customer_type;
     -- what is the gender of the most of the customers?
     SELECT
           gender,
           COUNT(*) AS cnt_gen
           FROM sales
           GROUP BY gender
           ORDER BY cnt_gen DESC;
	
    -- What is the gender distribution  per branch?
    
SELECT
      gender,
      COUNT(*) AS cnt_gen
      FROM sales
      WHERE branch =  "B" 
      GROUP BY gender
      ORDER BY cnt_gen DESC;
            
	-- Which time of the day the customer do the most ratings?
    SELECT 
          time_of_day,
          AVG(rating) AS avg_rating
          FROM sales
          GROUP BY time_of_day
          ORDER BY avg_rating DESC;
            
            
            
      


----------------------------------------------------------------------------------------------------------------------------------------------------------

