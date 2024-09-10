CREATE TABLE List
(
ID INT
)
GO
 
INSERT INTO List(ID) VALUES (1),(2),(3),(4),(5)

--Solution 1
SELECT ID, SUM(ID) OVER (ORDER BY ID) AS CumulativeSum
FROM List

--Solution 2
SELECT A.ID, (SELECT SUM(B.ID) FROM List B
WHERE B.ID <= A.ID) AS CumulativeSum
FROM List A
ORDER BY A.ID