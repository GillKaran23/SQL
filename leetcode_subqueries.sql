-- 1 Question
-- Table: Employees
-- +-------------+----------+
-- | Column Name | Type     |
-- +-------------+----------+
-- | employee_id | int      |
-- | name        | varchar  |
-- | manager_id  | int      |
-- | salary      | int      |
-- +-------------+----------+
-- In SQL, employee_id is the primary key for this table.
-- This table contains information about the employees, their salary, and the ID of their manager. Some employees do not have a manager (manager_id is null). 
-- Find the IDs of the employees whose salary is strictly less than $30000 and whose manager left the company. When a manager leaves the company, their information is deleted from the Employees table, but the reports still have their manager_id set to the manager that left.
-- Return the result table ordered by employee_id.
SELECT employee_id FROM Employees WHERE manager_id NOT IN(SELECT employee_id FROM Employees) AND salary<30000 ORDER BY employee_id;


-- 2 Question
-- Table: Seat
-- +-------------+---------+
-- | Column Name | Type    |
-- +-------------+---------+
-- | id          | int     |
-- | student     | varchar |
-- +-------------+---------+
-- id is the primary key (unique value) column for this table.
-- Each row of this table indicates the name and the ID of a student.
-- id is a continuous increment.
-- Write a solution to swap the seat id of every two consecutive students. If the number of students is odd, the id of the last student is not swapped.
-- Return the result table ordered by id in ascending order.
SELECT ( CASE
            WHEN id%2 != 0 AND id != counts THEN id+1
            WHEN id%2 != 0 AND id = counts THEN id
            ELSE id-1
        END) AS id, student
FROM seat, (select count(*) as counts from seat) 
AS seat_counts
ORDER BY id ASC


-- 3 Question
-- Table: Movies
-- +---------------+---------+
-- | Column Name   | Type    |
-- +---------------+---------+
-- | movie_id      | int     |
-- | title         | varchar |
-- +---------------+---------+
-- movie_id is the primary key (column with unique values) for this table.
-- title is the name of the movie.
-- Table: Users
-- +---------------+---------+
-- | Column Name   | Type    |
-- +---------------+---------+
-- | user_id       | int     |
-- | name          | varchar |
-- +---------------+---------+
-- user_id is the primary key (column with unique values) for this table.
-- Table: MovieRating
-- +---------------+---------+
-- | Column Name   | Type    |
-- +---------------+---------+
-- | movie_id      | int     |
-- | user_id       | int     |
-- | rating        | int     |
-- | created_at    | date    |
-- +---------------+---------+
-- (movie_id, user_id) is the primary key (column with unique values) for this table.
-- This table contains the rating of a movie by a user in their review.
-- created_at is the user's review date. 
-- Write a solution to:
-- Find the name of the user who has rated the greatest number of movies. In case of a tie, return the lexicographically smaller user name.
-- Find the movie name with the highest average rating in February 2020. In case of a tie, return the lexicographically smaller movie name.
SELECT results
FROM (
  SELECT B.name AS results
  FROM MovieRating AS A
  JOIN users AS B ON A.user_id = B.user_id
  GROUP BY B.name
  ORDER BY COUNT(A.rating) DESC, name
  LIMIT 1 
  ) AS ratings
UNION ALL
SELECT results 
FROM (
  SELECT C.title AS results
  FROM MovieRating D
  JOIN Movies AS C ON D.movie_id = C.movie_id 
  WHERE DATE_FORMAT(D.created_at, "%Y-%m") = '2020-02'
  GROUP BY C.title
  ORDER BY AVG(D.rating) DESC, C.title 
  LIMIT 1
) movie_ratings;


-- 4 Question
-- Table: Customer
-- +---------------+---------+
-- | Column Name   | Type    |
-- +---------------+---------+
-- | customer_id   | int     |
-- | name          | varchar |
-- | visited_on    | date    |
-- | amount        | int     |
-- +---------------+---------+
-- In SQL,(customer_id, visited_on) is the primary key for this table.
-- This table contains data about customer transactions in a restaurant.
-- visited_on is the date on which the customer with ID (customer_id) has visited the restaurant.
-- amount is the total paid by a customer.
-- You are the restaurant owner and you want to analyze a possible expansion (there will be at least one customer every day).
-- Compute the moving average of how much the customer paid in a seven days window (i.e., current day + 6 days before). average_amount should be rounded to two decimal places.
-- Return the result table ordered by visited_on in ascending order.
SELECT A.visited_on, 
    SUM(B.amount) amount,
    ROUND(SUM(B.amount)/7,2) average_amount
