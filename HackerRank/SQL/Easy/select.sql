-- Query all columns for all American cities in the CITY table with populations larger than 100000. The CountryCode for America is USA.
SELECT * FROM CITY WHERE COUNTRYCODE = "USA" AND POPULATION > 100000;


-- Query the NAME field for all American cities in the CITY table with populations larger than 120000. The CountryCode for America is USA.
SELECT NAME FROM CITY WHERE POPULATION > 120000 AND COUNTRYCODE = "USA";


-- Query all columns (attributes) for every row in the CITY table.
SELECT * FROM CITY;


-- Query all columns for a city in CITY with the ID 1661.
SELECT * FROM CITY WHERE ID = 1661;


-- Query all attributes of every Japanese city in the CITY table. The COUNTRYCODE for Japan is JPN.
SELECT * FROM CITY WHERE COUNTRYCODE = "JPN";


-- Query the names of all the Japanese cities in the CITY table. The COUNTRYCODE for Japan is JPN.
SELECT NAME FROM CITY WHERE COUNTRYCODE = "JPN";


-- Query a list of CITY and STATE from the STATION table.
SELECT CITY , STATE FROM STATION;


-- Query a list of CITY names from STATION for cities that have an even ID number. Print the results in any order, but exclude duplicates from the answer.
SELECT DISTINCT CITY FROM STATION WHERE ID%2 = 0;


-- Find the difference between the total number of CITY entries in the table and the number of distinct CITY entries in the table.
SELECT (COUNT(CITY) - COUNT(DISTINCT CITY)) AS diff FROM STATION;


-- Query the two cities in STATION with the shortest and longest CITY names, as well as their respective lengths (i.e.: number of characters in the name). If there is more than one smallest or largest city, choose the one that comes first when ordered alphabetically.
SELECT CITY, LENGTH(CITY) FROM STATION ORDER BY LENGTH(CITY) ASC, CITY ASC LIMIT 1;
SELECT CITY, LENGTH(CITY) FROM STATION ORDER BY LENGTH(CITY) DESC, CITY ASC LIMIT 1;


-- Query the list of CITY names starting with vowels (i.e., a, e, i, o, or u) from STATION. Your result cannot contain duplicates.
SELECT DISTINCT CITY FROM STATION WHERE CITY LIKE "A%" OR CITY LIKE "E%" OR CITY LIKE "I%" OR CITY LIKE "O%" OR CITY LIKE "U%";


-- Query the list of CITY names ending with vowels (a, e, i, o, u) from STATION. Your result cannot contain duplicates.
SELECT DISTINCT CITY FROM STATION WHERE CITY LIKE "%A" OR CITY LIKE "%E" OR CITY LIKE "%I" OR CITY LIKE "%O" OR CITY LIKE "%U"


-- Query the list of CITY names from STATION which have vowels (i.e., a, e, i, o, and u) as both their first and last characters. Your result cannot contain duplicates.
SELECT DISTINCT CITY FROM STATION WHERE CITY LIKE "A%A" OR CITY LIKE "A%E" OR CITY LIKE "A%I" OR CITY LIKE "A%O" OR CITY LIKE "A%U" OR CITY LIKE "E%A" OR CITY LIKE "E%E" OR CITY LIKE "E%I" OR CITY LIKE "E%O" OR CITY LIKE "E%U" OR CITY LIKE "I%A" OR CITY LIKE "I%E" OR CITY LIKE "I%I" OR CITY LIKE "I%O" OR CITY LIKE "I%U" OR CITY LIKE "O%A" OR CITY LIKE "O%E" OR CITY LIKE "O%I" OR CITY LIKE "O%O" OR CITY LIKE "U%U" OR CITY LIKE "U%A" OR CITY LIKE "U%E" OR CITY LIKE "U%I" OR CITY LIKE "U%O" OR CITY LIKE "U%U";


-- Query the list of CITY names from STATION that do not start with vowels. Your result cannot contain duplicates.
SELECT DISTINCT CITY FROM STATION WHERE CITY NOT LIKE "A%" AND CITY NOT LIKE "E%" AND CITY NOT LIKE "I%" AND CITY NOT LIKE "O%" AND CITY NOT LIKE "U%"


-- Query the list of CITY names from STATION that do not end with vowels. Your result cannot contain duplicates.
SELECT DISTINCT CITY FROM STATION WHERE CITY NOT LIKE "%A" AND CITY NOT LIKE "%E" AND CITY NOT LIKE "%I" AND CITY NOT LIKE "%O" AND CITY NOT LIKE "%U"


