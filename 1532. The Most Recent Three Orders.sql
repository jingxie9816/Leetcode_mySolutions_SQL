SELECT customer_name, customer_id, order_id, order_date
FROM(
SELECT c.name customer_name, o.customer_id, o.order_id, o.order_date,
       RANK() OVER (PARTITION BY o.customer_id ORDER BY order_date DESC) AS rk 
    FROM Orders o 
    JOIN Customers c USING (customer_id)) AS T
WHERE rk <= 3
ORDER BY customer_name, customer_id, order_date desc;