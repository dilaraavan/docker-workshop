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

-- SQL query for Question 5
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

-- SQL query for Question 6
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
