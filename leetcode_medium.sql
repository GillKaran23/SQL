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
-- Write a solution to select the product id, year, quantity, and price for the first year of every product sold.
SELECT 
    A.product_id, 
    A.year AS first_year, 
    A.quantity, 
    A.price 
FROM 
    Sales AS A
JOIN 
    (SELECT product_id, MIN(year) AS first_year 
     FROM Sales 
     GROUP BY product_id) AS B 
ON A.product_id = B.product_id AND A.year = B.first_year;


-- Table: Scores
-- +-------------+---------+
-- | Column Name | Type    |
-- +-------------+---------+
-- | id          | int     |
-- | score       | decimal |
-- +-------------+---------+
-- id is the primary key (column with unique values) for this table.
-- Each row of this table contains the score of a game. Score is a floating point value with two decimal places.
-- Write a solution to find the rank of the scores. The ranking should be calculated according to the following rules:
-- The scores should be ranked from the highest to the lowest.
-- If there is a tie between two scores, both should have the same ranking.
-- After a tie, the next ranking number should be the next consecutive integer value. In other words, there should be no holes between ranks.
-- Return the result table ordered by score in descending order.
SELECT score, DENSE_RANK() OVER (ORDER BY score DESC) AS 'rank' FROM Scores ORDER BY score DESC;


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


-- Table: Stocks
-- +---------------+---------+
-- | Column Name   | Type    |
-- +---------------+---------+
-- | stock_name    | varchar |
-- | operation     | enum    |
-- | operation_day | int     |
-- | price         | int     |
-- +---------------+---------+
-- (stock_name, operation_day) is the primary key (combination of columns with unique values) for this table.
-- The operation column is an ENUM (category) of type ('Sell', 'Buy')
-- Each row of this table indicates that the stock which has stock_name had an operation on the day operation_day with the price.
-- It is guaranteed that each 'Sell' operation for a stock has a corresponding 'Buy' operation in a previous day. It is also guaranteed that each 'Buy' operation for a stock has a corresponding 'Sell' operation in an upcoming day.
-- Write a solution to report the Capital gain/loss for each stock.
-- The Capital gain/loss of a stock is the total gain or loss after buying and selling the stock one or many times.
SELECT stock_name,
       SUM(CASE WHEN operation = 'Sell' THEN price ELSE 0 END) -
       SUM(CASE WHEN operation = 'Buy' THEN price ELSE 0 END) AS capital_gain_loss
FROM Stocks
GROUP BY stock_name;


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
-- departmentId is a foreign key (reference columns) of the ID from the Department table.
-- Each row of this table indicates the ID, name, and salary of an employee. It also contains the ID of their department.
-- Table: Department
-- +-------------+---------+
-- | Column Name | Type    |
-- +-------------+---------+
-- | id          | int     |
-- | name        | varchar |
-- +-------------+---------+
-- id is the primary key (column with unique values) for this table. It is guaranteed that department name is not NULL.
-- Each row of this table indicates the ID of a department and its name.
-- Write a solution to find employees who have the highest salary in each of the departments.
SELECT A.name AS Department, B.name AS Employee, salary AS Salary FROM Department A 
JOIN Employee B
ON B.departmentId = A.id
WHERE (B.Salary, B.DepartmentId) IN (SELECT MAX(B.Salary), B.DepartmentId 
FROM Employee B GROUP BY B.DepartmentId);


-- Table: Tree
-- +-------------+------+
-- | Column Name | Type |
-- +-------------+------+
-- | id          | int  |
-- | p_id        | int  |
-- +-------------+------+
-- id is the column with unique values for this table.
-- Each row of this table contains information about the id of a node and the id of its parent node in a tree.
-- The given structure is always a valid tree.
-- Each node in the tree can be one of three types:
-- "Leaf": if the node is a leaf node.
-- "Root": if the node is the root of the tree.
-- "Inner": If the node is neither a leaf node nor a root node.
-- Write a solution to report the type of each node in the tree.
SELECT
id,
CASE
WHEN p_id IS NULL THEN 'Root'
WHEN p_id IS NOT NULL AND id IN (SELECT DISTINCT p_id FROM tree) THEN 'Inner'
ELSE 'Leaf' END AS Type
FROM tree;


-- Table: transactions
-- +------------------+------+
-- | Column Name      | Type | 
-- +------------------+------+
-- | transaction_id   | int  |
-- | amount           | int  |
-- | transaction_date | date |
-- +------------------+------+
-- The transactions_id column uniquely identifies each row in this table.
-- Each row of this table contains the transaction id, amount and transaction date.
-- Write a solution to find the sum of amounts for odd and even transactions for each day. If there are no odd or even transactions for a specific date, display as 0.
-- Return the result table ordered by transaction_date in ascending order.
SELECT
    transaction_date,
    SUM(IF(amount % 2 = 1, amount, 0)) AS odd_sum,
    SUM(IF(amount % 2 = 0, amount, 0)) AS even_sum
FROM transactions
GROUP BY transaction_date
ORDER BY transaction_date;


-- Table: Users
-- +----------------+---------+
-- | Column Name    | Type    |
-- +----------------+---------+
-- | user_id        | int     |
-- | join_date      | date    |
-- | favorite_brand | varchar |
-- +----------------+---------+
-- user_id is the primary key (column with unique values) of this table.
-- This table has the info of the users of an online shopping website where users can sell and buy items.
-- Table: Orders
-- +---------------+---------+
-- | Column Name   | Type    |
-- +---------------+---------+
-- | order_id      | int     |
-- | order_date    | date    |
-- | item_id       | int     |
-- | buyer_id      | int     |
-- | seller_id     | int     |
-- +---------------+---------+
-- order_id is the primary key (column with unique values) of this table.
-- item_id is a foreign key (reference column) to the Items table.
-- buyer_id and seller_id are foreign keys to the Users table.
-- Table: Items
-- +---------------+---------+
-- | Column Name   | Type    |
-- +---------------+---------+
-- | item_id       | int     |
-- | item_brand    | varchar |
-- +---------------+---------+
-- item_id is the primary key (column with unique values) of this table.
-- Write a solution to find for each user, the join date and the number of orders they made as a buyer in 2019.
SELECT A.user_id AS buyer_id,
       A.join_date,
       count(B.order_id) AS orders_in_2019
FROM Users AS A
LEFT JOIN Orders B ON A.user_id = B.buyer_id
    AND B.order_date LIKE '%2019%'
GROUP BY A.user_id, A.join_date
ORDER BY A.user_id;


-- Table: Employee
-- +-------------+------+
-- | Column Name | Type |
-- +-------------+------+
-- | id          | int  |
-- | salary      | int  |
-- +-------------+------+
-- id is the primary key (column with unique values) for this table.
-- Each row of this table contains information about the salary of an employee.
-- Write a solution to find the nth highest salary from the Employee table. If there is no nth highest salary, return null.
CREATE FUNCTION getNthHighestSalary(N INT) RETURNS INT
BEGIN
DECLARE M INT;
SET M = N - 1;
  RETURN (
      SELECT DISTINCT Salary FROM Employee ORDER by Salary DESC LIMIT M, 1
  );
END