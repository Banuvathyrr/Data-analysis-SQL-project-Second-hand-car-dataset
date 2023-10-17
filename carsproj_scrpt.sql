create schema cars;
use cars;
-- READ DATA---
select * from carsproj;
-- to count of total records---
select count(name) from carsproj;

-- how many cars will be available in 2023--
select * from carsproj;
select count(*) from carsproj 
where year = '2023'

-- how many cars will be available in 2020,2021,2022--
SELECT year, COUNT(year) AS number 
FROM carsproj
WHERE year IN ('2020', '2021', '2022')
GROUP BY year;

-- how many cars will be available in each year--
SELECT year, COUNT(year) AS number 
FROM carsproj
GROUP BY year;


-- how many diesel cars in 2020--
select fuel, count(*) as number
from carsproj
where fuel = 'Diesel' and year ='2020';

-- how many petrol cars will be there in 2020--
select fuel, count(*) as number
from carsproj
where fuel = 'Petrol' and year ='2020';

-- print all the fuel cars by all year--
select fuel, year
from carsproj
where fuel in ('Petrol','Diesel','CNG')
order by year;


-- which year had more than 100 cars --
select year, count(name) as number
from carsproj
group by year
having number >  100
order by number desc;

-- all car count details between 2015 and 2023--
select year, count(name) as number
from carsproj
group by year
having year between '2015' and '2023';

select count(*) from carsproj where year between '2015' and '2023';

-- all car details between 2015 and 2023--
select *
from carsproj
where year between '2015' and '2023';