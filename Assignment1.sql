CREATE TABLE           --Creating table Employee--
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

CREATE TABLE            --Creating table Department--
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

CREATE TABLE          ----Creating table EmployeeAttendance----
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


DELETE FROM	
	EmployeeAttendance
WHERE
	EmpId>=3;

                             -- QUERY 1 --

SELECT         /*Inner join*/
	 Department.DeptName,
	 Employee.Gender,
	 COUNT	
		(
		Employee.Id
		)
		AS
		NoOfEmployees
FROM
(
	Employee
INNER JOIN
	Department
ON 
	Employee.DeptId = Department.DeptId
)
GROUP BY 
	Department.DeptName,
	Employee.Gender;

									--QUERY 2--

SELECT
	Department.DeptName,
	COUNT	
		(
		Employee.Id
		)
		AS
			NoOfEmployee,
	MAX
		(
			Employee.BasicSalary + Employee.HR + Employee.DA
	
		)
	AS
		HighestGrossSalary,
	SUM
		(
		Employee.BasicSalary + Employee.HR + Employee.DA - Employee.TAX
		)
	AS
		TotalSalary
FROM
	Employee
INNER JOIN
	Department
ON 
	Employee.DeptId=Department.DeptId
GROUP BY
	Department.DeptName;

						--	QUERY 3  --

SELECT
	MAX
	(Employee.Name)
		AS
		EmployeeName,
	MAX
	(Employee.BasicSalary+Employee.HR+Employee.DA)
		AS
		GrossSalary,
	Department.DeptName
FROM
	Employee
INNER JOIN
	Department
ON
	Employee.DeptId=Department.DeptId
GROUP BY
	Department.DeptName;
