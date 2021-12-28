SELECT ad_id, 
    CAST(CASE WHEN ttl_click + ttl_view = 0 THEN 0
         ELSE ttl_click/(ttl_click+ttl_view)*100
         END
         AS DECIMAL(10,2)) AS ctr
FROM(
SELECT ad_id,
       SUM(CASE WHEN action = 'Clicked' THEN 1 ELSE 0 END) as ttl_click,
       SUM(CASE WHEN action = 'Viewed' THEN 1 ELSE 0 END) as ttl_view
    FROM Ads 
    GROUP BY ad_id) AS T 
ORDER BY ctr desc, ad_id 
