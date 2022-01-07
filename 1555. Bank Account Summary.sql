with base as (
SELECT trans_id, paid_to user_id, 'paid_to' as type,  amount FROM Transactions
UNION
SELECT trans_id, paid_by, 'paid_by' as type, amount FROM Transactions)

SELECT user_id,
       user_name,
       credit + IFNULL(SUM(IF(type='paid_to', amount, -amount)),0) as credit,
       CASE WHEN credit + IFNULL(SUM(IF(type='paid_to', amount, -amount)),0)<0 THEN 'Yes'
            ELSE 'No'
        END as 'credit_limit_breached' 
    FROM base 
    RIGHT JOIN Users USING (user_id)
    GROUP BY user_id;