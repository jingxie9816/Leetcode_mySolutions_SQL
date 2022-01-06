SELECT * FROM (
SELECT a.id as p1, b.id as p2, 
       abs(a.x_value-b.x_value) * abs(a.y_value-b.y_value) as area
    FROM Points a 
    JOIN Points b ON a.x_value <> b.x_value AND a.y_value <> b.y_value 
ORDER BY area desc, p1 asc, p2 asc) as T
WHERE p1<p2;