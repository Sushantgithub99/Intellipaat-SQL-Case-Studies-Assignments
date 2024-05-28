CREATE TABLE LOCATION
(Location_ID INT PRIMARY KEY, City VARCHAR(20))

INSERT INTO LOCATION VALUES
(122, 'New York'),
(123 ,'Dallas'),
(124 ,'Chicago'),
(167, 'Boston')

CREATE TABLE DEPARTMENT 
(Department_Id INT PRIMARY KEY, Name VARCHAR(20) , Location_Id INT FOREIGN KEY REFERENCES LOCATION(LOCATION_ID))

INSERT INTO DEPARTMENT VALUES 
(10,'Accounting', 122),
(20,'Sales', 124),
(30,'Research', 123),
(40,'Operations', 167)

CREATE TABLE JOB 
(Job_ID INT PRIMARY KEY , Designation VARCHAR(20))

INSERT INTO JOB VALUES
(667, 'Clerk'),
(668, 'Staff'),
(669 ,'Analyst'),
(670 ,'Sales Person'),
(671 ,'Manager'),
(672 ,'President')

CREATE TABLE EMPLOYEE
(Employee_Id INT,
 Last_Name VARCHAR(20),
 First_Name VARCHAR(20),
 Middle_Name VARCHAR(20),
 Job_Id INT FOREIGN KEY REFERENCES JOB(Job_ID),
 Hire_Date  DATE,
 Salary INT,
 Comm INT DEFAULT 'NULL' ,
 Department_Id INT FOREIGN KEY REFERENCES DEPARTMENT(Department_Id) )

 INSERT INTO EMPLOYEE VALUES
 (7369,'Smith','John','Q', 667, '17-Dec-84',800,NULL, 20),
 (7499 ,'Allen','Kevin','J', 670, '20-Feb-85', 1600, 300, 30),
 (755, 'Doyle' ,'Jean' ,'K', 671 ,'04-Apr-85' ,2850,Null ,30),
 (756 ,'Dennis' ,'Lynn' ,'S', 671 ,'15-May-85' ,2750, Null ,30),
 (757 ,'Baker' ,'Leslie' ,'D', 671, '10-Jun-85', 2200, Null ,40),
 (7521 ,'Wark', 'Cynthia', 'D', 670, '22-Feb-85', 1250, 50, 30)

 ---SIMPLE QUERIES---

 1]-- List all the employee detail

 SELECT * FROM EMPLOYEE

 2]--- List all the department details.

 SELECT * FROM DEPARTMENT

 3]---. List all job details.

 SELECT * FROM JOB

 4]---List all the location.

 SELECT * FROM LOCATION

 5]--. List out the First Name, Last Name, Salary, Commission for all employees.

 SELECT FIRST_NAME,LAST_NAME,SALARY,COMM FROM EMPLOYEE

 6]--- List out the Employee ID, Last Name, Department ID for all employees and
   ---alias
  ---Employee ID as "ID of the Employee", Last Name as "Name of the Employee", Department ID as "Dep_id".

 SELECT EMPLOYEE_ID AS ID_of_the_Employee,LAST_NAME AS Name_of_the_Employee,Department_Id AS DEP_ID FROM EMPLOYEE

 7]--- List out the annual salary of the employees with their names only..

 SELECT FIRST_NAME,MIDDLE_NAME,LAST_NAME,SALARY FROM EMPLOYEE

 ---WHERE Condition:----

 1]-- List the details about'smith'.

 SELECT * FROM EMPLOYEE WHERE Last_Name='SMITH'

 2]--- List out the employees who are working in department 20.

 SELECT * FROM EMPLOYEE WHERE Department_Id=20

 3]---List out the employees who are earning salaries between 3000 and4500.

 SELECT * FROM EMPLOYEE WHERE SALARY BETWEEN 3000 AND 4500

 4]--- List out the employees who are working IN  department 10 or 20 .

 SELECT * FROM EMPLOYEE WHERE DEPARTMENT_ID IN (10,20)

 5]-- Find out the employees who are not working in department 10 or 30.

 SELECT * FROM EMPLOYEE WHERE DEPARTMENT_ID NOT IN (10,30)

 6]---List out the employees whose name start with 's'.

 SELECT * FROM EMPLOYEE WHERE LAST_NAME LIKE 'S%'

 7]---List out the employees whose name starts with 'S' AND ends with 'H'

 SELECT * FROM EMPLOYEE WHERE LAST_NAME LIKE ('S%%H')

 8]---List out the employees whose name length is 4 and start with s

 SELECT * FROM EMPLOYEE WHERE LEN(LAST_NAME)='4' AND LAST_NAME LIKE 'S%'

 9]---List out employees who are working in department 10 and draw salaries more than 3500

 SELECT * FROM EMPLOYEE WHERE DEPARTMENT_ID='10' AND SALARY>3500

 10]---. List out the employees who are not receiving commission.

 SELECT * FROM EMPLOYEE WHERE COMM IS NULL

