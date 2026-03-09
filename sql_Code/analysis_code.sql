-- ANALYSIS
SELECT * from cycle_proj.trips limit 10;

-- Q1 = Top 10 high demand area station
CREATE VIEW cycle_proj.highest_demanded_station AS
SELECT 
	from_station_id,
	COUNT(*) AS trip_started
FROM
	cycle_proj.trips
WHERE
	from_station_id IS NOT NULL
GROUP BY
	from_station_id
ORDER BY
	trip_started DESC
LIMIT 10;

-- Q2 = Most common route
CREATE VIEW cycle_proj.common_route AS
SELECT 
    from_station_id,
    to_station_id,
    COUNT(*) AS trip_count
FROM 
	cycle_proj.trips
WHERE
	from_station_id IS NOT NULL
	AND to_station_id IS NOT NULL
GROUP BY 
	from_station_id, to_station_id
ORDER BY 
	trip_count DESC
LIMIT 10;

-- Q3 = AVG, MAX, MIN user trip duration
CREATE VIEW cycle_proj.trip_durations AS
SELECT 
	AVG(trip_duration_min) AS avg_trip_duration,
	MAX(trip_duration_min) AS max_trip_duration,
	MIN(trip_duration_min) AS min_trip_duration
FROM cycle_proj.trips
WHERE
	trip_duration_min > 1;

-- Q4 = Which day is the most busy
CREATE VIEW cycle_proj.busiest_day AS
SELECT 
    trip_day,
    COUNT(*) AS trip_count,
    CASE 
        WHEN trip_day = 'Mon' THEN 1
        WHEN trip_day = 'Tue' THEN 2
        WHEN trip_day = 'Wed' THEN 3
        WHEN trip_day = 'Thu' THEN 4
        WHEN trip_day = 'Fri' THEN 5
        WHEN trip_day = 'Sat' THEN 6
        WHEN trip_day = 'Sun' THEN 7
    END AS day_order
FROM cycle_proj.trips
GROUP BY trip_day
ORDER BY day_order;

-- Q5 = Which month is the busiest
CREATE VIEW cycle_proj.busiest_month AS
SELECT
	trip_month,
	COUNT(*) AS trip_count,
	CASE
	    WHEN trip_month = 'Jan' THEN 1
        WHEN trip_month = 'Feb' THEN 2
        WHEN trip_month = 'Mar' THEN 3
        WHEN trip_month = 'Apr' THEN 4
        WHEN trip_month = 'May' THEN 5
        WHEN trip_month = 'Jun' THEN 6
        WHEN trip_month = 'Jul' THEN 7
		WHEN trip_month = 'Aug' THEN 8
		WHEN trip_month = 'Sep' THEN 9
		WHEN trip_month = 'Oct' THEN 10
		WHEN trip_month = 'Nov' THEN 11
		WHEN trip_month = 'Dec' THEN 12
	END AS month_order
FROM cycle_proj.trips
GROUP BY trip_month
ORDER BY month_order;

-- Q6 = Which usertype uses the service most
CREATE VIEW cycle_proj.users_service_used AS
SELECT
	usertype,
	COUNT(*) AS trip_count
FROM cycle_proj.trips
GROUP BY usertype
ORDER BY trip_count DESC;

-- Q7 = Which usertype rides the most on avg
CREATE VIEW cycle_proj.usertype_avg_ride AS
SELECT
	usertype,
	 AVG(trip_duration_min) AS avg_trip_duration
FROM cycle_proj.trips
GROUP BY usertype;

-- Q8 = Which station has most usage
CREATE VIEW cycle_proj.highest_usage AS
SELECT
    m.station_name,
    m.dp_capacity,
    COUNT(t.trip_id) AS total_trips
FROM cycle_proj.metadata m
JOIN cycle_proj.trips t
ON m.station_id = t.from_station_id
GROUP BY m.station_name, m.dp_capacity
ORDER BY total_trips DESC;

-- Q9 = Longest trips
CREATE VIEW cycle_proj.longest_trips AS
SELECT 
	unique_trip_id,
	start_time,
	stop_time,
	usertype,
	trip_duration_min
FROM cycle_proj.trips
ORDER BY trip_duration_min DESC
LIMIT 10;

-- Q10 = Shortest trips
CREATE VIEW cycle_proj.shortest_trips AS
SELECT 
	unique_trip_id,
	start_time,
	stop_time,
	usertype,
	trip_duration_min
FROM cycle_proj.trips
ORDER BY trip_duration_min 
LIMIT 10;

-- Q11 = Growth by year
CREATE VIEW cycle_proj.yearly_growth AS
SELECT
    trip_year,
    COUNT(*) AS trips
FROM cycle_proj.trips
GROUP BY trip_year;

-- Q12 = WHich station is the most popular
CREATE VIEW cycle_proj.popular_stations AS
SELECT
    m.station_name,
    m.station_lat,
    m.station_long,
    COUNT(t.trip_id) AS trips
FROM cycle_proj.metadata m
LEFT JOIN cycle_proj.trips t
ON m.station_id = t.from_station_id
GROUP BY m.station_name, m.station_lat, m.station_long
ORDER BY trips DESC;