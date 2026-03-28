-- Using: Postgres
-------------------

-- Here is my second attempt 

WITH App_Metrics_Summary AS (
  SELECT 
    app_id, 
    SUM(CASE WHEN event_type = 'click' THEN 1 ELSE 0 END) AS no_of_clicks,
    SUM(CASE WHEN event_type = 'impression' THEN 1 ELSE 0 END) AS no_of_impressions
  FROM events
  WHERE timestamp >= '2022-01-01' AND timestamp < '2023-01-01'
  GROUP BY app_id
)

SELECT 
  app_id, 
  ROUND(100.0 * no_of_clicks / NULLIF(no_of_impressions, 0), 2) AS ctr
FROM App_Metrics_Summary;

-----------------------------------------------

-- Here is my First attempt
/*

WITH App_Metrics_Summary AS (
  SELECT app_id, 
        SUM( 
            CASE WHEN event_type = 'click' THEN 1 ELSE 0 END
            ) AS no_of_clicks,
        SUM( 
            CASE WHEN event_type = 'impression' THEN 1 ELSE 0 END
            ) AS no_of_impressions
  FROM events
  WHERE EXTRACT(YEAR FROM timestamp) = 2022
  -- If there is an index on the timestamp ---> Then it's better to use it in the where condition
    -- WHERE timestamp >= '2022-01-01' AND timestamp < '2023-01-01'
  GROUP BY app_id
)

SELECT app_id, ROUND(100.0 * no_of_clicks / no_of_impressions, 2) AS ctr
FROM App_Metrics_Summary

*/
-- There is a small problem in my solution:
  -- If an app has 0 impressions, 100 / 0 will crash your entire pipeline,
    -- So we will use NULLIF
    -- NULLIF turns a 0 into a NULL, which makes the result NULL instead of an error.