----- ORDER BY CLAUSE----

 1]-- List out the Employee ID and Last Name in ascending order based on the Employee ID.

 SELECT EMPLOYEE_ID,LAST_NAME FROM EMPLOYEE ORDER BY Employee_Id

 2]--- List out the Employee ID and Name in descending order based onsalary.

  SELECT EMPLOYEE_ID,LAST_NAME FROM EMPLOYEE ORDER BY SALARY DESC

 3]--- List out the employee details according to their Last Name in ascending-order.
 
 SELECT * FROM EMPLOYEE ORDER BY LAST_NAME 

 4]--- List out the employee details according to their Last Name in ascending order and then Department ID in descending order.

 SELECT * FROM EMPLOYEE ORDER BY LAST_NAME ASC,DEPARTMENT_ID DESC

 ---GROUP BY and HAVING Clause:---

 1]---How many employees are in different departments in the organization?

 SELECT D.NAME,COUNT(E.FIRST_NAME) AS NO_OF_EMPLOYEES FROM DEPARTMENT AS D
 JOIN EMPLOYEE AS E ON 
 D.DEPARTMENT_ID=E.DEPARTMENT_ID
 GROUP BY NAME

 2]--- List out the department wise maximum salary, minimum salary and average salary of the employees.

 SELECT D.NAME ,MAX(E.SALARY) as max_sal,MIN(E.SALARY) as min_sal,AVG(E.SALARY) as avg_sal FROM  EMPLOYEE E
 JOIN DEPARTMENT D ON E.DEPARTMENT_ID=D.Department_Id
 GROUP BY NAME


 3]---. List out the job wise maximum salary, minimum salary and average salary of the employee..

SELECT J.DESIGNATION,MAX(E.SALARY),MIN(E.SALARY),AVG(E.SALARY) FROM EMPLOYEE E
JOIN JOB J ON E.Job_Id = J.Job_ID 
GROUP BY Designation

 4]--- List out the number of employees who joined each month in ascendingorder.

 SELECT COUNT(*) AS NO_OF_EMPLOYEES , MONTH(Hire_Date) AS MONTH_OF_HIRING FROM EMPLOYEE
 GROUP BY MONTH(HIRE_DATE)
 ORDER BY MONTH(HIRE_DATE) 

 5]---. List out the number of employees for each month and year in ascending order based on the year and month.

 SELECT COUNT(*) AS NO_OF_EMPLOYEES , MONTH(Hire_Date) AS MONTH_OF_HIRING,YEAR(HIRE_DATE) AS YEAR_OF_HIRING  FROM EMPLOYEE
 GROUP BY YEAR(HIRE_DATE),MONTH(HIRE_DATE)
 ORDER BY YEAR(HIRE_DATE),MONTH(HIRE_DATE) 

 6]---. List out the Department ID having at least four employees.

 SELECT DEPARTMENT_ID,COUNT(LAST_NAME) AS NO_OF_EMPLOYEES FROM EMPLOYEE 
 GROUP BY DEPARTMENT_ID HAVING COUNT(LAST_NAME)>=4

 7]---  How many employees joined in month of january ?

 SELECT COUNT(*) AS NO_EMPLOYESS FROM EMPLOYEE
 WHERE MONTH(HIRE_DATE)=1


 8]--- How many employees joined in the month of January or September?

 SELECT COUNT(*) AS NO_EMPLOYESS FROM EMPLOYEE
 WHERE MONTH(HIRE_DATE) IN(1,9)
 

 9]--- How many employees joined in 1985?

 SELECT COUNT(*) AS NO_EMPLOYESS FROM EMPLOYEE
 WHERE YEAR(HIRE_DATE)=1985
 

 10]---How many employees joined each month of 1985?

 SELECT COUNT(*) AS NO_EMPLOYESS ,MONTH(HIRE_DATE) AS MONTH FROM EMPLOYEE
 WHERE YEAR(HIRE_DATE)=1985 
 GROUP BY HIRE_DATE

 11]---. How many employees joined in March 1985?

  SELECT COUNT(*) AS NO_EMPLOYESS FROM EMPLOYEE
 WHERE YEAR(HIRE_DATE)=1985 AND MONTH(HIRE_DATE)=3

 12]---Which is the Department ID having greater than or equal to 3 employees joining in April 1985?

 SELECT D.Name,COUNT(*) AS NO_EMPLOYESS FROM EMPLOYEE E JOIN DEPARTMENT D 
 ON E.Department_Id=D.Department_Id
 WHERE YEAR(HIRE_DATE)=1985
 GROUP BY D.Name ,YEAR(HIRE_DATE)
 HAVING COUNT(*)>=3

 --SET Operators:----------

 1]---List out the distinct jobs in sales and accounting departments.

 
