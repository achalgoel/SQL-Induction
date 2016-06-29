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


CREATE VIEW             /*CREATING VIEW*/
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


