-- 1 Question
-- Table: Employees
-- +---------------+---------+
-- | Column Name   | Type    |
-- +---------------+---------+
-- | id            | int     |
-- | name          | varchar |
-- +---------------+---------+
-- id is the primary key (column with unique values) for this table.
-- Each row of this table contains the id and the name of an employee in a company.
-- Table: EmployeeUNI
-- +---------------+---------+
-- | Column Name   | Type    |
-- +---------------+---------+
-- | id            | int     |
-- | unique_id     | int     |
-- +---------------+---------+
-- (id, unique_id) is the primary key (combination of columns with unique values) for this table.
-- Each row of this table contains the id and the corresponding unique id of an employee in the company.
-- Write a solution to show the unique ID of each user, If a user does not have a unique ID replace just show null.
SELECT CASE WHEN B.id IS NULL THEN NULL ELSE B.unique_id END AS unique_id, A.name FROM Employees AS A LEFT JOIN  EmployeeUNI AS B ON A.id = B.id;



-- 2 Question
-- Table: Sales
-- +-------------+-------+
-- | Column Name | Type  |
-- +-------------+-------+
-- | sale_id     | int   |
-- | product_id  | int   |
-- | year        | int   |
-- | quantity    | int   |
-- | price       | int   |
-- +-------------+-------+
-- (sale_id, year) is the primary key (combination of columns with unique values) of this table.
-- product_id is a foreign key (reference column) to Product table.
-- Each row of this table shows a sale on the product product_id in a certain year.
-- Note that the price is per unit.
-- Table: Product
-- +--------------+---------+
-- | Column Name  | Type    |
-- +--------------+---------+
-- | product_id   | int     |
-- | product_name | varchar |
-- +--------------+---------+
-- product_id is the primary key (column with unique values) of this table.
-- Each row of this table indicates the product name of each product.
-- Write a solution to report the product_name, year, and price for each sale_id in the Sales table.
SELECT B.product_name, A.year, A.price FROM Sales AS A INNER JOIN Product AS B ON A.product_id = B.product_id;



-- 3 Question
-- Table: Visits
-- +-------------+---------+
-- | Column Name | Type    |
-- +-------------+---------+
-- | visit_id    | int     |
-- | customer_id | int     |
-- +-------------+---------+
-- visit_id is the column with unique values for this table.
-- This table contains information about the customers who visited the mall.
-- Table: Transactions
-- +----------------+---------+
-- | Column Name    | Type    |
-- +----------------+---------+
-- | transaction_id | int     |
-- | visit_id       | int     |
-- | amount         | int     |
-- +----------------+---------+
-- transaction_id is column with unique values for this table.
-- This table contains information about the transactions made during the visit_id.
-- Write a solution to find the IDs of the users who visited without making any transactions and the number of times they made these types of visits.
SELECT A.customer_id, COUNT(*) AS count_no_trans FROM Visits A
LEFT JOIN Transactions B ON A.visit_id = B.visit_id
WHERE B.transaction_id IS NULL
GROUP BY A.customer_id;



-- 4 Question
-- Table: Weather
-- +---------------+---------+
-- | Column Name   | Type    |
-- +---------------+---------+
-- | id            | int     |
-- | recordDate    | date    |
-- | temperature   | int     |
-- +---------------+---------+
-- id is the column with unique values for this table.
-- There are no different rows with the same recordDate.
-- This table contains information about the temperature on a certain day.
-- Write a solution to find all dates' Id with higher temperatures compared to its previous dates (yesterday).
SELECT w1.id
FROM Weather w1
JOIN Weather w2
ON w1.recordDate = DATE_ADD(w2.recordDate, INTERVAL 1 DAY)
WHERE w1.temperature > w2.temperature;



