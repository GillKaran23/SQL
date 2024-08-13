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
) movie_ratings