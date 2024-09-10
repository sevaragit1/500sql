--Create table
 
CREATE TABLE #NthHighest
(
 Name  varchar(5)  NOT NULL,
 Salary  int  NOT NULL
)
 
--Insert the values
INSERT INTO  #NthHighest(Name, Salary)
VALUES
('e5', 45000),
('e3', 30000),
('e2', 49000),
('e4', 36600),
('e1', 58000)
 
--Check data
SELECT Name,Salary FROM #NthHighest

--Solution 1
SELECT Name, Salary 
FROM #NthHighest
WHERE Salary = (
SELECT MAX(Salary)
FROM #NthHighest 
WHERE Salary < (SELECT MAX(Salary) FROM #NthHighest))

--Solution 1 from the website
SELECT * FROM #NthHighest N WHERE 1 = (SELECT DISTINCT COUNT(*) FROM NthHighest N1 WHERE N1.Salary > N.Salary)

--Solution 2 from the website
SELECT TOP 1 WITH TIES Name , Salary FROM 3NthHighest N1 
WHERE Salary IN (SELECT TOP 2 WITH TIES Salary FROM #NthHighest ORDER BY Salary DESC)
ORDER BY Salary

--Solution 3 from the website
SELECT A.Name, B.Salary
FROM (
    SELECT MAX(Salary) Salary
    FROM #NthHighest N1 
    WHERE N1.Salary != (SELECT MAX(Salary) FROM #NthHighest) ) B
CROSS APPLY (SELECT NAME FROM #NthHighest WHERE SALARY = B.SALARY ) A

--Solution 4 from the website
;WITH CTE AS
(
    SELECT * , RANK() OVER (ORDER BY SALARY DESC) rnk FROM #NthHighest
)
SELECT Name, Salary FROM CTE WHERE rnk = 2

