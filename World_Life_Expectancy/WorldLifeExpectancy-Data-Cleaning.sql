## World Life Expectancy Data Cleaning

##Data Cleaning activities
##Removing Duplicates
##Filling missing values by calculating average, corresponding values in the common columns.

USE world_life_expectancy;  # The statements in this script will use this database
select * from worldlifexpectancy LIMIT 20;     
select count(*) from worldlifexpectancy;   ## Returns 2938 records

# Find the duplicate data (rows)
select  country, year , concat(country,year) , count(concat(country,year)) from worldlifexpectancy 
group by country, year , concat(country,year) having count(concat(country,year)) > 1;
# Shows 3 records

#Remove duplicates, backup the table before removing any duplicates - Done 

# Utilize Window function to find out the duplicate data
select row_id , country, year, concat(country,year), dup_rec from (
select  row_id, country, year , concat(country,year), ROW_NUMBER() OVER(PARTITION BY country,year) as "dup_rec"
from worldlifexpectancy ) worldlifeexpect where dup_rec > 1;

#Clean Data utilizing windows function
delete from worldlifexpectancy where row_id in
( select row_id from 
(select row_id , country, year, concat(country,year), dup_rec from (
select  row_id, country, year , concat(country,year), ROW_NUMBER() OVER(PARTITION BY country,year) as "dup_rec"
from worldlifexpectancy ) worldlifeexpect where dup_rec > 1
) worldlifeexpect_temp
);


select count(*) from worldlifexpectancy where (Lifeexpectancy = "" or Status = "");  # returns 10 records
select * from worldlifexpectancy where (Lifeexpectancy = "" or Status = "");
select * from worldlifexpectancy where Lifeexpectancy = "" ;  ##returns 2 records
select * from worldlifexpectancy where Status = '' ;  ##returns 8 records

# Update the table with missing values for column status as developing using SELF JOIN
Update worldlifexpectancy source JOIN worldlifexpectancy dest 
ON source.Country = dest.Country 
Set source.Status = dest.Status 
where source.status = '' and dest.Status <> '' and dest.Status = 'Developing';

Update worldlifexpectancy source JOIN worldlifexpectancy dest 
ON source.Country = dest.Country 
Set source.Status = dest.Status 
where source.status = '' and dest.Status <> '' and dest.Status = 'Developed';

# Check distinct status and status column
select Distinct status from worldlifexpectancy;
select country,status from worldlifexpectancy where trim(Status) = 'Developing';
select country,status from worldlifexpectancy where trim(Status) != 'Developing';

##SELECT column_name1,  window_function(column_name2) OVER([PARTITION BY column_name1] [ORDER BY column_name3])
# AS new_column FROM table_name;
# Check for Lifeexpectancy column
select * from worldlifexpectancy where Lifeexpectancy="" ; ## shows 2 records for country Afghanistan and Albania for year 2018 as blank
select * from worldlifexpectancy LIMIT 20;
##Update Lifeexpectancy column by updating it with average from before and after values for the 
##same country

UPDATE worldlifexpectancy source 
JOIN worldlifexpectancy dest1
	ON source.Country = dest1.Country and source.year = dest1.year - 1
JOIN worldlifexpectancy dest2
	ON source.Country = dest2.Country and source.year = dest2.year + 1
SET source.Lifeexpectancy= ROUND((dest1.Lifeexpectancy + dest2.Lifeexpectancy)/2,1)
where source.Lifeexpectancy = '';

select * from worldlifexpectancy where Lifeexpectancy="" ;
select * from worldlifexpectancy LIMIT 200;
##Check the value in Lifeexpectancy for year 2018 with the average of values from 2017 and 2019 years.
select * from worldlifexpectancy where (Country in ('Afghanistan','Albania')) and year in ('2017','2018','2019');


## Values updated for Lifeexpectancy column











