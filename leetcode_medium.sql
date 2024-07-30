-- Table: Employee
-- +-------------+------+
-- | Column Name | Type |
-- +-------------+------+
-- | id          | int  |
-- | salary      | int  |
-- +-------------+------+
-- id is the primary key (column with unique values) for this table.
-- Each row of this table contains information about the salary of an employee.
-- Write a solution to find the second highest salary from the Employee table. If there is no second highest salary, return null (return None in Pandas).
SELECT 
    CASE 
        WHEN COUNT(DISTINCT salary) < 2 THEN NULL 
    ELSE (SELECT MAX(marks) FROM Students WHERE marks < (SELECT MAX(marks) FROM Students)) 
    END AS SecondHighestSalary 
FROM Students;


-- Consider P1(a,b) and p2(c,d) to be two points on a 2D plane.
-- a happens to equal the minimum value in Northern Latitude (LAT_N in STATION).
-- b happens to equal the minimum value in Western Longitude (LONG_W in STATION).
-- c happens to equal the maximum value in Northern Latitude (LAT_N in STATION).
-- d happens to equal the maximum value in Western Longitude (LONG_W in STATION).
-- Query the Manhattan Distance between points P1 and P2 and round it to a scale of 4 decimal places.
SELECT 
    ROUND(
        ABS(MAX(LAT_N) - MIN(LAT_N)) + ABS(MAX(LONG_W) - MIN(LONG_W)), 
        4
    ) AS manhattan_distance
FROM STATION;