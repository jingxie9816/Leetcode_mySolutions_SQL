with tb1 as (
SELECT tiv_2015,
       count(pid) as ct1
    FROM Insurance
    GROUP BY tiv_2015),

tb2 as (
SELECT lat,
       lon,
       count(pid) as ct2 
    FROM Insurance
    GROUP BY lat,lon)

SELECT ROUND(SUM(tiv_2016),2) tiv_2016
    FROM Insurance
    JOIN tb1 USING(tiv_2015)
    JOIN tb2 USING (lat,lon)
    WHERE ct1 > 1 AND ct2=1