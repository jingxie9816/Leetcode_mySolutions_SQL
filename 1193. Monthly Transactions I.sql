-- Solution1: CASE WHEN
SELECT date_format(trans_date, '%Y-%m') as `month`, 
       country, 
       COUNT(id) as trans_count,
       SUM(CASE WHEN state='approved' THEN 1 ELSE 0 END) approved_count,
       SUM(amount) AS trans_total_amount,
       SUM(CASE WHEN state='approved' THEN amount ELSE 0 END) approved_total_amount
FROM Transactions 
GROUP BY date_format(trans_date, '%Y-%m'), country;

-- Solution2: LEFT JOIN
SELECT T.`month`, T.country, trans_count, IFNULL(approved_count,0) approved_count, trans_total_amount, IFNULL(approved_total_amount,0) approved_total_amount
FROM 
(
SELECT date_format(trans_date, '%Y-%m') as `month`, 
       country, 
       COUNT(id) as trans_count,
       SUM(amount) AS trans_total_amount
FROM Transactions 
GROUP BY date_format(trans_date, '%Y-%m'), country) AS T
LEFT JOIN (
SELECT date_format(trans_date, '%Y-%m') as `month`, 
       country, 
       COUNT(id) as approved_count,
       SUM(amount) AS approved_total_amount
FROM Transactions 
WHERE state='approved'
GROUP BY date_format(trans_date, '%Y-%m'), country
) AS S
USING(`month`, country);