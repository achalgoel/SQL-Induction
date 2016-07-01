CREATE DATABASE              /*creating database*/
	SQLInduction
	;

CREATE TABLE                  /*creating table employee*/
	Employee
		(
		Id int PRIMARY KEY,
		FirstName VARCHAR(50) NOT NULL,
		LastName VARCHAR(50) NOT NULL,
		Gender VARCHAR(1) NOT NULL
			CHECK (Gender='M' or Gender='F'),
		ActiveStatus BIT DEFAULT '1'
		);

INSERT INTO                    /*Inserting values in employee*/
	Employee VALUES
		('5','Priyanka','Sahani','F','1');

CREATE TABLE                   /*creating table designation*/
	Designation
		(
			Id int FOREIGN KEY REFERENCES Employee(Id),
			Designation varchar(50) NOT NULL
		);

ALTER TABLE 
	Designation
		DROP COLUMN 
			Designation;

DROP TABLE                     /*drop table designation*/
	Designation;

CREATE INDEX                     /*creating index on employee*/
	Index2 
ON  
	Employee
		(
			Salary
		);
DROP INDEX
	Index2 
ON 
	Employee; 

CREATE TABLE                   /*creating table designation*/
	Designation
		(
			Id int PRIMARY KEY,
			Designation varchar(50) NOT NULL
		);

ALTER TABLE                      /*adding column designation to table employee*/
	Employee
		ADD 
			Designation int FOREIGN KEY REFERENCES Designation(Id);

ALTER TABLE                      
	Employee
		ADD
			Salary int ;

SELECT * 
FROM
	Employee 
WHERE 
	Salary IN (55000,30000);         /**/


SELECT *
FROM
	Employee 
WHERE 
	Salary BETWEEN 35000 AND 70000;


SELECT          /*Adding alias for activestatus in table employee*/
	ActiveStatus
AS
	Stat
FROM
	Employee;

SELECT
	Id,FirstName
FROM
	Employee
AS
	Names;

CREATE TABLE          /*Creating tables employee & department for showing joins*/
	Department
		(
			Id int PRIMARY KEY,
			DeprtmentName VARCHAR(50)
		);

INSERT INTO              /*inserting values in table department*/
	Department
VALUES
	('1','Sales'),('2','Accounts'),('3','Development'),('4','Marketing'),('5','Management');

SELECT         /*Inner join*/
	 *
FROM
	Employee
INNER JOIN
	Department
ON 
	Employee.Designation = Department.Id;

SELECT             /*Left join*/
	*
FROM
	Employee
LEFT JOIN
	Department
ON 
	Employee.Designation = Department.Id;

	SELECT          /*Outer join*/
	*
FROM
	Employee
RIGHT JOIN
	Department
ON 
	Employee.Designation = Department.Id;

SELECT              /*Cross join*/
	*
FROM
	Employee
CROSS JOIN
	Department;

SELECT   /*select into*/
	 Employee.FirstName,Employee.Id,Department.DeprtmentName
INTO
	EmployeeBackup
FROM
	Employee
LEFT JOIN
	Department
ON 
	Employee.Designation = Department.Id;

UPDATE            /*Increment salary*/
	Employee
SET
		Salary=Salary +5000;

ALTER TABLE
	Employee
	ADD	
		DOJ date;


CREATE                /*CREATING VIEW*/
	VIEW          
		EmpView1
	AS
		SELECT
			*
		FROM
			Employee
		WHERE
			Salary>50000;

SELECT
	*
FROM
	EmpView1;


SELECT
	*
FROM
	Employee
WHERE
	Salary>(SELECT AVG(Salary)
			 FROM Employee );

SELECT
	*
FROM
	Department

	             




            ---------------(30/06/1995)----------------







SELECT Id,FirstName             --Union Operation
FROM EmployeeBackup	
UNION
SELECT Id,FirstName
FROM Employee;

SELECT                          --Date Operations
*
FROM
	(
	SELECT 
	DATEADD(DAY,20,GETDATE())  --Date operation
		AS dates
	UNION
	SELECT DATEADD(DAY,11,DOJ) 
		FROM Employee
	)
	AS Table1

ALTER TABLE     --adding column Department to Table Employee
	Employee
	ADD
		Department int;

SELECT          --Group By Statement
	Department.DeprtmentName,
	COUNT(Employee.Department)
 		AS
			NumberOfEmployees,
	SUM(Employee.Salary)
		AS
			TotalSalary
FROM 
	Employee
LEFT JOIN
	Department
ON
	Department.Id=Employee.Department
GROUP BY
	Department.DeprtmentName
HAVING
	SUM(Employee.Salary)>10000;    

SELECT          --Group By (Gender based salary distribution)
	Employee.Gender,
	COUNT
		(Employee.Gender)
			AS 
				NumberOfEmployees,
	SUM
		(Employee.Salary)
			AS
				TotalSalary,
	AVG
		(Employee.Salary)
			AS
				AverageSalary
FROM 
	Employee
GROUP BY
	Employee.Gender;
 
