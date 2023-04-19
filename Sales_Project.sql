SELECT sales.transactions .*, sales.date.* 
FROM sales.transactions 
INNER JOIN sales.date 
ON sales.transactions.order_date = sales.date.date


-- DATA EXPLORATION

SELECT DISTINCT YEAR(order_date) FROM transactions
-- this data is from 2017 to 2020


-- looking at transaction for 2019
SELECT *,YEAR(order_date) FROM transactions WHERE YEAR(order_date) = 2019

-- looking at total sales by markets
SELECT market_code,SUM(sales_amount) FROM transactions GROUP BY market_code 
-- 'Mark097 and 'Mark999' have negative values, so we need to remove this data as it is incorrect


SELECT * FROM markets
-- we can see from here that New York and Paris have null values for the zones ('Mark097 and 'Mark999')
-- this is because these two are from different countries than all other market names from INDIA


SELECT COUNT(*) FROM transactions
-- 150,283 rows

SELECT COUNT(*) FROM transactions WHERE sales_amount <= 0
-- 1,611 rows



-- DATA CLEANING

-- Now we will remove these rows 
DELETE 
FROM transactions
WHERE sales_amount <= 0 



SELECT COUNT(*) FROM transactions
-- now we have 148,672 rows




SELECT * FROM transactions
-- we can see that we have some some inconsistencies in the currency column, some have 'USD' and some have 'INR'



SELECT DISTINCT currency ,LENGTH(currency) FROM transactions
-- there appear to be two values for each currency, so we have an unwanted space
-- we need to convert 'USD' to 'INR' and then remove the extra space from 'INR'


-- changing the sales amounts first
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
SELECT DISTINCT currency FROM transactions
-- we have now only 'INR'







