CREATE SCHEMA CARS;
USE CARS;


-- READ DATA---
SELECT 
	*
FROM 
	cleaned_cars;


-- TO COUNT TOTAL RECORDS FROM cleaned_cars --
SELECT 
	COUNT(NAME)
FROM 
	cleaned_cars;


-- HOW MANY CARS AVAILABLE IN 2023 MODEL--
SELECT 
	COUNT(*)
FROM 
	cleaned_cars
WHERE 
	year = '2023';


-- HOW MANY CAR MODELS AVAILABLE IN 2020,2021,2022--
SELECT 
	year, 
    COUNT(year) AS Number 
FROM 
	cleaned_cars
WHERE 
	year IN ('2020', '2021', '2022')
GROUP BY 
	year;


-- HOW MANY CAR MODELS AVAILABLE IN EACH YEAR----
SELECT 
	year, 
    COUNT(year) AS Number 
FROM 
	cleaned_cars
GROUP BY 
	year
ORDER BY Number;


-- HOW MANY DIESEL CARS IN 2020--
SELECT 		
	fuel, year, count(*) as Number
FROM 
	cleaned_cars
WHERE 
	fuel = 'Diesel' and year ='2020';
    

-- HOW MANY PETROL CARS IN 2020--
SELECT 		
	fuel, year, count(*) as Number
FROM 
	cleaned_cars
WHERE 
	fuel = 'Petrol' and year ='2020';


-- SHOW ALL FUEL CARS BY ALL YEAR --
SELECT 
	fuel, year
FROM 
	cleaned_cars
WHERE 
	fuel in ('Petrol','Diesel','CNG')
ORDER BY 
	year;


-- WHICH YEAR HAD MORE THAN 100 CARS-- 
-- USING COMMON TABLE EXPRESSION--
WITH CTE AS 
(
SELECT 
	year, count(*) as Number
FROM 
	cleaned_cars
GROUP BY
		year
)
SELECT 
	year, Number 
FROM 
	CTE
WHERE 
	Number > 100
ORDER BY 
	Number desc 
;


-- USING HAVING CLAUSE --
SELECT 
	year, count(year) as Number
FROM 
	cleaned_cars
GROUP BY 
	year
HAVING 
	Number >100
ORDER BY 
	Number desc;


-- NUMBER OF CARS MAKE BETWEEN 2015 and 2023--
SELECT 
	year, count(name) as Number
FROM	
	cleaned_cars
GROUP BY 
	year
HAVING 
	year BETWEEN '2015' and '2023';
    
    
-- AVERAGE SELLING PRICE BY FUEL TYPE--
SELECT 
	fuel, ROUND(AVG(selling_price),2) as avg_selling_price
FROM
	cleaned_cars
GROUP BY
	fuel
ORDER BY 
	avg_selling_price desc;
    -- 1) Average Selling price of Electric vehicle is high compared to the Diesel, Petrol, CNG and LPG.



-- TOTAL NUMBER OF CARS FOR EACH TRANSMISSION TYPE--
SELECT 
	transmission, count(*) as total_cars
FROM 
	cleaned_cars
GROUP BY
	transmission
ORDER BY 
	total_cars;
-- 2) The number of Manual transmissions is greater than the number of Automatic transmissions.


-- MAXIMUM POWER AND TORQUE FOR EACH CAR--
SELECT 
	Name, MAX(max_power) as Maxpower, MAX(torque) as Maxtorque
FROM 
	cleaned_cars
GROUP BY
	Name
ORDER BY 
	Maxpower asc;



-- READ DATA---
SELECT 
	*
FROM 
	cleaned_cars;



-- NUMBER OF CARS OWNED BY EACH SELLER--
SELECT 
	seller_type, count(Name) as No_of_cars_owned
FROM 
	cleaned_cars
GROUP BY
	seller_type
ORDER BY 
	No_of_cars_owned desc;
-- 3) Cars owned by Individual sellers are more than the cars owned by Trustmark Dealer


-- HOW MANY CARS HAVE DIFFERENT SEATING CAPACITIES
SELECT 
	seats, count(Name) as No_of_cars_owned
FROM 
	cleaned_cars
GROUP BY
	seats
ORDER BY 
	No_of_cars_owned desc;
-- 4) 5 seater Cars are found to be large in number compared to other cars of other seating capacity


-- TOP 5 CARS WITH HIGHEST SELLING PRICE --
SELECT
	Name, seats, selling_price
FROM 
	cleaned_cars
ORDER BY
	selling_price desc
LIMIT 5;

-- AVERAGE KILOMETERS DRIVEN BY YEAR--
SELECT
	year, ROUND(AVG(km_driven),2) as Avg_kmdriven
FROM 
	cleaned_cars
GROUP BY
	year
ORDER BY
	Avg_kmdriven desc;
    
 
 -- AVERAGE SELLING PRICE BY TRANSMISSION TYPE--
SELECT 
	transmission, ROUND(AVG(selling_price),2) as avg_selling_price
FROM
	cleaned_cars
GROUP BY
	transmission
ORDER BY 
	avg_selling_price desc;
 -- 5) Average Selling price of Manual is less compared to the Automatic.
   



-- CONVERT km/kg to kmpl BY MULTIPLYING 1.4--
SELECT 
    mileage,
    CASE
        WHEN mileage LIKE '%km/kg' THEN CAST(REPLACE(REGEXP_SUBSTR(mileage, '[0-9,.]+'), ',', '.') AS DECIMAL(5, 2)) * 1.4
        ELSE CAST(REPLACE(REGEXP_SUBSTR(mileage, '[0-9,.]+'), ',', '.') AS DECIMAL(5, 2))
    END AS new_mileage
FROM
    cleaned_cars;


-- ADD NEW COLUMN AS new_mileages
ALTER TABLE cleaned_cars
ADD COLUMN new_mileages DECIMAL(5,2);


-- READ DATA---
SELECT 
	*
FROM 
	cleaned_cars;
    
    
    
UPDATE cleaned_cars 
SET  new_mileages =
    CASE
        WHEN mileage LIKE '%km/kg' THEN CAST(REPLACE(REGEXP_SUBSTR(mileage, '[0-9,.]+'), ',', '.') AS DECIMAL(5, 2)) * 1.4
        ELSE CAST(REPLACE(REGEXP_SUBSTR(mileage, '[0-9,.]+'), ',', '.') AS DECIMAL(5, 2))
    END;



-- AVERAGE MILEAGE BY FUEL TYPE--

SELECT 
	fuel, AVG(new_mileages) as avg_mileage, MAX(new_mileages) as Maxmile
FROM 
	cleaned_cars
GROUP BY 
	fuel
ORDER BY 
	avg_mileage desc;
    
    
    -- INSIGHTS--
       -- 1) Average Selling price of Electric vehicle is high compared to the Diesel, Petrol, CNG and LPG.
       -- 2) The number of Manual transmissions is greater than the number of Automatic transmissions.
       -- 3) Cars owned by Individual sellers are more than the cars owned by Trustmark Dealer
       -- 4) 5 seater Cars are found to be large in number compared to other cars of other seating capacity
        -- 5) Average Selling price of Manual is less compared to the Automatic.
       -- 6) From customer perspective, if the budget is within 10lakhs, it is best to go with DIESEL or PETROL cars having MANUAL transmission 
      -- as The availability of CNG and LPG refueling stations can be limited, making it less convenient in some area.
       

