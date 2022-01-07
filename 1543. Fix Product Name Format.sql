SELECT DISTINCT LOWER(replace(product_name,' ','')) product_name, 
       DATE_FORMAT(sale_date, '%Y-%m') sale_date,
       COUNT(sale_id) total
    FROM Sales
    GROUP BY LOWER(replace(product_name,' ','')), DATE_FORMAT(sale_date, '%Y-%m')
    ORDER BY product_name, sale_date;