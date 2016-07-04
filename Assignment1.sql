CREATE TABLE
	Employee
		(
		Id smallint PRIMARY KEY,
		Name varchar(30) NOT NULL,
		Gender varchar(6)
			CHECK (Gender='Male' or Gender='Female'),
		BasicSalary int,
		HR int,
		DA int,
		TAX int,
		DeptId smallint
		);

INSERT INTO	
	Employee
VALUES
	(1,'Anil','Male',10000,5000,1000,400,1);

SELECT
	*
FROM
	Employee

CREATE TABLE
	Department
		(
		DeptId smallint PRIMARY KEY,
		DeptName varchar(20) NOT NULL,
		DeptHeadId smallint NOT NULL
		)
INSERT INTO
	Department
VALUES
	(1,'HR',1),
	(2,'Admin',2),
	(3,'Sales',9),
	(4,'Engineering',5);

SELECT
	*
FROM
	Department;

CREATE TABLE
	EmployeeAttendance
		(
		EmpId smallint,
		Dates date,
		WorkingDays smallint,
		PresentDays smallint
		);

INSERT INTO	
	EmployeeAttendance
VALUES
	(1,'01/01/2010',22,21);

SELECT
	*
FROM
	EmployeeAttendance;

ALTER TABLE
	EmployeeAttendance
	MODIFY COLUMN
		EmpId smallint;