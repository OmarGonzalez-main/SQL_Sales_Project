SELECT 
	transactions .*, date.* 
FROM 
	transactions 
INNER JOIN 
	date 
ON 
	transactions.order_date = date.date


-- DATA EXPLORATION

SELECT 
	DISTINCT YEAR(order_date) 
FROM 
	transactions
-- this data is from 2017 to 2020


SELECT * 
FROM 
	markets 
-- we can see from here that New York and Paris have null values for the zones ('Mark097 and 'Mark999')
-- this is because these two are from different countries than all other market names from INDIA



SELECT * 
FROM 
	transactions 


-- looking at transaction for 2019
SELECT *,
	YEAR(order_date) 
FROM 
	transactions 
WHERE 
	YEAR(order_date) = 2019


-- looking at total sales by markets
SELECT 
	market_code,SUM(sales_amount) 
FROM 
	transactions 
GROUP BY 
	market_code 
-- 'Mark097' and 'Mark999' have no revenue information, so we can remove them from the markets table


SELECT 
	COUNT(*) 
FROM 
	transactions
-- 148,395 rows



-- DATA CLEANING


-- we will also remove the cities that are not in India as they do not have any transactions anyways
DELETE 
FROM markets
WHERE markets_code IN('Mark097', 'Mark999')



-- we can see that we have some some inconsistencies in the currency column, some have 'USD' and some have 'INR'

SELECT 
	DISTINCT currency ,LENGTH(currency) 
FROM 
	transactions
-- there appear to be two values for each currency, so we have an unwanted space
-- we need to convert 'USD' to 'INR' and then remove the extra space from 'INR'


-- changing the sales amounts first
-- in real life, we would not do proceed with this course of action since the conversion rate changes especially year by year
-- but for simplicity reason we will proceed in this way
UPDATE transactions
SET sales_amount = 
	CASE WHEN currency = 'USD' THEN sales_amount*75
    WHEN currency = 'USD\r' THEN sales_amount*75
    ELSE sales_amount
    END


-- now changing the currency
UPDATE transactions
SET currency = 
	CASE WHEN currency = 'USD' THEN 'INR'
    WHEN currency = 'USD\r' THEN 'INR'
    WHEN currency = 'INR\r' THEN 'INR'
    ELSE currency
    END
    
    
-- checking to see if we have what we want now
SELECT 
	DISTINCT currency 
FROM 
	transactions
-- we have now only 'INR'




