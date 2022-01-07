SELECT product_name, product_id, order_id, order_date
FROM (
SELECT p.product_name, o.product_id, o.order_id, o.order_date,
       RANK() OVER (PARTITION BY o.product_id ORDER BY o.order_date DESC) rk 
    FROM Orders o 
    JOIN Products p USING (product_id)
) AS T 
WHERE rk = 1
ORDER BY product_name, product_id, order_id;