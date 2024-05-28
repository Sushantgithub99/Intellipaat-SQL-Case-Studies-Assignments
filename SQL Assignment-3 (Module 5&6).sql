--Assignment-3(module 5&6)

select * from jomato

--1. Create a stored procedure to display the restaurant name, type and cuisine where the table booking is not zero.Create procedure Res_infoAsBeginselect RestaurantName,RestaurantType,CuisinesType from Jomato 	where TableBooking != 0End;Exec Res_info--2. Create a transaction and update the cuisine type ‘Cafe’ to ‘Cafeteria’. Check the result and rollback it.Begin transaction	update jomato	set CuisinesType='Cafeteria'	where CuisinesType='Cafe'select * from jomato where CuisinesType='Cafeteria'Rollback Transaction;--3.Generate a row number column and find the top 5 areas with the highest rating of restaurants.

select Top 5 *,
	row_number()over (order by Rating desc)
	from jomato

--4. Use the while loop to display the 1 to 50.

--Creating table
create table NumberTable (
Numbers int);

--Initializing variable with 1 
Declare @count int;
set @count=1;

--running while loop
while @count<51
Begin
	Insert into Numbertable(numbers) values(@count)
	set @count=@count+1
end;

select * from NumberTable


--5. Write a query to Create a Top rating view to store the generated top 5 highest rating of restaurants.

Create or alter view Top_5
As
	select Top 5 *,
	Row_number()over(order by Rating desc) as top_5
	from jomato 

select * from Top_5

6. Create a trigger that give an message whenever a new record is insertedcreate table Insertlog(LogId int Identity(1,1) Primary key,Message Nvarchar(255),Insertdate Datetime)Create Trigger Insert_NewOn jomatoafter insertasbegin	Insert Into InsertLog (Message, Insertdate)	select 'New Recored Inserted into Jomato Table',Getdate()	from inserted end;insert into jomato values(5281,	'Sant Spa Cuisine'	,'Casual Dining',	4.90000009536743,	246	,1000	,0,	1	,'Healthy Food ,Salad ,Mediterranean',	'Old Airport Road',	'Indiranagar',	58	)select * from Insertlog