SELECT          --Calculating Pf from salary upto 2 decimal places using FORMAT
	FirstName,Designation,Department,
	FORMAT
		((Employee.Salary*0.1275),'N0') 
		AS 
			Pf 
FROM
	Employee;	


SELECT          --Displaying salaries greater than average
	Employee.FirstName,salary
FROM
	Employee
WHERE
	Employee.Salary>(
					SELECT 
						AVG(Employee.Salary)
					FROM
						Employee
					);


SELECT          --Number of employees Department wise
	Department.DeprtmentName,
	COUNT
		(Employee.Department)
		AS
			NumberOfEmployees
FROM
	Employee
LEFT JOIN
	Department
ON
	Employee.Department=Department.Id
GROUP BY
	Department.DeprtmentName; 

SELECT          --employees having salary less than MAX
	Employee.FirstName,
	Employee.Salary
FROM
	Employee
WHERE
	NOT Employee.Salary=(
						SELECT
							MAX
								(Employee.Salary)
						FROM
							Employee
						);

SELECT          --UPPER lower cASE
	UPPER(FirstName),
	LOWER(LastName)
FROM
	Employee;	

SELECT          --LENGTH
	Employee.FirstName,
	Employee.LastName,
	LEN	
		(
		Employee.FirstName + Employee.LastName
		)
		AS LengthOfName
FROM
Employee;

SELECT          --using CONVERT for coverting Date Format
	CONVERT(VARCHAR,DOJ,113)
FROM
	Employee

SELECT          --case
	Employee.FirstName,
	CASE  
	WHEN  
		(Employee.Salary>50000) 
		THEN 
		'YES' 
		ELSE 'NO' 
		END as SalaryCheck
FROM
	Employee 


SELECT          --RANKING--
	Employee.FirstName, 
	Employee.LastName ,
	Salary 
    ,ROW_NUMBER() OVER (ORDER BY Designation) AS "Row Number"  
    ,RANK() OVER (ORDER BY Designation) AS Rank  
    ,DENSE_RANK() OVER (ORDER BY Designation) AS "Dense Rank"  
    ,NTILE(4) OVER (ORDER BY Designation) AS Quartile 
FROM
	Employee

SELECT          --RANKING--
	Employee.FirstName, 
	Employee.LastName ,
	Salary     
FROM
	Employee
WHERE
	(
	SELECT 
		ROW_NUMBER() OVER (ORDER BY Salary)
	FROM
		Employee  
		AS
			T1 
	)
		% 2 = 0 
ORDER BY Salary;


                          

WITH   --CTE--
	EmpCTE(FirstName,Salary,Designation)
	AS
	(
	SELECT FirstName,Salary,Designation.Designation
	 FROM Employee, Designation
	WHERE
		Employee.Designation=Designation.Id
	)
SELECT Salary,Designation
FROM EmpCTE;

                            --(01/07/2016)--

SELECT          --EXCEPT--
	*
FROM
	Employee
EXCEPT
SELECT	
	*
FROM 
	Employee
WHERE
	Employee.Id IN ('2','6','8');



SELECT          --INTERSECT--
	*
FROM
	Employee
WHERE
	Employee.Salary >50000
INTERSECT
SELECT	
	*
FROM 
	Employee
WHERE
	NOT Employee.Id IN ('2','6','8');


SELECT
	*
FROM
	Employee
WHERE
	Employee.Designation IN
					(
					SELECT
						Designation.Id
					FROM
						Designation
					WHERE
						Designation.Designation 
						IN
							('Coder','CEO')				
					);       --Correlated Subqueries--



CREATE CLUSTERED INDEX --Clustered Index--
	EmpIndexSalary
ON
	Employee(Gender ASC,Salary DESC);

SELECT
	*
FROM
	Employee;

CREATE NONCLUSTERED INDEX     --NON Clustered Index--
	EmpIndexId
ON
	Employee(Id ASC);











ALTER PROCEDURE            
	spGetEmployeesById
		@Id int
		WITH ENCRYPTION
	AS
	BEGIN
		SELECT
			*
		FROM
			Employee
		WHERE
			Employee.Id=@Id
	END;




CREATE PROC              /*Stored Procedure Using input & output variables*/
	spGetSlaryById
	@Id int,
	@EmpSalary int OUTPUT
	AS
		BEGIN
				SELECT 
					@EmpSalary = Salary 
				FROM 
					Employee 
				WHERE 
					Employee.Id=@Id
	END

DECLARE @EmpSal int
EXECUTE spGetSlaryById 2, @EmpSal OUT
PRINT  'salary :'
PRINT @EmpSal
	


CREATE PROC              /*Stored Procedure Using return variables*/
	spGetSlaryById2
	@Id int,

	AS
		BEGIN
		RETURN(
				SELECT 		
					Salary 
				FROM 
					Employee 
				WHERE 
					Employee.Id=@Id
				)
	END

DECLARE @EmpSal int
EXECUTE spGetSlaryById 5, @EmpSal OUT
PRINT  'salary of Employee :'

PRINT @EmpSal





