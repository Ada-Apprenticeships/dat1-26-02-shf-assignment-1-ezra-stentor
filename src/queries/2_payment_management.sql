.open fittrackpro.db
.mode box

-- 2.1 
--ID needs to be auto incerment!!
--INSERT INTO payments VALUES (8,11, 50, CURRENT_TIMESTAMP, 'Credit Card', 'Monthly membership fee');
-- 2.2 

SELECT
    strftime('%m',payment_date) as month,
    sum(amount) as total_revenue
FROM payments
GROUP BY 
    strftime('%m',payment_date);

-- 2.3 

-- Task: Find all day pass purchases
-- payment_id | amount | payment_date | payment_method |

SELECT 
    payment_id, 
    amount, 
    payment_date,
    payment_method
FROM payments
#normalising data to handle variations  
WHERE lower(payment_type) == 'day pass';

