--Assignment -2 
--1.Fetch all the data from jomato table

Select * from Jomato

--2. Create a user-defined functions to stuff the Chicken into ‘Quick Bites’. Eg: ‘QuickChicken Bites’.create function dbo.stuff_chicken()returns table asreturn(select 	Case when RestaurantType='Quick Bites'		Then			CONCAT_WS(' Chicken ',Substring(RestaurantType,1,5),SUBSTRING(RestaurantType,7,len(RestaurantType)-6) )			Else RestaurantType		End as RestaurantType	from dbo.jomato);select * from dbo.stuff_chicken()--3.  Use the function to display the restaurant name and cuisine type which has the maximum number of ratingcreate function dbo.Restaurant_info()returns table asreturn(select RestaurantName,CuisinesType,No_of_Rating as max_rating from dbo.jomatowhere No_of_Rating=(select max(No_of_Rating) from dbo.jomato));select * from dbo.Restaurant_info()--4.Create a Rating Status column to display the rating as ‘Excellent’ if it has more the 4
--start rating, ‘Good’ if it has above 3.5 and below 4 star rating, ‘Average’ if it is above 3--and below 3.5 and ‘Bad’ if it is below 3 star rating select *,	case 	 when Rating > 4 then 'Excellent'	 when   (3.5 < Rating  and Rating <= 4) then 'Good'	 when   (3 < Rating and Rating <= 3.5) then 'Average'	 else 'Bad'	end as Rating_Statusfrom jomato	 --5. Find the Ceil, floor and absolute values of the rating column and display the current date and separately display the year, month_name and day.SELECT 
    CEILING(Rating) AS Nearest_high,
    ABS(Rating) AS Absolute_value,
    FLOOR(Rating) AS Nearest_low,
    GETDATE() AS Current_date_,
    YEAR(GETDATE()) AS Current_Year,
    DATENAME(MONTH, GETDATE()) AS Month_Name,
    DAY(GETDATE()) AS Day_Of_Month
	from jomato--6. Display the restaurant type and total average cost using rollup.select RestaurantType,sum(AverageCost) as TotalAverageCost from jomatogroup by RestaurantType
