SELECT *
FROM tv_shows;

-- DATA CLEANING 
-- FIRST COPY ALL THYE DATA INTO A NEW SIMILAR TABLE TO PRESERVE THE ACTUAL DATA
CREATE TABLE tv_shows_stage
LIKE tv_shows;

INSERT INTO tv_shows_stage
SELECT *
FROM tv_shows;

SELECT *
FROM tv_shows_stage;

-- THEN CHECK FOR DUPLICATES
WITH CTE_1 AS 
(
SELECT *, ROW_NUMBER() OVER(PARTITION BY MyUnknownColumn, ID, Title, `Year`, Age, IMDb, Rotten_Tomatoes, Netflix, Hulu, Prime_Video, `Type`) AS row_num
FROM tv_shows_stage
)
SELECT *
FROM CTE_1
WHERE row_num > 1;

SELECT *
FROM tv_shows_stage;

-- DROP MYUNKNOWN COLUMN AS IT IS NOT USEFUL. DROP TYPE
ALTER TABLE tv_shows_stage
DROP COLUMN MyUnknownColumn;

ALTER TABLE tv_shows_stage
DROP COLUMN `Type`;

SELECT *
FROM tv_shows_stage;

-- EXPLORATORY ANALYSIS
-- 1a) TOP 10 RATED SHOWS BY IMDb
SELECT Title, IMDb
FROM tv_shows_stage
ORDER BY 2 DESC
LIMIT 10;

-- 1b) TOP 10 RATED SHOWS BY ROTTEN TOMATOES
SELECT Title, Rotten_Tomatoes
FROM tv_shows_stage
ORDER BY 2 DESC
LIMIT 10;

SELECT *
FROM tv_shows_stage;

-- 2) TOP 10 HIGHEST RATED IMDB AND ROTTEN TOMATOES SHOWS FOR ADULTS
SELECT Title, Age, IMDb, Rotten_Tomatoes
FROM tv_shows_stage
WHERE Age = "18+"
ORDER BY 3 DESC, 4 DESC
LIMIT 10;

-- 3) YEARS WITH THE MOST RELEASES
SELECT `Year`, COUNT(*)
FROM tv_shows_stage
GROUP BY `Year`
ORDER BY 2 DESC;

SELECT *
FROM tv_shows_stage;

-- 4) WHICH PLATFORM HAS THE MOST SHOWS
SELECT Netflix, Hulu, Prime_Video, COUNT(*)
FROM tv_shows_stage
GROUP BY Netflix, Hulu, Prime_Video
ORDER BY 4 DESC;

-- 5) PLATFORM WITH TOP 10 HIGHEST RATED SHOWS
SELECT Title, IMDb, Rotten_Tomatoes, Netflix, Hulu, Prime_Video
FROM tv_shows_stage
GROUP BY Title, IMDb, Rotten_Tomatoes, Netflix, Hulu, Prime_Video
ORDER BY 2 DESC, 3 DESC
LIMIT 10;

SELECT DISTINCT `Year`, COUNT(*)
FROM tv_shows_stage
GROUP BY `Year`;

SELECT *
FROM tv_shows_stage;

SELECT DISTINCT Age
FROM tv_shows_stage;

-- 6) HIGHEST RATED SHOWS FROM 2016 TILL DATE
SELECT Title, `Year`, IMDb, Rotten_Tomatoes
FROM tv_shows_stage
WHERE `Year` >= 2016
ORDER BY 3 DESC, 4 DESC;

-- 7) HIGHEST RATED SHOWS FROM 2016 TILL DATE WITH PLATFORMS SHOWING THEM
SELECT Title, `Year`, IMDb, Rotten_Tomatoes, Netflix, Hulu, Prime_Video
FROM tv_shows_stage
WHERE `Year` >= 2016
ORDER BY 3 DESC, 4 DESC;

-- 8) HIGHEST RATED SHOWS FROM 2016 TILL DATE FOR CHILDREN
SELECT Title, `Year`, Age, IMDb, Rotten_Tomatoes
FROM tv_shows_stage
WHERE `Year` >= 2016
AND Age = '7+'
ORDER BY 4 DESC, 4 DESC;

-- 9) HIGHEST RATED SHOWS FROM 2016 TILL DATE FOR CHILDREN WITH PLATFORMS SHOWING THEM
SELECT Title, `Year`, Age, IMDb, Rotten_Tomatoes, Netflix, Hulu, Prime_Video
FROM tv_shows_stage
WHERE `Year` >= 2016
AND Age = '7+'
ORDER BY 4 DESC, 4 DESC;
