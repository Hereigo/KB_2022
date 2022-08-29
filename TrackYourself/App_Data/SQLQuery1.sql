
SELECT 
	c.Name AS '=Cat=', 
	SUM(DATEDIFF(SECOND, '0:00:00', r.TimeSpent)) AS '=Seconds='
FROM Records r
LEFT JOIN RecordCategories c
	ON r.RecordCategoryId=c.Id
GROUP BY c.Name	
ORDER BY c.Name