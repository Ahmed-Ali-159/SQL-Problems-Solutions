-- Using Postgres

-- Second attempt
WITH employee_unique_queries AS (
  SELECT e.employee_id, COUNT(query_id) AS no_of_unique_queries
  FROM employees e LEFT JOIN queries q   
  ON e.employee_id = q.employee_id
  AND query_starttime >= '2023-07-01' AND query_starttime < '2023-10-01'
  GROUP BY e.employee_id
)

SELECT no_of_unique_queries AS unique_queries, COUNT(employee_id) AS employee_count
FROM employee_unique_queries
GROUP BY no_of_unique_queries
ORDER BY no_of_unique_queries ASC


/*
-- First attempt

WITH employee_unique_queries AS (
  SELECT employee_id, COUNT(DISTINCT query_id) AS no_of_unique_queries
  FROM queries
  GROUP BY employee_id
)

SELECT no_of_unique_queries AS unique_queries, COUNT(employee_id) AS employee_count
FROM employee_unique_queries
GROUP BY no_of_unique_queries
ORDER BY no_of_unique_queries ASC
*/

/*
-- The Solution has 3 mistakes
-- 1) The "Ghost" Employees (The Count of 0)
      - The Logic Gap: If an employee never ran a query, their employee_id will 
                       never appear in the queries table.
      - The Result: Your CTE only sees employees who did something. Since "0" isn't 
                    in the queries table, your final output will never show a category 
                    for unique_queries = 0.
-- 2) The "Missing" Time Filter
      - The prompt explicitly asks for the third quarter of 2023 (July to September).
      
-- 3) The Definition of "Unique"
      - The prompt asks for "number of unique queries."
      - Your Code: You used COUNT(DISTINCT query_id)
      - The Reality: According to the schema, query_id is the Primary Key. By definition, 
                     every single row in that table has a different query_id.
      - The Result: While DISTINCT query_id isn't "wrong," it might be redundant 
                    since every query_id is already unique. Usually, in these types 
                    of interview questions, "unique queries" refers to the 
                    count of actual execution instances in that period. 
                    However, the bigger issue remains how you handle the employees 
                    with a count of zero.
*/


