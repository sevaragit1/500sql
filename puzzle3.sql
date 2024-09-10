CREATE TABLE EmpBirth
(
 EmpId INT  IDENTITY(1,1) 
,EmpName VARCHAR(50) 
,BirthDate DATETIME 
)
 
--Insert Data
INSERT INTO EmpBirth(EmpName,BirthDate)
SELECT 'Pawan' , '12/04/1983'
UNION ALL
SELECT 'Zuzu' , '11/28/1986'
UNION ALL
SELECT 'Parveen', '05/07/1977'
UNION ALL
SELECT 'Mahesh', '01/13/1983'
UNION ALL
SELECT'Ramesh', '05/09/1983'
 
--Verify data
SELECT EmpId,EmpName,BirthDate FROM EmpBirth

--Solution 1
SELECT EmpName, BirthDate 
FROM EmpBirth
WHERE MONTH(BirthDate) = 05 AND DAY(BirthDate) >= 07 AND DAY(BirthDate) <= 15

--Solution 1 from the website
;WITH CTE AS
(  
        SELECT EmpId , EmpName,BirthDate , MONTH(BirthDate) AS Mont, DAY(BirthDate) AS days
        FROM EmpBirth
)
SELECT EmpId , EmpName,BirthDate FROM CTE WHERE Mont = 5 AND days >= 7 AND days <= 15 

--Solution 2 from the website
;WITH CTE  
AS ( 
    SELECT EmpId , EmpName,BirthDate,
    CASE
      WHEN  MONTH(BirthDate) < 10 THEN  '0' + CAST(MONTH(BirthDate) AS VARCHAR(1))
            ELSE
                CAST(MONTH(BirthDate) AS VARCHAR(2))
      END
    + CASE WHEN DAY(BirthDate) < 10 THEN '0' + CAST(DAY(BirthDate) AS VARCHAR(1))
            ELSE
                  CAST(DAY(BirthDate) AS VARCHAR(2))
            END FormattedDOB
FROM EmpBirth
)
SELECT EmpId , EmpName,BirthDate FROM CTE WHERE FormattedDOB BETWEEN '0507' AND '0515'