SELECT s.product_id, p.product_name,
       LEFT(period_start,4) AS report_year,
       (DATEDIFF(period_end, period_start) +1) * average_daily_sales AS total_amount
    FROM Sales s 
    JOIN Product p using (product_id)
    WHERE YEAR(period_start) = YEAR(period_end) 
UNION
SELECT s.product_id, p.product_name,
       LEFT(period_start,4) AS report_year,
       (DATEDIFF(str_to_date(CONCAT(YEAR(period_start), '-','12-31'),'%Y-%m-%d'), period_start)+1) * average_daily_sales AS total_amount
    FROM Sales s 
    JOIN Product p using (product_id)
    WHERE YEAR(period_start) < YEAR(period_end) 
UNION
SELECT s.product_id, p.product_name,
       LEFT(period_end,4) AS report_year,
       (DATEDIFF(period_end, str_to_date(CONCAT(YEAR(period_end), '-','01-01'),'%Y-%m-%d'))+1) * average_daily_sales AS total_amount
    FROM Sales s 
    JOIN Product p using (product_id)
    WHERE YEAR(period_start) < YEAR(period_end)
UNION
SELECT s.product_id, p.product_name,
       LEFT(period_end,4)-1 AS report_year,
       365 * average_daily_sales AS total_amount
    FROM Sales s 
    JOIN Product p using (product_id)
    WHERE YEAR(period_start) +1 < YEAR(period_end)
ORDER BY product_id, report_year