-- 5 Question
-- Table: Activity
-- +----------------+---------+
-- | Column Name    | Type    |
-- +----------------+---------+
-- | machine_id     | int     |
-- | process_id     | int     |
-- | activity_type  | enum    |
-- | timestamp      | float   |
-- +----------------+---------+
-- The table shows the user activities for a factory website.
-- (machine_id, process_id, activity_type) is the primary key (combination of columns with unique values) of this table.
-- machine_id is the ID of a machine.
-- process_id is the ID of a process running on the machine with ID machine_id.
-- activity_type is an ENUM (category) of type ('start', 'end').
-- timestamp is a float representing the current time in seconds.
-- 'start' means the machine starts the process at the given timestamp and 'end' means the machine ends the process at the given timestamp.
-- The 'start' timestamp will always be before the 'end' timestamp for every (machine_id, process_id) pair
-- There is a factory website that has several machines each running the same number of processes. Write a solution to find the average time each machine takes to complete a process.
-- The time to complete a process is the 'end' timestamp minus the 'start' timestamp. The average time is calculated by the total time to complete every process on the machine divided by the number of processes that were run.
-- The resulting table should have the machine_id along with the average time as processing_time, which should be rounded to 3 decimal places.
WITH ProcessTimes AS (
    SELECT 
        machine_id,
        process_id,
        MAX(CASE WHEN activity_type = 'end' THEN timestamp ELSE NULL END) - 
        MIN(CASE WHEN activity_type = 'start' THEN timestamp ELSE NULL END) AS processing_time
    FROM Activity
    GROUP BY machine_id, process_id
),
MachineAverageTimes AS (
    SELECT 
        machine_id,
        AVG(processing_time) AS avg_processing_time
    FROM ProcessTimes
    GROUP BY machine_id
)
SELECT 
    machine_id,
    ROUND(avg_processing_time, 3) AS processing_time
FROM MachineAverageTimes;


-- 6 Question
-- Table: Employee
-- +-------------+---------+
-- | Column Name | Type    |
-- +-------------+---------+
-- | empId       | int     |
-- | name        | varchar |
-- | supervisor  | int     |
-- | salary      | int     |
-- +-------------+---------+
-- empId is the column with unique values for this table.
-- Each row of this table indicates the name and the ID of an employee in addition to their salary and the id of their manager.
-- Table: Bonus
-- +-------------+------+
-- | Column Name | Type |
-- +-------------+------+
-- | empId       | int  |
-- | bonus       | int  |
-- +-------------+------+
-- empId is the column of unique values for this table.
-- empId is a foreign key (reference column) to empId from the Employee table.
-- Each row of this table contains the id of an employee and their respective bonus.
-- Write a solution to report the name and bonus amount of each employee with a bonus less than 1000.
-- SELECT A.name, B.bonus 
FROM Employee AS A 
LEFT JOIN Bonus AS B 
ON A.empId = B.empId 
WHERE B.empId IS NULL OR B.bonus < 1000;


-- 7 Question
-- Table: Students
-- +---------------+---------+
-- | Column Name   | Type    |
-- +---------------+---------+
-- | student_id    | int     |
-- | student_name  | varchar |
-- +---------------+---------+
-- student_id is the primary key (column with unique values) for this table.
-- Each row of this table contains the ID and the name of one student in the school.
-- Table: Subjects
-- +--------------+---------+
-- | Column Name  | Type    |
-- +--------------+---------+
-- | subject_name | varchar |
-- +--------------+---------+
-- subject_name is the primary key (column with unique values) for this table.
-- Each row of this table contains the name of one subject in the school.
-- Table: Examinations
-- +--------------+---------+
-- | Column Name  | Type    |
-- +--------------+---------+
-- | student_id   | int     |
-- | subject_name | varchar |
-- +--------------+---------+
-- There is no primary key (column with unique values) for this table. It may contain duplicates.
-- Each student from the Students table takes every course from the Subjects table.
-- Each row of this table indicates that a student with ID student_id attended the exam of subject_name.
-- Write a solution to find the number of times each student attended each exam.
-- Return the result table ordered by student_id and subject_name.
SELECT A.student_id, 
       A.student_name, 
       B.subject_name, 
       Count(C.subject_name) AS attended_exams 
FROM   Students AS A 
       CROSS JOIN Subjects AS B 
       LEFT JOIN Examinations AS C 
              ON A.student_id = C.student_id 
                 AND B.subject_name = C.subject_name 
GROUP  BY A.student_id, 
          B.subject_name
ORDER  BY A.student_id, 
          B.subject_name;


