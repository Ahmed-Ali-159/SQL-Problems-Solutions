WITH rank_salaries AS (
  SELECT employee_id, salary, 
          ROW_NUMBER() OVER (ORDER BY salary DESC) AS sal_rank
  FROM employee
)

SELECT salary
FROM rank_salaries
WHERE sal_rank = 2
