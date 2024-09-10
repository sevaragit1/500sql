CREATE TABLE #Movie
(
 
[MName] [varchar] (10) NULL,
[AName] [varchar] (10) NULL,
[Roles] [varchar] (10) NULL
) 

 
--Insert data in the table
 
INSERT INTO #Movie(MName,AName,Roles)
SELECT 'A','Amitabh','Actor'
UNION ALL
SELECT 'A','Vinod','Villan'
UNION ALL
SELECT 'B','Amitabh','Actor'
UNION ALL
SELECT 'B','Vinod','Actor'
UNION ALL
SELECT 'D','Amitabh','Actor'
UNION ALL
SELECT 'E','Vinod','Actor'
 
--Check your data
SELECT MName , AName , Roles FROM #Movie

--Solution 1
SELECT * 
FROM #Movie
WHERE MName IN (
SELECT MName
FROM #Movie
WHERE Roles = 'Actor'
GROUP BY MName
HAVING COUNT(AName) = 2
)

--Solution 1 from the website
select * from #Movie where MName in
(select MName from #Movie where Roles = 'Actor' and (AName = 'Amitabh' or AName = 'Vinod')
group by MName having count(MName)>1)

--Solution 2 from the website
SELECT m1.* FROM #Movie m1 INNER JOIN #Movie m2 ON m1.MName = m2.MName
WHERE
( m1.AName ='Amitabh' AND m2.AName ='Vinod' OR m2.AName ='Amitabh' AND m1.AName ='Vinod')
AND(m1.Roles ='Actor')
AND(m2.Roles ='Actor')

--Solution 3 from the website
SELECT p.* FROM #Movie p
CROSS APPLY
(
SELECT COUNT(*) w FROM #Movie t
WHERE ( t.AName = 'Amitabh' OR t.AName = 'Vinod' ) AND t.roles = 'Actor' AND t.MName = p.MName
)r
WHERE ( p.AName = 'Amitabh' OR p.AName = 'Vinod' ) AND p.roles = 'Actor' AND r.w > 1