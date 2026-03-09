-- Creating a Trips Table
CREATE TABLE cycle_proj.trips (
trip_id VARCHAR(30),
start_time TIMESTAMP,
stop_time TIMESTAMP,	
bike_id VARCHAR(30),
trip_duration REAL,
from_station_id TEXT,
from_station_name TEXT,
to_station_id TEXT,
to_station_name TEXT,
usertype TEXT,
gender VARCHAR(7),
birth_year REAL,
unique_trip_id TEXT  PRIMARY KEY NOT NULL,
trip_duration_min REAL,
trip_year REAL,
trip_month VARCHAR(4),
trip_day VARCHAR(4),
age REAL,
ride_type VARCHAR(25));
-- The file was too big to import so I had to use psql command to import it in 

-- Creating a table for metadata
CREATE TABLE cycle_proj.metadata(
station_pk INT PRIMARY KEY,
station_id TEXT,
station_name TEXT,
station_lat DOUBLE PRECISION,
station_long DOUBLE PRECISION,
dp_capacity INT,
landmark TEXT,
station_opening_date DATE,
city_loc TEXT
)
-- Importing data into metadata table 
COPY cycle_proj.metadata
FROM 'C:/Users/axere/OneDrive/Desktop/CycleDA/Cycle data 2013 - 2022/Cycle Data/meta_data/merged_meta_data.csv'
DELIMITER ','
CSV HEADER;