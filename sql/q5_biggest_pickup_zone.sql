-- Q5: Pickup zone with the highest total amount on November 18, 2025
SELECT
  z."Zone" AS pickup_zone,
  SUM(g.total_amount) AS total_amount_sum
FROM green_taxi g
JOIN zones z
  ON g."PULocationID" = z."LocationID"
WHERE DATE(g.lpep_pickup_datetime) = '2025-11-18'
GROUP BY pickup_zone
ORDER BY total_amount_sum DESC
LIMIT 1;
