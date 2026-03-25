-- Using: MySQL
---------------

/*
SELECT page_id
FROM pages
WHERE page_id NOT IN (SELECT page_id FROM page_likes)
ORDER BY page_id
*/

-- Another Solution using: ANTI-JOIN
SELECT p.page_id
FROM pages p LEFT JOIN page_likes pl 
ON p.page_id = pl.page_id
WHERE pl.page_id IS NULL
