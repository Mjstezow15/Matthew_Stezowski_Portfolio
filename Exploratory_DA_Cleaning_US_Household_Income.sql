#US House Hold Income Data Project (Exploratory Data Analysis)


SELECT *
FROM us_household_income;

SELECT *
FROM us_household_income_statistics;


# How Much Land and Water Per State?

SELECT State_Name, County, City, ALand, AWater
FROM us_household_income;

SELECT State_Name, SUM(ALand), SUM(AWater)
FROM us_household_income
GROUP BY State_Name
ORDER BY 2 DESC
;

# How Much Water Per State?

SELECT State_Name, SUM(AWater)
FROM us_household_income
GROUP BY State_Name
ORDER BY 2 DESC
;

# Top 10 Largest States by Land?
SELECT State_Name, SUM(ALand)
FROM us_household_income
GROUP BY State_Name
ORDER BY 2 DESC
LIMIT 10
;

# Top 5 Largest States by Water?
SELECT State_Name, SUM(AWater)
FROM us_household_income
GROUP BY State_Name
ORDER BY 2 DESC
LIMIT 5
;

# Combine the Tables with INNER JOIN to Analyze Data

SELECT *
FROM us_household_income u
JOIN us_household_income_statistics us
ON u.id= us.id
;

# Using a RIGHT JOIN to to combine data from us_household_income_statistics to fill in blanks in us_household_income

SELECT *
FROM us_household_income u
RIGHT JOIN us_household_income_statistics us
ON u.id= us.id
WHERE u.id IS NULL
;

# Reviewing State Income Mean & Median

SELECT *
FROM us_household_income u
INNER JOIN us_household_income_statistics us
ON u.id= us.id
WHERE MEAN <> 0
;

# 5 Lowest States By Mean Income 

SELECT u.State_Name, ROUND(AVG(Mean),1), ROUND(AVG(Median),1)
FROM us_household_income u
INNER JOIN us_household_income_statistics us
ON u.id= us.id
WHERE MEAN <> 0
GROUP BY u.State_Name
ORDER BY 2
LIMIT 5
;

# Top 10 States by Mean Income 

SELECT u.State_Name, ROUND(AVG(Mean),1), ROUND(AVG(Median),1)
FROM us_household_income u
INNER JOIN us_household_income_statistics us
ON u.id= us.id
WHERE MEAN <> 0
GROUP BY u.State_Name
ORDER BY 2 DESC
LIMIT 10;

# Top 10 States by Median Income 

SELECT u.State_Name, ROUND(AVG(Mean),1), ROUND(AVG(Median),1)
FROM us_household_income u
INNER JOIN us_household_income_statistics us
ON u.id= us.id
WHERE MEAN <> 0
GROUP BY u.State_Name
ORDER BY 3 DESC
LIMIT 10;

# Lowest 10 States by Median Income 

SELECT u.State_Name, ROUND(AVG(Mean),1), ROUND(AVG(Median),1)
FROM us_household_income u
INNER JOIN us_household_income_statistics us
ON u.id= us.id
WHERE MEAN <> 0
GROUP BY u.State_Name
ORDER BY 3 ASC
LIMIT 10;

# Comparing Type in Correlation to Median Income

SELECT Type, COUNT(Type), ROUND(AVG(Mean),1), ROUND(AVG(Median),1)
FROM us_household_income u
INNER JOIN us_household_income_statistics us
ON u.id= us.id
WHERE MEAN <> 0
GROUP BY 1
HAVING COUNT(type) > 100
ORDER BY 4 DESC
LIMIT 20;

SELECT *
FROM us_household_income
WHERE Type = 'Community';



SELECT u.State_Name, City, ROUND(AVG(Mean),1), ROUND(AVG(Median),1)
FROM us_household_income u
INNER JOIN us_household_income_statistics us
ON u.id= us.id
GROUP BY u.State_Name, City
ORDER BY ROUND(AVG(Mean),1) DESC
;

SELECT u.State_Name, ROUND(AVG(Mean),1), ROUND(AVG(Median),1)
FROM us_household_income u
INNER JOIN us_household_income_statistics us
ON u.id= us.id
WHERE u.State_Name = 'Indiana';


