.open fittrackpro.db
.mode column

-- 2.1 
INSERT INTO
    payments
VALUES (
    NULL,
    11,
    50,
    CURRENT_TIMESTAMP,
    'Credit Card',
    'Monthly membership fee'
);

-- 2.2 
SELECT
    strftime('%m', payment_date) as month,
    sum(amount) as total_revenue
FROM payments
WHERE payment_date BETWEEN '2024-11-01' AND '2025-02-28'
GROUP BY 
    strftime('%m',payment_date);

-- 2.3 

SELECT 
    payment_id, 
    amount, 
    payment_date,
    payment_method
FROM payments
-- normalising data to handle variations  
WHERE lower(payment_type) = 'day pass';

