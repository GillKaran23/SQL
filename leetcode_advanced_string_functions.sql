-- 1 Question
-- Table: Users
-- +----------------+---------+
-- | Column Name    | Type    |
-- +----------------+---------+
-- | user_id        | int     |
-- | name           | varchar |
-- +----------------+---------+
-- user_id is the primary key (column with unique values) for this table.
-- This table contains the ID and the name of the user. The name consists of only lowercase and uppercase characters.
-- Write a solution to fix the names so that only the first character is uppercase and the rest are lowercase.
-- Return the result table ordered by user_id.
SELECT user_id, CONCAT(UPPER(LEFT(name, 1)), LOWER(SUBSTRING(name, 2))) AS name FROM Users GROUP BY user_id ORDER BY user_id ASC;


-- 2 Question
-- Table: Patients
-- +--------------+---------+
-- | Column Name  | Type    |
-- +--------------+---------+
-- | patient_id   | int     |
-- | patient_name | varchar 
-- | conditions   | varchar |
-- +--------------+---------+
-- patient_id is the primary key (column with unique values) for this table.
-- 'conditions' contains 0 or more code separated by spaces. 
-- This table contains information of the patients in the hospital.
-- Write a solution to find the patient_id, patient_name, and conditions of the patients who have Type I Diabetes. Type I Diabetes always starts with DIAB1 prefix.
SELECT * FROM Patients WHERE conditions LIKE '% DIAB1%' OR conditions LIKE 'DIAB1%';


-- 3 Question
-- Table: Person
-- +-------------+---------+
-- | Column Name | Type    |
-- +-------------+---------+
-- | id          | int     |
-- | email       | varchar |
-- +-------------+---------+
-- id is the primary key (column with unique values) for this table.
-- Each row of this table contains an email. The emails will not contain uppercase letters.
-- Write a solution to delete all duplicate emails, keeping only one unique email with the smallest id.
-- For SQL users, please note that you are supposed to write a DELETE statement and not a SELECT one.
DELETE FROM Person
WHERE id NOT IN (
    SELECT id
    FROM (
        SELECT MIN(id) as id
        FROM Person
        GROUP BY email
    ) AS email
);


-- 4 Question
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
SELECT CASE WHEN COUNT(DISTINCT salary) < 2 THEN NULL ELSE (SELECT MAX(salary) FROM Employee WHERE salary < (SELECT MAX(salary) FROM Employee)) END AS SecondHighestSalary FROM Employee;


-- 5 Question
-- Table Activities:
-- +-------------+---------+
-- | Column Name | Type    |
-- +-------------+---------+
-- | sell_date   | date    |
-- | product     | varchar |
-- +-------------+---------+
-- There is no primary key (column with unique values) for this table. It may contain duplicates.
-- Each row of this table contains the product name and the date it was sold in a market.
-- Write a solution to find for each date the number of different products sold and their names.
-- The sold products names for each date should be sorted lexicographically.
-- Return the result table ordered by sell_date.
SELECT 
    A.sell_date, 
    COUNT(DISTINCT A.product) AS num_sold, 
    GROUP_CONCAT(DISTINCT A.product ORDER BY A.product SEPARATOR ',') AS products
FROM Activities AS A
GROUP BY A.sell_date
ORDER BY A.sell_date;


-- 6 Question
-- Table: Products
-- +------------------+---------+
-- | Column Name      | Type    |
-- +------------------+---------+
-- | product_id       | int     |
-- | product_name     | varchar |
-- | product_category | varchar |
-- +------------------+---------+
-- product_id is the primary key (column with unique values) for this table.
-- This table contains data about the company's products.
-- Table: Orders
-- +---------------+---------+
-- | Column Name   | Type    |
-- +---------------+---------+
-- | product_id    | int     |
-- | order_date    | date    |
-- | unit          | int     |
-- +---------------+---------+
-- This table may have duplicate rows.
-- product_id is a foreign key (reference column) to the Products table.
-- unit is the number of products ordered in order_date.
-- Write a solution to get the names of products that have at least 100 units ordered in February 2020 and their amount.
SELECT A.product_name, SUM(B.unit) AS unit 
FROM Products AS A 
JOIN Orders AS B ON A.product_id = B.product_id 
WHERE B.order_date LIKE '2020-02-%' 
GROUP BY A.product_name 
HAVING SUM(B.unit) >= 100;


-- 7 Question
-- Table: Users
-- +---------------+---------+
-- | Column Name   | Type    |
-- +---------------+---------+
-- | user_id       | int     |
-- | name          | varchar |
-- | mail          | varchar |
-- +---------------+---------+
-- user_id is the primary key (column with unique values) for this table.
-- This table contains information of the users signed up in a website. Some e-mails are invalid.
-- Write a solution to find the users who have valid emails.
-- A valid e-mail has a prefix name and a domain where:
-- The prefix name is a string that may contain letters (upper or lower case), digits, underscore '_', period '.', and/or dash '-'. The prefix name must start with a letter.
-- The domain is '@leetcode.com'.
SELECT * FROM Users WHERE mail REGEXP '^[A-Za-z][A-Za-z0-9._-]*@leetcode\\.com$';