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
	Department.DeptName,
	MAX
	(Employee.Name)
		AS
		NameOfEmployee,
	MAX
	(Employee.BasicSalary+Employee.HR+Employee.DA)
		AS
		HighestGrossSalary
	
FROM
	Employee
INNER JOIN
	Department
ON
	Employee.DeptId=Department.DeptId
GROUP BY
	Department.DeptName;

                          --QUERY 4--

SELECT	
	Id,
	Name,
	(BasicSalary+HR+DA)
		AS
		GrossSalary
FROM
	Employee
WHERE
	(BasicSalary+HR+DA)>15000;
	
	                     --QUERY 5--


SELECT
	TOP 1
	Id,
	Name
FROM
	Employee
WHERE
	BasicSalary=
			(
			SELECT 
				MIN(BasicSalary)
			FROM 
				(
				SELECT DISTINCT
				TOP 2 
					BasicSalary
				FROM
					Employee
				ORDER BY
					BasicSalary DESC
				)
				AS
					BS
			)	

						   --QUERY 6--

SELECT
	Department.DeptName,
	COUNT	
		(Employee.Id)
		AS
		NoOfEmployee
FROM
	Employee
INNER JOIN
	Department
ON
	Employee.DeptId=Department.DeptId
GROUP BY
	Department.DeptName
HAVING
	COUNT(Employee.Id)>3;

						--QUERY 7--

SELECT
	Department.DeptName,
	Employee.Name
	AS
		DepartmentHeadName
FROM
	Department
INNER JOIN
	Employee
ON
	Employee.Id=Department.DeptHeadId;
	 
						--QUERY 8--

SELECT
	Name
FROM
	Employee
WHERE
	(
	NOT Employee.Id IN (
				SELECT 
					EmployeeAttendance.EmpId
				FROM
					EmployeeAttendance
				WHERE
					NOT WorkingDays=PresentDays
					)
	);

						--QUERY 9--


SELECT
	Employee.Name
FROM(
	SELECT 
		EmpId,
		SUM(EmployeeAttendance.PresentDays)
		AS
		DaysPresent
		FROM
			EmployeeAttendance
		GROUP BY
			EmpId
		HAVING
		SUM(EmployeeAttendance.PresentDays)=
		(
		SELECT 
		MIN(Present)
			AS
			Minattendance
		FROM
						(
						SELECT
							EmpId,
							SUM(EmployeeAttendance.PresentDays)
								AS
								Present
						FROM
							EmployeeAttendance
						GROUP BY
							EmpId
						)
						AS
							T1
		
		 )
		 )	
		 AS
		 T2
	INNER JOIN
	Employee
	ON
	Employee.Id=T2.EmpId;

						--QUERY 10--

SELECT
	Name
FROM
	Employee
WHERE
	(
	NOT Employee.Id IN (
				SELECT 
					EmployeeAttendance.EmpId
				FROM
					EmployeeAttendance
				WHERE
					NOT WorkingDays-3>PresentDays
					)
	);