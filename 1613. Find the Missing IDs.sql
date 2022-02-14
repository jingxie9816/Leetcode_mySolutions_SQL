# 1. find out the MAX(customer_id)
# 2. create a consecutive number list using RECURSIVE 

WITH RECURSIVE a as 
(
    SELECT 1 AS num
    UNION ALL
    SELECT num+1 from a 
    WHERE num < (SELECT MAX(customer_id) from Customers)
)
SELECT num as ids
    FROM a  
    WHERE num NOT IN (SELECT customer_id FROM Customers)
    ORDER BY num;