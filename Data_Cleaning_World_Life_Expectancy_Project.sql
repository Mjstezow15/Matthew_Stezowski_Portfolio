# World Life Expectancy Project (Data Cleaning)


SELECT *
FROM world_life_expectancy
;


# Identifying Duplicates in Data

SELECT Country, Year, CONCAT(Country, Year), COUNT(CONCAT(Country, Year))
FROM world_life_expectancy
GROUP BY Country, Year, CONCAT(Country, Year)
HAVING COUNT(CONCAT(Country, Year)) > 1 
;

# Identiying Row ID of Duplicates
SELECT *
FROM world_life_expectancy
;

SELECT *
FROM(
	SELECT ROW_ID,
	CONCAT(Country, Year),
	ROW_NUMBER() OVER( PARTITION BY CONCAT(Country, Year) ORDER BY CONCAT(Country, Year)) as Row_Num
	FROM world_life_expectancy
	) AS Row_table
WHERE ROW_NUM > 1
;

# Deleting Duplicate Rows

DELETE FROM world_life_expectancy
WHERE 
	ROW_ID IN (
    SELECT ROW_ID
		FROM(
			SELECT ROW_ID,
			CONCAT(Country, Year),
			ROW_NUMBER() OVER( PARTITION BY CONCAT(Country, Year) ORDER BY CONCAT(Country, Year)) as Row_Num
			FROM world_life_expectancy
			) AS Row_table
		WHERE ROW_NUM > 1
        )
;

# Identify Blanks '' & Nulls

SELECT *
FROM world_life_expectancy
WHERE Status = ''
;

SELECT *
FROM world_life_expectancy
WHERE Status IS NULL
;

SELECT DISTINCT(Status)
FROM world_life_expectancy
WHERE Status != ''
;

SELECT DISTINCT(Country)
FROM world_life_expectancy
WHERE Status = 'Developing'
;

SELECT DISTINCT(Country)
FROM world_life_expectancy
WHERE Status = 'Developed'
;

UPDATE world_life_expectancy
SET Status = 'Developing'
WHERE Country IN (SELECT DISTINCT(Country)
				FROM world_life_expectancy
				WHERE Status = 'Developing')
;

UPDATE world_life_expectancy t1
JOIN world_life_expectancy t2
	ON t1.Country = t2.Country
SET t1.Status = 'Developing'
WHERE t1.Status = '' 
AND t2.Status != ''
AND t2.Status = 'Developing'
;

UPDATE world_life_expectancy t1
JOIN world_life_expectancy t2
	ON t1.Country = t2.Country
SET t1.Status = 'Developed'
WHERE t1.Status = '' 
AND t2.Status != ''
AND t2.Status = 'Developed'
;

SELECT *
FROM world_life_expectancy
WHERE `Life expectancy` = ''
;

SELECT Country, Year, `Life expectancy`
FROM world_life_expectancy
;

SELECT t1.Country, t1.Year, t1.`Life expectancy`,
 t2.Country, t2.Year, t2.`Life expectancy`,
 t3.Country, t3.Year, t3.`Life expectancy`,
 ROUND((t2.`Life expectancy` + t3.`Life expectancy`)/2,1) as AVG_2018
FROM world_life_expectancy t1
JOIN world_life_expectancy t2
	ON t1.Country = t2.Country
    AND t1.Year = t2.Year - 1
JOIN world_life_expectancy t3
	ON t1.Country = t3.Country
    AND t1.Year = t3.Year + 1
WHERE t1.`Life expectancy` = ''
;

#Correcting Blanks with AVGs

UPDATE world_life_expectancy t1
JOIN world_life_expectancy t2
	ON t1.Country = t2.Country
    AND t1.Year = t2.Year - 1
JOIN world_life_expectancy t3
	ON t1.Country = t3.Country
    AND t1.Year = t3.Year + 1
SET t1.`Life expectancy` = ROUND((t2.`Life expectancy` + t3.`Life expectancy`)/2,1)
WHERE t1.`Life expectancy` = ''
;

