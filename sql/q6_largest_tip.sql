-- Q6: Dropoff zone with the highest total tip
-- from passengers picked up in East Harlem North (November 2025)
SELECT
  z."Zone" AS dropoff_zone,
  SUM(g.tip_amount) AS total_tip
FROM green_taxi g
JOIN zones z
  ON g."DOLocationID" = z."LocationID"
WHERE z."Zone" IS NOT NULL
  AND DATE(g.lpep_pickup_datetime) BETWEEN '2025-11-01' AND '2025-12-01'
  AND g."PULocationID" = (
    SELECT "LocationID" 
    FROM zones 
    WHERE "Zone" = 'East Harlem North'
    LIMIT 1
  )
GROUP BY dropoff_zone
ORDER BY total_tip DESC
LIMIT 1;
