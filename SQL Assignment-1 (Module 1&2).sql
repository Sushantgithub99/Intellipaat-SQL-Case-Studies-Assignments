--ASSIGNMENT-1  MODULE 1&2

-- SALESMAN TABLE 
CREATE TABLE Salesman(
SalesmanId Int ,
SalesmanName varchar(20),
Commission Int,
City  varchar(20),
Age Int);

Insert Into Salesman values 
(101, 'Joe', 50, 'California', 17),
(102, 'Simon', 75, 'Texas', 25),
(103, 'Jessie', 105, 'Florida', 35),
(104, 'Danny', 100, 'Texas', 22),
(105, 'Lia', 65, 'New Jersey', 30);


---CUSTOMER TABLE

CREATE TABLE Customer (
    SalesmanId INT,
    CustomerId INT,
    CustomerName VARCHAR(255),
    PurchaseAmount INT,
    );

INSERT INTO Customer VALUES
    (101, 2345, 'Andrew', 550),
    (103, 1575, 'Lucky', 4500),
    (104, 2345, 'Andrew', 4000),
    (107, 3747, 'Remona', 2700),
    (110, 4004, 'Julia', 4545);


---Orders Table

CREATE TABLE Orders (OrderId int, CustomerId int, SalesmanId int, Orderdate Date, Amount money)

INSERT INTO Orders Values 
(5001,2345,101,'2021-07-01',550),
(5003,1234,105,'2022-02-15',1500)


--Tasks to be Performed:
--1. Insert a new record in your Orders table.

INSERT INTO Orders Values
(5004,1456,104,'2022-03-16',4000)

--2. Add Primary key constraint for SalesmanId column in Salesman table. 
--Add default constraint for City column in Salesman table. 
--Add Foreign key constraint for SalesmanId column in Customer table. 
--Add not null constraint in Customer_name column for the Customer table.

ALTER TABLE Salesman
Alter Column SalesmanID int Not Null;

ALTER TABLE Salesman
ADD CONSTRAINT PK_SalesmanId PRIMARY KEY (SalesmanId);

ALTER TABLE Salesman
ADD CONSTRAINT DF_City DEFAULT ('DefaultCityValue') FOR City;


Update Customer
Set SalesmanId=102 where SalesmanId=107;

Update Customer
Set SalesmanId=105 where SalesmanId=110;

Alter table Customer 
Add Constraint Fk_SalesmanId FOREIGN KEY (SalesmanId) References Salesman(SalesmanId);

Alter Table Customer 
Alter Column CustomerName Varchar(255)Not Null  ;

--3. Fetch the data where the Customer’s name is ending with ‘N’ also get the purchase amount value greater than 500.

Select CustomerName from Customer where CustomerName like '%N' and PurchaseAmount > 500;

--4. Using SET operators, retrieve the first result with unique SalesmanId values from two tables, and the other result containing SalesmanId with duplicates from two tables.Select SalesmanId from Salesman UnionSelect SalesmanId from Customer;Select SalesmanId from Salesman Union AllSelect SalesmanId from Customer;--5. Display the below columns which has the matching data.Orderdate, Salesman Name, Customer Name, Commission, and City which has the
--range of Purchase Amount between 500 to 1500


Select Orderdate, SalesmanName, CustomerName, Commission, City from Salesman As s
join Customer as c on s.SalesmanId=c.SalesmanId
join Orders as o on c.SalesmanId=o.SalesmanId
where c.PurchaseAmount between 500 and 1500;

--6. Using right join fetch all the results from Salesman and Orders table.Select * from Salesman Right join Orders on Salesman.SalesmanId=Orders.SalesmanId