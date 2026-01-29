-- Q3: Counting short trips (<= 1 mile) in November 2025
SELECT COUNT(*)
FROM green_taxi
WHERE
  lpep_pickup_datetime >= '2025-11-01'
  AND lpep_pickup_datetime < '2025-12-01'
  AND trip_distance <= 1;
