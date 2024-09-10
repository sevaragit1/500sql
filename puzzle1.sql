
CREATE TABLE #lag
(
BusinessEntityID INT
,SalesYear   INT
,CurrentQuota  DECIMAL(20,4)
)
GO
 
INSERT INTO #lag
SELECT 275 , 2005 , '367000.00'
UNION ALL
SELECT 275 , 2005 , '556000.00'
UNION ALL
SELECT 275 , 2006 , '502000.00'
UNION ALL
SELECT 275 , 2006 , '550000.00'
UNION ALL
SELECT 275 , 2006 , '1429000.00'
UNION ALL
SELECT 275 , 2006 ,  '1324000.00' 


--Solution 1
SELECT * FROM #lag 

SELECT *, lag(CurrentQuota, 1, 0) OVER(ORDER BY(SELECT NULL)) AS lagCurrentData
FROM #lag

--Solution 1 from the website
;WITH CTE AS
( 
    SELECT  BusinessEntityID ,SalesYear ,CurrentQuota
    , ROW_NUMBER() OVER (ORDER BY BusinessEntityID ) AS ID
    FROM #lag
)
SELECT c.BusinessEntityID ,c.SalesYear , c.CurrentQuota
    , ISNULL((SELECT TOP 1 d.CurrentQuota FROM CTE d WHERE c.ID > d.ID ORDER BY ID DESC ),0) lagCurrentData
FROM CTE c
