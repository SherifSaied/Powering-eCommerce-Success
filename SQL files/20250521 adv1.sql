--Compute the 30-day customer retention rate after their first purchase

WITH customerfirstP AS (
    SELECT customer_id, MIN(order_date) AS Firstorder
    FROM orders
    GROUP BY customer_id
),
Next30Days AS (
    SELECT o.customer_id
    FROM orders o
    JOIN customerfirstP cfp ON  cfp.customer_id  = o.customer_id
    WHERE o.order_date > cfp.Firstorder
      AND o.order_date <= DATEADD(DAY, 30, cfp.Firstorder)
)
SELECT 
    CAST(COUNT(DISTINCT Next30Days.customer_id) * 100.0 / 
         (SELECT COUNT(*) FROM customerfirstP) AS DECIMAL(5,2)) AS RetentionRate
FROM Next30Days;