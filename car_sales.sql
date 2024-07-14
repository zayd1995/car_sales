use datas;
show tables;
select * from car_sales;
select columns_name
from information_schema.columns
where table_schema = datas
and table_name = car_sales;



SELECT column_name
FROM information_schema.columns
WHERE table_schema = 'datas'
AND table_name = 'car_sales';
 
 select * from car_sales;
 
 select count(case when 'Car_id' is null then 1 end) as car_id,
 count(case when 'Date' is null then 1 end) as dates,
 count(case when 'Customer Name' is null then 1 end) as cus_name,
 count(case when 'Gender' is null then 1 end) as gender,
 count(case when 'Annual Income' is null then 1 end) as ann_income,
 count(case when 'Dealer_Name' is null then 1 end) as dealer,
 count(case when 'Company' is null then 1 end) as company,
 count(case when 'Model' is null then 1 end) as model,
 count(case when 'Engine' is null then 1 end) as engines,
 count(case when 'Transmission' is null then 1 end) as trasmission,
 count(case when 'Color' is null then 1 end) as color,
 count(case when 'Price ($)' is null then 1 end) as price,
 count(case when 'Dealer_No' is null then 1 end) as dealer_nmb,
 count(case when 'Body Style' is null then 1 end) as dody,
 count(case when 'Phone' is null then 1 end) as phone,
 count(case when 'Dealer_Region' is null then 1 end) as dealer_region     
from car_sales;

-- cleaning data 
select * from car_sales cs ;
-- drop unnessecery columns
alter table car_sales 
drop column `Customer Name`;

alter table car_sales 
drop column `Dealer_No`;

-- change date formate 
select date_format(`Date`,'%d/%m/%Y') as date from car_sales cs;

update car_sales 
set `Date`= str_to_date(`Date`,'%d/%m/%Y') 
/*--- Analysing the data 
*/
--- how many cars sold ?

select count(*) from car_sales cs ;

--- number of male and female bought car!;
 select count(`Gender`), `Gender`
 from car_sales cs 
 group by `Gender`
--- the average annual income for Gender !

select avg(`Annual Income`) , `Gender`
from car_sales cs 
group by Gender; 
---- how many dealer we have 
select distinct(`Dealer_Name`)
from car_sales cs2 
;
--- how many company we have ;
select distinct (`Company`)
from car_sales cs 
;
-- best car selling 
select Company , count(Company) as num
from car_sales cs 
group by Company 
order by num desc ;

-- best month selling 
select month(date_format(str_to_date(`Date`,'%d/%m/%Y'), '%Y-%m-%d')) as months
from car_sales cs 
;
/* best month selling in every year */
WITH cte AS (
    SELECT *,
           MONTH(STR_TO_DATE(`Date`, '%d/%m/%Y')) AS sales_month,
           YEAR(STR_TO_DATE(`Date`, '%d/%m/%Y')) AS sales_year
    FROM car_sales
)
SELECT sales_year, 
       sales_month,
       COUNT(*) AS sales_count
FROM cte
GROUP BY sales_year, sales_month
HAVING COUNT(*) = (
    SELECT MAX(monthly_sales)
    FROM (
        SELECT YEAR(STR_TO_DATE(`Date`, '%d/%m/%Y')) AS year,
               MONTH(STR_TO_DATE(`Date`, '%d/%m/%Y')) AS month,
               COUNT(*) AS monthly_sales
        FROM car_sales
        GROUP BY year, month
    ) AS monthly_sales_per_year
    WHERE monthly_sales_per_year.year = cte.sales_year
    GROUP BY monthly_sales_per_year.year
);
 
select * from car_sales cs ;
/* best car selling for every dealer */	
	WITH cte AS (
    SELECT Dealer_Name, Company, COUNT(Company) AS comcount
    FROM car_sales
    GROUP BY Dealer_Name, Company
    ORDER BY Dealer_Name, comcount DESC  
)
SELECT Dealer_Name, Company, MAX(comcount) AS max_comcount
FROM cte
GROUP BY Dealer_Name;




		

























 