SELECT DISTINCT DESIGNATION FROM JOB J 
	JOIN EMPLOYEE E   ON 
	J.Job_ID=E.Job_Id
		JOIN
		DEPARTMENT D ON E.Department_Id=D.Department_Id
		WHERE NAME IN('ACCOUNTING','SALES')

2]---List out all the jobs in sales and accounting departments.

SELECT d.Name, DESIGNATION FROM JOB J 
	JOIN EMPLOYEE E   ON 
	J.Job_ID=E.Job_Id
		JOIN
		DEPARTMENT D ON E.Department_Id=D.Department_Id
		WHERE NAME IN('ACCOUNTING','SALES')

3]--- List out the common jobs in research and accounting departments....

SELECT DESIGNATION FROM JOB J 
	JOIN EMPLOYEE E   ON 
	J.Job_ID=E.Job_Id
		JOIN
		DEPARTMENT D ON E.Department_Id=D.Department_Id
		WHERE D.NAME='RESEARCH'
AND 
	J.DESIGNATION IN ( SELECT DESIGNATION FROM JOB J1
	JOIN EMPLOYEE E1   ON 
	J1.Job_ID=E1.Job_Id
		JOIN
		DEPARTMENT D1 ON E1.Department_Id=D1.Department_Id
		WHERE D1.NAME='ACCOUNTING')
ORDER BY J.DESIGNATION	ASC;

-----Subqueries:-----

1]--- Display the employees list who got the maximum salary---

SELECT * FROM EMPLOYEE WHERE SALARY=(SELECT MAX(SALARY) AS MAXIMUM_SALARY FROM EMPLOYEE) 

2]---. Display the employees who are working in sales department...

SELECT * FROM EMPLOYEE WHERE Department_Id=(SELECT Department_Id FROM DEPARTMENT WHERE Name='SALES')

3]---Display the employees who are working as CLERK

SELECT * FROM EMPLOYEE WHERE Job_Id = (SELECT Job_Id FROM JOB WHERE DESIGNATION='CLERK')

4]--- Display the list of employees who are living in "New York"

SELECT * FROM EMPLOYEE
	WHERE
	Department_Id= (SELECT Department_Id FROM DEPARTMENT
						WHERE
						Location_Id=(SELECT LOCATION_ID FROM LOCATION 
										WHERE 
										CITY='NEW YORK'))

5]---. Find out the number of employees working in the sales department.

SELECT COUNT(*) AS NO_EMPLOYEE FROM EMPLOYEE E
	JOIN JOB J    ON 
	E.Job_ID=J.Job_Id
		JOIN
		DEPARTMENT D ON E.Department_Id=D.Department_Id
		WHERE D.NAME='SALES'

6]----Update the salaries of employees who are working as clerks on the basis of 10%...

UPDATE EMPLOYEE 
SET SALARY=SALARY * 1.1
FROM EMPLOYEE WHERE JOB_ID=(SELECT JOB_ID FROM JOB WHERE DESIGNATION ='CLERK')

7]---Delete the employees who are working in the accounting departrment..

DELETE FROM EMPLOYEE
	WHERE
		DEPARTMENT_ID IN (SELECT Department_Id FROM DEPARTMENT WHERE NAME='ACCOUNTING')

8]---Display the second highest salary drawing employee details..

SELECT TOP 1 *
FROM EMPLOYEE
WHERE Salary < (SELECT MAX(Salary) FROM EMPLOYEE)
ORDER BY Salary DESC;

9]---Display the nth highest salary drawing employee details---

DECLARE @N INT;
SET @N = 3;
SELECT *
FROM (
    SELECT *, DENSE_RANK() OVER (ORDER BY Salary DESC) AS SalaryRank
    FROM EMPLOYEE
) AS RankedEmployees
WHERE SalaryRank = @N;

10]---List out the employees who earn more than every employee in department 30.

SELECT * FROM EMPLOYEE WHERE SALARY > ALL(SELECT SALARY FROM EMPLOYEE WHERE Department_Id='30')

11]---List out the employees who earn more than the lowest salary in department.

SELECT * FROM EMPLOYEE WHERE SALARY > (SELECT MIN(SALARY) FROM EMPLOYEE )

12]---Find out which department has no employees.

SELECT NAME FROM DEPARTMENT
	WHERE NOT EXISTS
	(SELECT 1 FROM EMPLOYEE WHERE EMPLOYEE.Department_Id=DEPARTMENT.Department_Id)

13]---. Find out the employees who earn greater than the average salary for their department.

SELECT * FROM EMPLOYEE WHERE SALARY > (SELECT AVG(SALARY) FROM EMPLOYEE)
