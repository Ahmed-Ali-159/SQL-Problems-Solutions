-- Using: MySQL
-- First Solution

WITH cte AS(
    SELECT candidate_id, 
        GROUP_CONCAT(DISTINCT skill ORDER BY skill ASC) AS all_skills
    FROM candidates
    GROUP BY candidate_id   
  )

SELECT candidate_id
FROM cte
WHERE all_skills = 'PostgreSQL,Python,Tableau'
ORDER BY candidate_id

-- Another Solution
/*
SELECT candidate_id
FROM candidates
WHERE skill IN ('Python', 'Tableau', 'PostgreSQL')
GROUP BY candidate_id
HAVING COUNT(skill) = 3
ORDER BY candidate_id;

*/
