# Write your MySQL query statement below
SELECT i.invoice_id, 
       c.customer_name,
       i.price,
       IFNULL(COUNT(distinct contact_email),0) as contacts_cnt,
       IFNULL(T.trusted_contacts_cnt,0) AS trusted_contacts_cnt
    FROM Invoices i 
    LEFT JOIN Customers c ON c.customer_id = i.user_id 
    LEFT JOIN Contacts ct ON ct.user_id = c.customer_id 
    LEFT JOIN (SELECT c.customer_id,
               COUNT(distinct contact_email)  as trusted_contacts_cnt
            FROM Customers c 
            LEFT JOIN Contacts ct ON ct.user_id = c.customer_id
            WHERE ct.contact_email in (SELECT email FROM Customers)
            GROUP BY c.customer_id) AS T 
            ON T.customer_id = i.user_id
    GROUP BY i.invoice_id, c.customer_name
    ORDER BY i.invoice_id