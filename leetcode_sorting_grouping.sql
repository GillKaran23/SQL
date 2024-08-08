-- 1 Question
-- Table: Teacher
-- +-------------+------+
-- | Column Name | Type |
-- +-------------+------+
-- | teacher_id  | int  |
-- | subject_id  | int  |
-- | dept_id     | int  |
-- +-------------+------+
-- (subject_id, dept_id) is the primary key (combinations of columns with unique values) of this table.
-- Each row in this table indicates that the teacher with teacher_id teaches the subject subject_id in the department dept_id.
-- Write a solution to calculate the number of unique subjects each teacher teaches in the university.
SELECT teacher_id, COUNT(DISTINCT subject_id) AS cnt FROM Teacher GROUP BY teacher_id;


-- 2 Question
-- Table: Activity
-- +---------------+---------+
-- | Column Name   | Type    |
-- +---------------+---------+
-- | user_id       | int     |
-- | session_id    | int     |
-- | activity_date | date    |
-- | activity_type | enum    |
-- +---------------+---------+
-- This table may have duplicate rows.
-- The activity_type column is an ENUM (category) of type ('open_session', 'end_session', 'scroll_down', 'send_message').
-- The table shows the user activities for a social media website. 
-- Note that each session belongs to exactly one user.
-- Write a solution to find the daily active user count for a period of 30 days ending 2019-07-27 inclusively. A user was active on someday if they made at least one activity on that day.
SELECT 
    activity_date AS day,
    COUNT(DISTINCT user_id) AS active_users
FROM 
    Activity
WHERE 
    activity_date BETWEEN DATE('2019-06-28') AND DATE('2019-07-27')
GROUP BY 
    activity_date
ORDER BY 
    activity_date;


-- 3 Question
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


-- 4 Question
-- Table: Courses
-- +-------------+---------+
-- | Column Name | Type    |
-- +-------------+---------+
-- | student     | varchar |
-- | class       | varchar |
-- +-------------+---------+
-- (student, class) is the primary key (combination of columns with unique values) for this table.
-- Each row of this table indicates the name of a student and the class in which they are enrolled.
-- Write a solution to find all the classes that have at least five students.
SELECT class FROM Courses GROUP BY class HAVING COUNT(*) >= 5;


-- 5 Question
-- Table: Followers
-- +-------------+------+
-- | Column Name | Type |
-- +-------------+------+
-- | user_id     | int  |
-- | follower_id | int  |
-- +-------------+------+
-- (user_id, follower_id) is the primary key (combination of columns with unique values) for this table.
-- This table contains the IDs of a user and a follower in a social media app where the follower follows the user.
-- Write a solution that will, for each user, return the number of followers.
-- Return the result table ordered by user_id in ascending order.
SELECT user_id, COUNT(follower_id) AS followers_count FROM Followers GROUP BY user_id ORDER BY (user_id) ASC;


-- 6 Question
-- Table: MyNumbers
-- +-------------+------+
-- | Column Name | Type |
-- +-------------+------+
-- | num         | int  |
-- +-------------+------+
-- This table may contain duplicates (In other words, there is no primary key for this table in SQL).
-- Each row of this table contains an integer.
-- A single number is a number that appeared only once in the MyNumbers table.
-- Find the largest single number. If there is no single number, report null.
SELECT 
    CASE 
        WHEN EXISTS (
            SELECT num 
            FROM MyNumbers 
            GROUP BY num 
            HAVING COUNT(num) = 1
        ) THEN (
            SELECT num 
            FROM MyNumbers 
            GROUP BY num 
            HAVING COUNT(num) = 1 
            ORDER BY num DESC 
            LIMIT 1
        )
        ELSE null
    END AS num;


-- 7 Question
-- Table: Customer
-- +-------------+---------+
-- | Column Name | Type    |
-- +-------------+---------+
-- | customer_id | int     |
-- | product_key | int     |
-- +-------------+---------+
-- This table may contain duplicates rows. 
-- customer_id is not NULL.
-- product_key is a foreign key (reference column) to Product table.
-- Table: Product
-- +-------------+---------+
-- | Column Name | Type    |
-- +-------------+---------+
-- | product_key | int     |
-- +-------------+---------+
-- product_key is the primary key (column with unique values) for this table.
-- Write a solution to report the customer ids from the Customer table that bought all the products in the Product table.
-- Return the result table in any order.
SELECT customer_id FROM customer GROUP BY customer_id HAVING Count(DISTINCT product_key) = (SELECT Count(DISTINCT product_key) AS total_product FROM product);