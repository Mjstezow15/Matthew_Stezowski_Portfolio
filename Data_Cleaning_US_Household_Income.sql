#US House Hold Income Data Project (Data Cleaning File)

SELECT *
FROM us_household_income;

SELECT *
FROM us_household_income_statistics;

# Corrected Bad Label from Importing Table

ALTER TABLE us_household_income_statistics RENAME COLUMN `ï»¿id` TO `id`;

#Verified Data Import Records

SELECT Count(id)
FROM us_household_income;

SELECT Count(id)
FROM us_household_income_statistics;

#Checking 1st Table us_household_income for Duplicates

SELECT id, COUNT(id)
FROM us_household_income
GROUP BY id
HAVING COUNT(id) > 1
;

# After finding duplicates, I located the row ID associated with the duplicates with a Sub Query

SELECT *
FROM(
SELECT row_id, 
id, 
ROW_NUMBER() OVER(PARTITION BY id ORDER BY id) row_num
FROM us_household_income
) AS duplicates
WHERE row_num > 1
;

# Used the same set above to write a delete statement to removed duplicates

DELETE FROM us_household_income
WHERE row_id IN(
	SELECT row_id
	FROM(
		SELECT row_id, 
		id, 
		ROW_NUMBER() OVER(PARTITION BY id ORDER BY id) row_num
		FROM us_household_income
		) AS duplicates
	WHERE row_num > 1)
;
#Checking 2nd Table us_household_income_statistics for Duplicates
SELECT id, COUNT(id)
FROM us_household_income_statistics
GROUP BY id
HAVING COUNT(id) > 1
;

# Searching for Spelling Errors in State_Name Column

SELECT DISTINCT State_Name, COUNT(State_Name)
FROM us_household_income
GROUP BY 1
;

# Used update function to correct miss spelled and to format some data. Since it was a short list used Update Function for both

UPDATE us_household_income
SET State_Name = 'Georgia'
WHERE State_Name = 'georia'
;

UPDATE us_household_income
SET State_Name = 'Alabama'
WHERE State_Name = 'alabama'
;

# Checking missing data in Place column (blanks)

SELECT *
FROM us_household_income
WHERE Place = ''
ORDER BY 1
;

SELECT *
FROM us_household_income
WHERE Place = 'Autauga County'
ORDER BY 1
;

UPDATE us_household_income
SET Place = 'Autaugaville'
WHERE County = 'Autauga County'
AND City = 'Vinemont';

# Checking missing data in Type column (blanks)

SELECT Type, Count(Type)
FROM us_household_income
GROUP BY Type
;

UPDATE us_household_income
SET Type = 'Borough'
WHERE Type = 'Boroughs'
;

# Checking missing/zero data in ALand & AWater column 

SELECT ALand, AWater
FROM us_household_income
WHERE (AWater = 0 OR AWater = '' OR AWater IS NULL);

SELECT ALand, AWater
FROM us_household_income
WHERE (ALand = 0 OR ALand = '' OR ALand IS NULL);

SELECT ALand, AWater
FROM us_household_income
WHERE (AWater = 0 OR AWater = '' OR AWater IS NULL)
AND (ALand = 0 OR ALand = '' OR ALand IS NULL);

