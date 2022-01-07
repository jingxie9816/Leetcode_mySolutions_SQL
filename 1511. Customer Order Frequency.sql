SELECT * FROM(
SELECT o.customer_id, c.name
    FROM Orders o 
    JOIN Product p USING (product_id)
    JOIN Customers c USING (customer_id)
    WHERE DATE_FORMAT(o.order_date,'%Y-%m') ='2020-06' OR DATE_FORMAT(o.order_date,'%Y-%m')='2020-07'
    GROUP BY o.customer_id, DATE_FORMAT(o.order_date,'%Y-%m')
    HAVING SUM(o.quantity*p.price) >= 100) AS T
GROUP BY customer_id
HAVING COUNT(customer_id) = 2;