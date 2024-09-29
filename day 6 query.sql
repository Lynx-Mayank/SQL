CREATE DATABASE Day6;
use Day6;
CREATE TABLE Example(
    ID INT PRIMARY KEY,                 -- Numeric type
    Name NVARCHAR(100),                 -- String type
    Age INT,                            -- Numeric type
    Salary DECIMAL(10, 2),              -- Numeric type with precision
    BirthDate DATE,                     -- Date type
    LastLogin DATETIME,                 -- DateTime type
    Description NVARCHAR(MAX),          -- Large string type
    ProfilePicture VARBINARY(MAX)       -- Binary large object
);
INSERT INTO Example (ID, Name, Age, Salary, BirthDate, LastLogin, Description, ProfilePicture)
VALUES
(1, 'John Doe', 25, 50000.00, '1999-04-01', '2024-01-15 08:30:00', 'Sample Description 1', NULL),
(2, 'Jane Smith', 35, 60000.00, '1989-07-20', '2024-01-15 09:00:00', 'Sample Description 2', NULL),
(3, 'Mike Johnson', 45, 70000.00, '1979-11-30', '2024-01-15 09:30:00', 'Sample Description 3', NULL),
(4, 'Emily Davis', 55, 80000.00, '1969-03-25', '2024-01-15 10:00:00', 'Sample Description 4', NULL);

--aggregate function
CREATE FUNCTION AvgSalaryByAge(@MinAge INT, @MaxAge INT)
RETURNS DECIMAL(10, 2)
AS
BEGIN
    DECLARE @AvgSalary DECIMAL(10, 2);
    SELECT @AvgSalary = AVG(Salary)
    FROM Example
	WHERE Age BETWEEN @MinAge AND @MaxAge;
	    RETURN @AvgSalary;
END;
GO

--call function
SELECT dbo.AvgSalaryByAge(30, 50) AS AvgSalaryFor30To50;

--variable
DECLARE @myVariable INT;
SET @myVariable = 10;
DECLARE @myTableVariable TABLE (ID INT,Name NVARCHAR(50));
INSERT INTO @myTableVariable 
SELECT ID, Name FROM Exampletable;
SELECT * FROM @myTableVariable;

--temp table
CREATE TABLE #tempTable (
    ID INT,
    Name NVARCHAR(50)
);
INSERT INTO #tempTable 
SELECT ID, Name FROM Exampletable;
SELECT * FROM #tempTable;

--cursor
DECLARE @name NVARCHAR(100);
DECLARE cursorName CURSOR FOR
    SELECT Name FROM Exampletable;
OPEN cursorName;
FETCH NEXT FROM cursorName INTO @name;
WHILE @@FETCH_STATUS = 0
BEGIN
    PRINT @name;
    FETCH NEXT FROM cursorName INTO @name;
END
CLOSE cursorName;
DEALLOCATE cursorName;

--json
DECLARE @json NVARCHAR(MAX) = '{"ID": 1, "Name": "John", "Age": 25}';
SELECT JSON_VALUE(@json, '$.Name') AS Name,
       JSON_VALUE(@json, '$.Age') AS Age;

--xml
DECLARE @xml XML = '<person><ID>1</ID><Name>John</Name><Age>25</Age></person>';
SELECT @xml.value('(/person/Name)[1]', 'NVARCHAR(100)') AS Name,
       @xml.value('(/person/Age)[1]', 'INT') AS Age;

BEGIN TRY
DECLARE @num INT, @msg varchar(200)
---- Divide by zero to generate Error
SET @num = 5/10
PRINT 'This will not execute'
END TRY
BEGIN CATCH
PRINT 'Error occured that is'
set @msg=(SELECT ERROR_MESSAGE())
print @msg;
END CATCH
GO