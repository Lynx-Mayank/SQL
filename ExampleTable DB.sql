CREATE DATABASE TABLE_Examples;
CREATE TABLE ExampleTable (
    ID INT PRIMARY KEY,                 -- Numeric type
    Name NVARCHAR(100),                 -- String type
    Age INT,                            -- Numeric type
    Salary DECIMAL(10, 2),              -- Numeric type with precision
    BirthDate DATE,                     -- Date type
    LastLogin DATETIME,                 -- DateTime type
    Description NVARCHAR(MAX),          -- Large string type
    ProfilePicture VARBINARY(MAX)       -- Binary large object
);
INSERT INTO ExampleTable (
    ID, Name, Age, Salary, BirthDate, LastLogin, Description, ProfilePicture)
	VALUES (
    1,
    N'John Doe',                          -- NVARCHAR requires the N prefix for Unicode strings
    30,
    60000.00,
    '1993-05-15',                         -- Date in 'YYYY-MM-DD' format
    '2024-05-29 10:30:00',                -- DateTime in 'YYYY-MM-DD HH:MM:SS' format
    N'This is a description.',
    CAST(0xFFD8FFE000104A46494600010101004800480000FFDB004300080606070605080707070909080A0C140D0C0B0B0C19120F0D14211C231D211E1E1E23 AS VARBINARY(MAX))  -- Simplified binary data
);
INSERT INTO ExampleTable (
    ID, Name, Age, Salary, BirthDate, LastLogin, Description, ProfilePicture
) VALUES 
(
    2,
    N'Jane Smith',                        -- NVARCHAR requires the N prefix for Unicode strings
    28,
    55000.00,
    '1995-07-20',                         -- Date in 'YYYY-MM-DD' format
    '2024-05-29 11:45:00',                -- DateTime in 'YYYY-MM-DD HH:MM:SS' format
    N'This is another description.',
    CAST(0xFFD8FFE000104A46494600010101004800480000FFDB004300080606070605080707070909080A0C140D0C0B0B0C19120F0D14211C231D211E1E1E23 AS VARBINARY(MAX))  -- Simplified binary data
	),
(
    3,
    N'Emily Brown',                       -- NVARCHAR requires the N prefix for Unicode strings
    35,
    72000.00,
    '1988-03-11',                         -- Date in 'YYYY-MM-DD' format
    '2024-05-28 14:15:00',                -- DateTime in 'YYYY-MM-DD HH:MM:SS' format
    N'This is yet another description.',
    CAST(0xFFD8FFE000104A46494600010101004800480000FFDB004300080606070605080707070909080A0C140D0C0B0B0C19120F0D14211C231D211E1E1E23 AS VARBINARY(MAX))  -- Simplified binary data
);
select * from ExampleTable
SELECT DISTINCT Name FROM ExampleTable; --get distinct values of the Name column:
SELECT TOP 2 * FROM ExampleTable;		-- to get the top 2 rows
SELECT * FROM ExampleTable WHERE Age = 30;   --get rows where Age is greater than 30:
SELECT DISTINCT Age, Name FROM ExampleTable;   --to get distinct Age values and their corresponding Name
SELECT * FROM ExampleTable  
WHERE Age between 29 and 34;  --Used to specify multiple values in a WHERE clause.
SELECT * FROM ExampleTable 
WHERE Name LIKE '%B%';  --% is a wildcard that represents zero or more characters.
SELECT * FROM ExampleTable WHERE Description LIKE '%description%';  -- Contains 'description'

insert into ExampleTable (ID, Name, Age, Salary, BirthDate, LastLogin, Description) 
VALUES ( 4, 'Kyle', 28, 45000,'1993-05-16','2024-05-29 12:30:00.001','Desc'),
       ( 5, 'Katie', 35, 50000,'1996-05-16','2024-05-29 11:30:00.001','Desc');


SELECT Age, SUM(Salary) AS TotalSalary
FROM ExampleTable
GROUP BY Age
HAVING SUM(Salary) > 100000
ORDER BY TotalSalary DESC;

UPDATE ExampleTable
SET Salary = Salary * 1.1  
WHERE Age >= 30;
Select* from ExampleTable;

UPDATE ExampleTable
SET Description = 'Desc'
WHERE ID >3;
Select* from ExampleTable;

--bulk delete
DELETE FROM ExampleTable
WHERE Age < 30;

begin transaction;

update ExampleTable
set Salary = Salary - 15500 where ID = 5;

update ExampleTable set Salary = Salary - 400 where ID = 1;
update ExampleTable set Salary = Salary - 2120 where ID =3;
select * from ExampleTable;
commit transaction;