-- Query the list of CITY names from STATION that either do not start with vowels or do not end with vowels. Your result cannot contain duplicates.
SELECT DISTINCT CITY FROM STATION WHERE CITY NOT LIKE "A%A" AND CITY NOT LIKE "A%E" AND CITY NOT LIKE "A%I" AND CITY NOT LIKE "A%O" AND CITY NOT LIKE "A%U" AND CITY NOT LIKE "E%A" AND CITY NOT LIKE "E%E" AND CITY NOT LIKE "E%I" AND CITY NOT LIKE "E%O" AND CITY NOT LIKE "E%U" AND CITY NOT LIKE "I%A" AND CITY NOT LIKE "I%E" AND CITY NOT LIKE "I%I" AND CITY NOT LIKE "I%O" AND CITY NOT LIKE "I%U" AND CITY NOT LIKE "O%A" AND CITY NOT LIKE "O%E" AND CITY NOT LIKE "O%I" AND CITY NOT LIKE "O%O" AND CITY NOT LIKE "U%U" AND CITY NOT LIKE "U%A" AND CITY NOT LIKE "U%E" AND CITY NOT LIKE "U%I" AND CITY NOT LIKE "U%O" AND CITY NOT LIKE "U%U";


-- Query the list of CITY names from STATION that do not start with vowels and do not end with vowels. Your result cannot contain duplicates.
SELECT DISTINCT CITY FROM STATION WHERE CITY NOT LIKE "A%" AND CITY NOT LIKE "E%" AND CITY NOT LIKE "I%" AND CITY NOT LIKE "O%" AND CITY NOT LIKE "U%" AND CITY NOT LIKE "%A" AND CITY NOT LIKE "%E" AND CITY NOT LIKE "%I" AND CITY NOT LIKE "%O" AND CITY NOT LIKE "%U";


-- Query the Name of any student in STUDENTS who scored higher than  Marks. Order your output by the last three characters of each name. If two or more students both have names ending in the same last three characters (i.e.: Bobby, Robby, etc.), secondary sort them by ascending ID.
SELECT Name FROM STUDENTS WHERE Marks > 75 ORDER BY SUBSTRING(Name, -3), ID;


-- Write a query that prints a list of employee names (i.e.: the name attribute) from the Employee table in alphabetical order.
SELECT name FROM EMPLOYEE ORDER BY name;


-- Write a query that prints a list of employee names (i.e.: the name attribute) for employees in Employee having a salary greater than  per month who have been employees for less than  months. Sort your result by ascending employee_id.
SELECT name FROM Employee WHERE salary > 2000 AND months < 10 ORDER BY employee_id ASC;





-- Advance SELECT


-- Write a query identifying the type of each record in the TRIANGLES table using its three side lengths. Output one of the following statements for each record in the table:
-- Equilateral: It's a triangle with 3 sides of equal length.
-- Isosceles: It's a triangle with 2 sides of equal length.
-- Scalene: It's a triangle with 2 sides of differing lengths.
-- Not A Triangle: The given values of A, B, and C don't form a triangle.
SELECT
    CASE 
        WHEN A + B <= C OR A + C <= B OR B + C <= A THEN 'Not A Triangle'
        WHEN A = B AND B = C THEN 'Equilateral'
        WHEN A = B OR B = C OR C = A THEN 'Isosceles'
        ELSE 'Scalene' 
    END AS Type 
FROM TRIANGLES;


-- Query a count of the number of cities in CITY having a Population larger than 100,000.
SELECT COUNT(*) AS count_city FROM CITY WHERE POPULATION > 100000;


-- Query the total population of all cities in CITY where District is California.
SELECT SUM(POPULATION) FROM CITY WHERE DISTRICT = "California";


-- Query the average population of all cities in CITY where District is California.
SELECT AVG(POPULATION) FROM CITY WHERE DISTRICT = "California";


-- Given the CITY and COUNTRY tables, query the sum of the populations of all cities where the CONTINENT is 'Asia'.
SELECT SUM(A.POPULATION) FROM CITY AS A INNER JOIN COUNTRY AS B ON A.CountryCode = B.Code WHERE B.CONTINENT="Asia"


-- Query the average population for all cities in CITY, rounded down to the nearest integer.
SELECT FLOOR(AVG(population)) AS average_population FROM CITY;


-- Query the sum of the populations for all Japanese cities in CITY. The COUNTRYCODE for Japan is JPN.
SELECT SUM(population) as population FROM CITY WHERE COUNTRYCODE = "JPN";


-- Query the difference between the maximum and minimum populations in CITY.
SELECT (MAX(population) - MIN(population)) AS population FROM CITY;\


-- Given the CITY and COUNTRY tables, query the names of all cities where the CONTINENT is 'Africa'.
SELECT A.NAME FROM CITY AS A INNER JOIN COUNTRY AS B ON A.COUNTRYCODE = B.CODE WHERE B.CONTINENT = "Africa";


-- Given the CITY and COUNTRY tables, query the names of all the continents (COUNTRY.Continent) and their respective average city populations (CITY.Population) rounded down to the nearest integer.
SELECT B.CONTINENT, FLOOR(AVG(A.POPULATION)) FROM CITY AS A INNER JOIN COUNTRY AS B ON A.COUNTRYCODE = B.CODE GROUP BY B.CONTINENT;