FROM (SELECT visited_on, SUM(amount) amount FROM Customer GROUP BY visited_on) A, 
    (SELECT visited_on, SUM(amount) amount FROM Customer GROUP BY visited_on) B 
WHERE DATEDIFF(A.visited_on, B.visited_on) BETWEEN 0 AND 6
GROUP BY A.visited_on
HAVING COUNT(DISTINCT B.visited_on) = 7;


-- 5 Question
-- Table: RequestAccepted
-- +----------------+---------+
-- | Column Name    | Type    |
-- +----------------+---------+
-- | requester_id   | int     |
-- | accepter_id    | int     |
-- | accept_date    | date    |
-- +----------------+---------+
-- (requester_id, accepter_id) is the primary key (combination of columns with unique values) for this table.
-- This table contains the ID of the user who sent the request, the ID of the user who received the request, and the date when the request was accepted.
-- Write a solution to find the people who have the most friends and the most friends number.
-- The test cases are generated so that only one person has the most friends.
SELECT id,
       Count(id) AS num
FROM   (SELECT requester_id AS id
        FROM RequestAccepted
        UNION ALL
        SELECT accepter_id
        FROM RequestAccepted) ppl
GROUP  BY id
ORDER  BY Count(id) DESC
LIMIT  1;


-- 6 Question
-- Table: Insurance
-- +-------------+-------+
-- | Column Name | Type  |
-- +-------------+-------+
-- | pid         | int   |
-- | tiv_2015    | float |
-- | tiv_2016    | float |
-- | lat         | float |
-- | lon         | float |
-- +-------------+-------+
-- pid is the primary key (column with unique values) for this table.
-- Each row of this table contains information about one policy where:
-- pid is the policyholder's policy ID.
-- tiv_2015 is the total investment value in 2015 and tiv_2016 is the total investment value in 2016.
-- lat is the latitude of the policy holder's city. It's guaranteed that lat is not NULL.
-- lon is the longitude of the policy holder's city. It's guaranteed that lon is not NULL.
-- Write a solution to report the sum of all total investment values in 2016 tiv_2016, for all policyholders who:
-- have the same tiv_2015 value as one or more other policyholders, and
-- are not located in the same city as any other policyholder (i.e., the (lat, lon) attribute pairs must be unique).
-- Round tiv_2016 to two decimal places.
SELECT ROUND(SUM(tiv_2016),2) AS tiv_2016
FROM insurance
WHERE tiv_2015 IN
(
  SELECT tiv_2015 
  FROM insurance
  GROUP BY 1
  HAVING COUNT(*) > 1
) AND CONCAT(lat, lon) IN
(
  SELECT CONCAT(lat, lon) 
  FROM insurance
  GROUP BY lat, lon
  HAVING COUNT(*) = 1
);


-- 7 Question
-- Table: Employee
-- +--------------+---------+
-- | Column Name  | Type    |
-- +--------------+---------+
-- | id           | int     |
-- | name         | varchar |
-- | salary       | int     |
-- | departmentId | int     |
-- +--------------+---------+
-- id is the primary key (column with unique values) for this table.
-- departmentId is a foreign key (reference column) of the ID from the Department table.
-- Each row of this table indicates the ID, name, and salary of an employee. It also contains the ID of their department.
-- Table: Department
-- +-------------+---------+
-- | Column Name | Type    |
-- +-------------+---------+
-- | id          | int     |
-- | name        | varchar |
-- +-------------+---------+
-- id is the primary key (column with unique values) for this table.
-- Each row of this table indicates the ID of a department and its name.
-- A company's executives are interested in seeing who earns the most money in each of the company's departments. A high earner in a department is an employee who has a salary in the top three unique salaries for that department.
-- Write a solution to find the employees who are high earners in each of the departments.
-- Return the result table in any order.
SELECT B.name AS Department, A.name AS Employee, A.salary AS Salary
FROM Employee AS A 
INNER JOIN Department AS B ON A.departmentId = B.id
WHERE (
    SELECT COUNT(DISTINCT C.salary) 
    FROM Employee AS C
    WHERE C.departmentId = A.departmentId AND C.salary > A.salary
) < 3;