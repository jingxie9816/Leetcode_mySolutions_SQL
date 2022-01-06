WITH base as (
SELECT DOW, item_category as Category, IFNULL(SUM(quantity),0) as qty 
FROM(
SELECT o.order_id,
       o.item_id, 
       o.quantity,
       i.item_category,
       DATE_FORMAT(order_date, '%W') as DOW 
    FROM Orders o  
    RIGHT JOIN Items i using (item_id)
) AS T 
GROUP BY DOW, item_category)

SELECT Category,
    SUM(CASE WHEN DOW='Monday' THEN qty ELSE 0 END) AS 'Monday',
    SUM(CASE WHEN DOW='Tuesday' THEN qty ELSE 0 END) AS 'Tuesday',
    SUM(CASE WHEN DOW='Wednesday' THEN qty ELSE 0 END) AS 'Wednesday',
    SUM(CASE WHEN DOW='Thursday' THEN qty ELSE 0 END) AS 'Thursday',
    SUM(CASE WHEN DOW='Friday' THEN qty ELSE 0 END) AS 'Friday',
    SUM(CASE WHEN DOW='Saturday' THEN qty ELSE 0 END) AS 'Saturday',
    SUM(CASE WHEN DOW='Sunday' THEN qty ELSE 0 END) AS 'Sunday'
    FROM base
    GROUP BY Category
    ORDER BY Category;