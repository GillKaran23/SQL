-- Generate the following two result sets:
-- Query an alphabetically ordered list of all names in OCCUPATIONS, immediately followed by the first letter of each profession as a parenthetical (i.e.: enclosed in parentheses). For example: AnActorName(A), ADoctorName(D), AProfessorName(P), and ASingerName(S).
-- Query the number of ocurrences of each occupation in OCCUPATIONS. Sort the occurrences in ascending order, and output them in the following format:
-- There are a total of [occupation_count] [occupation]s.
-- where [occupation_count] is the number of occurrences of an occupation in OCCUPATIONS and [occupation] is the lowercase occupation name. If more than one Occupation has the same [occupation_count], they should be ordered alphabetically.
SELECT CONCAT(NAME, '(', 
              CASE 
                  WHEN OCCUPATION = 'DOCTOR' THEN 'D'
                  WHEN OCCUPATION = 'ACTOR' THEN 'A'
              WHEN OCCUPATION = 'SINGER' THEN 'S'
                  ELSE 'P'
              END, 
              ')') AS NAME_OCCUPATION
FROM OCCUPATIONS
ORDER BY NAME ASC;
SELECT 
    CONCAT('There are a total of ', COUNT(*), ' ', LOWER(occupation), 's.') AS count_ocp
FROM OCCUPATIONS
GROUP BY occupation
ORDER BY COUNT(*) ASC, LOWER(occupation);


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


-- Write a query to find the node type of Binary Tree ordered by the value of the node. Output one of the following for each node:
-- Root: If node is root node.
-- Leaf: If node is leaf node.
-- Inner: If node is neither root nor leaf node.
SELECT b.N,
       (CASE WHEN b.P IS NULL
             THEN 'Root' 
             WHEN (SELECT COUNT(*) FROM BST b2 WHERE b2.P = b.N) > 0 
             THEN 'Inner'
             ELSE 'Leaf'
        END)
FROM bst b 
ORDER BY N;