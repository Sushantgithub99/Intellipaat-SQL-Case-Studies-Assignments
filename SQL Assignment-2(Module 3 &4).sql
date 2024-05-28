--Assignment -2 
--1.Fetch all the data from jomato table

Select * from Jomato

--2. Create a user-defined functions to stuff the Chicken into �Quick Bites�. Eg: �QuickChicken Bites�.
--start rating, �Good� if it has above 3.5 and below 4 star rating, �Average� if it is above 3
    CEILING(Rating) AS Nearest_high,
    ABS(Rating) AS Absolute_value,
    FLOOR(Rating) AS Nearest_low,
    GETDATE() AS Current_date_,
    YEAR(GETDATE()) AS Current_Year,
    DATENAME(MONTH, GETDATE()) AS Month_Name,
    DAY(GETDATE()) AS Day_Of_Month
	from jomato