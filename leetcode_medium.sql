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