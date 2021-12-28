SELECT ad_id, 
    CAST(CASE WHEN ttl_click + ttl_view = 0 THEN 0
         ELSE ttl_click/(ttl_click+ttl_view)*100
         END
         AS DECIMAL(10,2)) AS ctr
FROM(
SELECT ad_id,
       SUM(action = 'Clicked') as ttl_click,
       SUM(action = 'Viewed') as ttl_view
    FROM Ads 
    GROUP BY ad_id) AS T 
ORDER BY ctr desc, ad_id 