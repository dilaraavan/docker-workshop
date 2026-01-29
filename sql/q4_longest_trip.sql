-- Q4: Pick-up day with the longest trip distance
-- Only trips with trip_distance < 100 miles are considered (November 2025)
-- Based on pick-up time
SELECT
  DATE(lpep_pickup_datetime) AS pickup_day,
  MAX(trip_distance) AS max_trip_distance
FROM green_taxi
WHERE
  lpep_pickup_datetime >= '2025-11-01'
  AND lpep_pickup_datetime < '2025-12-01'
  AND trip_distance < 100
GROUP BY pickup_day
ORDER BY max_trip_distance DESC
LIMIT 1;
