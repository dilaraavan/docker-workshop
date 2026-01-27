# docker-workshop
# Module 1 Homework: Docker & SQL

## Question 1
Pip version in the python:3.13 Docker image: 25.3

## Question 2
PgAdmin host and port to connect to PostgreSQL: db:5432

## Question 3
Number of trips with trip_distance <= 1 mile: 8,007

## Question 4
Pickup day with the longest trip distance: 2025-11-20

## Question 5
Pickup zone with the largest total_amount on 2025-11-18: East Harlem North

## Question 6
Dropoff zone with the largest tip for East Harlem North pickup: Upper East Side North

## Question 7
Terraform workflow: terraform init, terraform apply -auto-approve, terraform destroy

## SQL & Terminal Commands Used
```sql
-- Load zones table from CSV
\copy zones("LocationID","Borough","Zone","service_zone") FROM '/taxi_zone_lookup.csv' WITH (FORMAT csv, HEADER true);

-- SQL query for Question 3: Counting short trips (trip_distance <= 1 mile)
-- This query counts how many trips in November 2025 were shorter than or equal to 1 mile.
SELECT COUNT(*)
FROM green_tripdata
WHERE
  lpep_pickup_datetime >= '2025-11-01'
  AND lpep_pickup_datetime < '2025-12-01'
  AND trip_distance <= 1;

-- SQL query for Question 4: Longest trip for each day (trip_distance < 100 miles)
-- This query finds the day with the single longest trip in November 2025, ignoring trips over 100 miles to remove errors.
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

-- SQL query for Question 5: Biggest pickup zone (total_amount)
-- This query finds which pickup zone in November 18, 2025 generated the highest total amount of trips.
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

-- SQL query for Question 6: Largest tip from East Harlem North
-- This query finds which dropoff zone received the highest total tip from passengers picked up in 'East Harlem North' in November 2025.
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
