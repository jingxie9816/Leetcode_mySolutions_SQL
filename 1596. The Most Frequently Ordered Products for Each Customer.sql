-- Approach 1: Window Function
# 1. GROUP BY customer_id, Product_id
# 2. RANK() partition by customer using COUNT(*)
# 3. Rank = 1

SELECT customer_id, product_id, product_name 
FROM(
SELECT o.customer_id, o.product_id, product_name, 
       RANK() OVER (PARTITION BY customer_id ORDER BY count(*) DESC) as rk
    FROM Orders o 
    JOIN Products p using (product_id)
    GROUP BY 1,2) AS T
    WHERE rk =1
    ORDER BY 1, 2;

-- Approach 2: Interactive table without window function
WITH most_frequency AS(
SELECT customer_id, MAX(ct) as max_ct 
FROM(
SELECT o.customer_id, o.product_id, count(*) as ct 
    FROM Orders o 
    GROUP BY 1,2) as T
GROUP BY customer_id)

SELECT o.customer_id, o.product_id, p.product_name
    FROM Orders o 
    JOIN Products p USING (product_id)
    GROUP BY 1,2
    HAVING COUNT(*) = (SELECT max_ct FROM most_frequency mf
                        WHERE mf.customer_id = o.customer_id)
    ORDER BY 1, 2;
    