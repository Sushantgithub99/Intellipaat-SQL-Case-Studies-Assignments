Create Database Case_Study_1


1] --Display the number of states present in the LocationTable.

SELECT  COUNT(DISTINCT STATE) AS NO_STATE FROM [LOCATION]

2]--- How many products are of regular type?

SELECT COUNT(PRODUCT) AS NO_PRODUCT FROM PRODUCT WHERE TYPE='REGULAR'

3] ----How much spending has been done on marketing of product ID

alter table fact
alter column marketing int
SELECT SUM(MARKETING) AS SPENDING FROM FACT WHERE PRODUCTID='1'

4]---- What is the minimum sales of product

SELECT PRODUCT,SALES FROM FACT 
 JOIN 
PRODUCT 
ON FACT.ProductId=PRODUCT.ProductId 
WHERE
SALES=(SELECT MIn(Sales)  FROM FACT) 
group by product,SALES

5] --- Display the max Cost of Good Sold (COGS).

SELECT MAX(COGS) MAXCOGS FROM  fact

6] ----Display the details of the product where product type is coffee.

SELECT * FROM PRODUCT WHERE [Product Type]='COFFEE'

7] ----. Display the details where total expenses are greater than  40

SELECT * FROM FACT WHERE [Total Expenses]>40

8] --- What is the average sales in area code 719

SELECT AVG(SALES) AS AVG_SALES FROM FACT WHERE [Area Code]=719 GROUP BY [Area Code]

9]---Find out the total profit generated by Colorado state

SELECT STATE,SUM(PROFIT) AS TOT_PROFIT FROM FACT
JOIN [LOCATION]
ON FACT.[AREA CODE]=LOCATION.[Area Code]
GROUP BY State
HAVING STATE ='COLORADO'

10] ---Display the average inventory for each product id

SELECT PRODUCTID,AVG(INVENTORY) FROM FACT 
GROUP BY ProductId

11] ----Display state in a sequential order in a Location

SELECT DISTINCT STATE FROM [LOCATION] ORDER BY STATE DESC

12] ---Display the average budget of the Product where the average budget margin should be greater than 100--

SELECT  PRODUCT,AVG([Budget Margin]) FROM FACT 
JOIN PRODUCT
ON FACT.ProductId=PRODUCT.ProductId
GROUP BY PRODUCT
HAVING AVG([Budget MARGIN])>100

13] ---What is the total sales done on date 2010-01-01

 SELECT DATE,SUM(SALES) AS TOTAL_SALES FROM FACT WHERE DATE='2010-01-01' GROUP BY DATE

14]---Display the average total expense of each product ID on an individual date

SELECT PRODUCTID,DATE,AVG([Total Expenses]) AS AVG_EXPENSE FROM FACT
GROUP BY PRODUCTID ,DATE

15]----Display the table with the following attributes such as date, productID, product_type, product, sales, profit, state,area code.

SELECT PRODUCT.productID,date, Product, product, sales, profit, state,LOCATION.[area code] FROM FACT
JOIN PRODUCT ON FACT.ProductId=PRODUCT.ProductId
JOIN [LOCATION] ON FACT.[Area Code]=LOCATION.[Area Code]

16] ---Display the rank without any gap to show the sales wise rank

SELECT SALES,DENSE_RANK() OVER (ORDER BY SALES DESC) AS RANKING FROM FACT

17] ----Find the state wise profit & sales

SELECT LOCATION.STATE,SUM([BUDGET PROFIT]) AS TOT_PROFIT,SUM(SALES) AS TOT_SALES FROM FACT
JOIN [LOCATION] ON FACT.[Area Code]=[LOCATION].[Area Code]
GROUP BY STATE

18]---- Find the state wise profit and sales along with the product name.--

SELECT [Location].STATE,PRODUCT.PRODUCT,SUM(PROFIT) AS TOT_PROFIT,SUM(SALES ) AS TOT_SALES FROM FACT
JOIN PRODUCT ON FACT.ProductId=PRODUCT.ProductId
JOIN [location] on FACT.[Area Code]=[LOCATION].[Area Code]
GROUP BY State,Product

19]---- If there is an increase in sales of 5%, calculate the increased sales.

SELECT SALES,(SALES)*0.05 AS INCRASED_SALES FROM FACT  

20]----Find the maximum profit along with the product ID and producttype

SELECT FACT.PRODUCTID,PRODUCT.[Product Type],(PROFIT) AS MAX_PROFIT FROM 
FACT JOIN PRODUCT 
ON FACT.PRODUCTID=PRODUCT.ProductId  WHERE PROFIT =(SELECT MAX(PROFIT) FROM FACT)


21]----Create a stored procedure to fetch the result according to the product type from Product Table.---

CREATE PROCEDURE GetProductsByType ( @p_ProductType VARCHAR(50))
AS
BEGIN
    SELECT ProductID, Product, [Product Type]
    FROM Product
    WHERE [Product Type] = @p_ProductType;
END;

EXEC GetProductsByType'COFFEE'

22]--Write a query by creating a condition in which if the total expenses is less than 60 then it is a profit or else loss.---

SELECT PRODUCTID,[Total Expenses],IIF([TOTAL EXPENSES]<60,'PROFIT','LOSS') FROM FACT

23]---Give the total weekly sales value with the date and product ID details. Use roll-up to pull the datain heirarchical order--

SELECT DATE,productid,sum(sales) as total_WEEKLY_SALES from fact group by ProductId,date with ROLLUP 

24] ----Apply union and intersection operator on the tables which consist of attribute area code.--

SELECT [Area Code] FROM FACT
INTERSECT
SELECT [Area Code] FROM Location
--INTERSECT USING JOIN 
SELECT DISTINCT FACT.[Area Code] FROM FACT INNER JOIN Location ON FACT.[Area Code]=Location.[Area Code]

SELECT [Area Code] FROM FACT
UNION
SELECT [Area Code] FROM Location

25]---Create a user-defined function for the product table to fetch a particular product type based upon the user's preference.--

CREATE FUNCTION PR_TYPE(@PRODCT_TYPE VARCHAR(50))
RETURNS TABLE 
AS 
RETURN 
SELECT * FROM PRODUCT
WHERE PRODUCT.[Product Type]=@PRODCT_TYPE

SELECT * FROM DBO.PR_TYPE('COFFEE')

26] ---Change the product type from coffee to tea where product ID is 1 and undo it.--

BEGIN TRANSACTION
UPDATE  PRODUCT
SET [PRODUCT TYPE]='TEA'
WHERE PRODUCTID=1

ROLLBACK TRANSACTION
27]---Display the date, product ID and sales where total expenses are between 100 to 200--

SELECT PRODUCTID,DATE,SALES FROM FACT WHERE [Total Expenses] BETWEEN 100 AND 200 ORDER BY ProductId

28]---Delete the records in the Product Table for regular type

DELETE FROM PRODUCT WHERE TYPE='REGULAR'

29]---Display the ASCII value of the fifth character from the columnProduct.--

SELECT ASCII(SUBSTRING(PRODUCT,5,1)) FROM PRODUCT