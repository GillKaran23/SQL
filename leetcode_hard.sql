-- Table: Stadium
-- +---------------+---------+
-- | Column Name   | Type    |
-- +---------------+---------+
-- | id            | int     |
-- | visit_date    | date    |
-- | people        | int     |
-- +---------------+---------+
-- visit_date is the column with unique values for this table.
-- Each row of this table contains the visit date and visit id to the stadium with the number of people during the visit.
-- As the id increases, the date increases as well.
-- Write a solution to display the records with three or more rows with consecutive id's, and the number of people is greater than or equal to 100 for each.
-- Return the result table ordered by visit_date in ascending order.
SELECT
    A.*
FROM
    Stadium AS A,
    Stadium AS B,
    Stadium AS C
WHERE
    (
        (
            A.id + 1 = B.id
            AND A.id + 2 = C.id
        )
        OR (
            A.id -1 = B.id
            AND A.id + 1 = C.id
        )
        OR (
            A.id -2 = C.id
            AND A.id -1 = B.id
        )
    )
    AND A.people >= 100
    AND B.people >= 100
    AND C.people >= 100
GROUP BY
    A.id
ORDER BY
    A.visit_date;