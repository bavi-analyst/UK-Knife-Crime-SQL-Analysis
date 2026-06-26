-- Creating the database 
CREATE DATABASE uk_crime;
USE uk_crime;

-- Crearing empty table to match with the data	
CREATE TABLE crime(
crime_id VARCHAR(100),
month VARCHAR(10),
reported_by VARCHAR(100),
fals_within VARCHAR(100),
longitude VARCHAR(20),
latitude VARCHAR(20),
location VARCHAR(200),
lsoa_code VARCHAR(20),
lscoa_name VARCHAR(100),
crime_type VARCHAR(200),
last_outcome VARCHAR(200),
context VARCHAR(200)
);

-- Loading Data Infile 
LOAD DATA INFILE 'C:\ProgramData\MySQL\MySQL Server 8.0\Uploads\crimes_combined.csv'
INTO TABLE crime
FIELDS TERMINATED BY','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(crime_id, month ,reported_by,falls_within,longitude,latitude,location,lscoa_code,lscoa_name,crime_type,last_otcome,context);



-- To Verify the load is worked 
SELECT COUNT(*) FROM crime;

-- verify the data before start the analyse
SELECT *
FROM crime
LIMIT 10;

-- Finding the exact crime type name 
SELECT DISTINCT crime_type FROM crime;

-- finding the exact crime by using filter option condition(WHERE)
SELECT * FROM crime 
WHERE crime_type='Possession of weapons' 
LIMIT 10;

-- Sorting results monthwise using ORDER BY
SELECT falls_within,crime_type,month FROM crime
WHERE crime_type='Possession of weapons'
ORDER BY month ASC
LIMIT 10;

-- Combining Multiple Conditons using AND/OR
 SELECT falls_within,crime_type,last_outcome FROM crime
 WHERE crime_type='Possession of weapons'	
  AND falls_within='Metropolitan Police Service'
  LIMIT 10;
  
  -- Lets group together which shares the  same values in a row in a coloumn (GROUP BY)
  SELECT falls_within AS force_name,
  COUNT(*) AS knife_crime_count	
  FROM crime 
  WHERE crime_type='Possession of weapons'
GROUP BY falls_within 	
ORDER BY knife_crime_count DESC
LIMIT 10;  

-- Grouping by two coloumns at once
 SELECT falls_within  AS force_name,
 last_outcome AS outcome,
 COUNT(*) AS crime_count
 FROM crime
 WHERE crime_type='Possession of weapons'
 GROUP BY falls_within,last_outcome
 ORDER BY force_name,crime_count DESC;
 
 -- Filtering After Grouping with HAVING 
 SELECT falls_within AS force_name,
 COUNT(*) AS knife_crime_count
 FROM crime
 WHERE crime_type ='Possession of weapons'
GROUP BY falls_within 
HAVING COUNT(*)>1000
ORDER BY knife_crime_count DESC ;

-- Building Categories (CASE WHEN)
SELECT falls_within AS force_name,
COUNT(*) AS total_crimes,
CASE 
WHEN COUNT(*) >5000 THEN 'High volume'
WHEN COUNT(*) >1000 THEN 'Medium volume'
ELSE 'Low volume'
END AS volume_category
FROM crime
WHERE crime_type='Possession of weapons'
GROUP BY falls_within
ORDER BY total_crimes DESC;

-- comparing against an verage (Subquery)
SELECT falls_within AS force_nmae,
COUNT(*) AS knife_crime_count
FROM crime 
WHERE crime_type='Possession of weapons'
GROUP BY falls_within 
HAVING COUNT(*) >(
SELECT AVG(force_count)
FROM(
SELECT COUNT(*) AS force_count
FROM crime
WHERE crime_type='Possession of weapons'
GROUP BY falls_within 
)AS force_totals
)
ORDER BY knife_crime_count DESC;


-- Research Question 
-- Q1.Which forces have the most knife crime?
SELECT falls_within AS force_name,
COUNT(*) AS knife_crimes_total
FROM crime
WHERE crime_type='Possession of weapons'
GROUP BY falls_within
ORDER BY knife_crimes_total DESC
LIMIT 10;

-- Q2.What are the most common outcomes nationally?
SELECT last_outcome AS outcome,
COUNT(*) AS total_count,
ROUND(COUNT(*)* 100.0/SUM(COUNT(*)) OVER (),1) AS pct_of_total
FROM crime
WHERE crime_type='Possession of weapons'
GROUP BY last_outcome
ORDER BY total_count DESC;

-- Q3.Which forces have the worst charge rates?
SELECT falls_within AS force_name,
COUNT(*) AS total_knife_crimes,
SUM(CASE WHEN last_outcome LIKE '%charge%'
OR last_outcome LIKE '%summons%'
THEN 1 ELSE 0 END) AS Charged_count,
ROUND(SUM(CASE WHEN last_outcome LIKE'%charge%'
OR last_outcome LIKE '%summons%'
THEN 1 ELSE 0 END)*100.0/COUNT(*),1) AS charge_rate_pct
FROM crime
WHERE crime_type='Possession of weapons'
GROUP BY falls_within
ORDER BY charge_rate_pct ASC
LIMIT 10;

-- Q4.Which month had the most knife crime?
SELECT month ,
COUNT(*) AS knife_crimes	
FROM crime
WHERE crime_type='Possession of weapons'
GROUP BY month
ORDER BY month ASC ;

  -- Q5.Forces above the national average?
  SELECT falls_within AS force_nmae,
COUNT(*) AS knife_crime_count
FROM crime 
WHERE crime_type='Possession of weapons'
GROUP BY falls_within 
HAVING COUNT(*) >(
SELECT AVG(force_count)
FROM(
SELECT COUNT(*) AS force_count
FROM crime
WHERE crime_type='Possession of weapons'
GROUP BY falls_within 
)AS force_totals
)
ORDER BY knife_crime_count DESC;

  