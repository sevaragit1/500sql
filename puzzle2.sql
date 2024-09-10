CREATE TABLE lag
(
 BusinessEntityID INT
,SalesYear   INT
,CurrentQuota DECIMAL(20,4)
)
 
GO
 
--Insert Data
INSERT INTO lag
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
SELECT 275 , 2006 ,   '1324000.00'
 
--Check data
SELECT BusinessEntityID,SalesYear,CurrentQuota FROM lag


--Solution 1
SELECT *,lead(CurrentQuota, 1, 0) OVER (ORDER BY (SELECT NULL)) AS LeadCurrentQuota 
FROM lag 

--Solution 1 from the website 
;WITH CTE AS
(
    SELECT BusinessEntityID,SalesYear,CurrentQuota,ROW_NUMBER() OVER (ORDER BY %%Physloc%%) rnk  
    FROM lag
)
SELECT    BusinessEntityID,SalesYear,CurrentQuota
        , ISNULL(( SELECT TOP 1 CurrentQuota FROM CTE c2 WHERE c1.rnk < c2.rnk ),0) NextCurrentData
FROM CTE c1

--Solution 2 from the website
;WITH CTE AS
(
    SELECT BusinessEntityID,SalesYear,CurrentQuota,ROW_NUMBER() OVER (ORDER BY %%Physloc%%) rnk  
    FROM lag
)
SELECT    BusinessEntityID,SalesYear,CurrentQuota
          ,ISNULL(LEAD(CurrentQuota) OVER (ORDER BY rnk),0) NextCurrentData     
FROM CTE c1