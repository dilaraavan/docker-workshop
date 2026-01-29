# Module 1 Homework – Docker & SQL  
Data Engineering Zoomcamp by DataTalksClub

This repository contains my solutions for **Module 1 (Docker & SQL)** of the Data Engineering Zoomcamp.  
The focus of this module is understanding Docker basics, Docker Compose networking, and querying data loaded into PostgreSQL.

---

## Question 1 – Understanding Docker Images

**Question:**  
What is the version of `pip` available in the `python:3.13` Docker image?

**Answer:**  
`pip 25.3`

This was verified by running the container with a bash entrypoint and checking the pip version inside the container.

---

## Question 2 – Docker Networking & Docker Compose

**Question:**  
What hostname and port should pgAdmin use to connect to PostgreSQL when both services are defined in the same `docker-compose.yaml`?

**Answer:**  
`db:5432`

Since both services run in the same Docker Compose network, pgAdmin connects to PostgreSQL using:
- the **service name** (`db`) as hostname
- the **internal container port** (`5432`)

---

## Data Preparation (Questions 3–6)

The following datasets were used:

- Green Taxi Trips – November 2025 (Parquet)
- Taxi Zone Lookup Table (CSV)

The data was loaded into PostgreSQL and queried using SQL.  
All SQL queries are stored separately in the `sql/` directory.

---

## Question 3 – Counting Short Trips

**Task:**  
Count the number of trips in November 2025 with a `trip_distance` less than or equal to 1 mile.

📄 SQL file:  
`sql/q3_short_trips.sql`

---

## Question 4 – Longest Trip Day

**Task:**  
Identify the pickup day with the longest single trip distance in November 2025, excluding trips longer than 100 miles.

📄 SQL file:  
`sql/q4_longest_trip.sql`

---

## Question 5 – Biggest Pickup Zone

**Task:**  
Find the pickup zone with the highest total `total_amount` on **November 18, 2025**.

📄 SQL file:  
`sql/q5_biggest_pickup_zone.sql`

---

## Question 6 – Largest Tip

**Task:**  
For passengers picked up in **East Harlem North** during November 2025, determine which drop-off zone received the **largest total tip amount**.

📄 SQL file:  
`sql/q6_largest_tip.sql`

> Note: This query aggregates tips by drop-off zone to identify where the highest total tip was recorded.

---

## Question 7 – Terraform Workflow

**Correct workflow:**

```text
terraform init
terraform apply -auto-approve
terraform destroy
