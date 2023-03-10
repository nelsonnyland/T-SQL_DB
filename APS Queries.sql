/*************************************************************
**************************************************************
** Group 2: DBDogs											**
** Date Modified: 2/10/23									**
** Course: TCSS 445											**
** Database Project											**
**															**
** Auto Parts Store Queries (APS)							**
**															**
** Description:												**
** * This is a MS T-SQL document using MS SQL Server and	**
**   MSSMS as a DBMS.										**
** * This database supports auto parts inventory management	**
**   and related vendor information.						**
**															**
**************************************************************
*************************************************************/

-- SQL Query 1) The purpose of this query is to join the auto, part, and vendor tables using their respective ID's. The expected result is a join of these 3 tables
SELECT *
FROM [AUTO]
JOIN PART ON [AUTO].ID = PART.AutoID
JOIN VENDOR ON PART.VendorID = VENDOR.ID
-- SQL Query 2) The purpose of this query is to join auto and part tables using their id's. It then uses a nested query to get the auto years greater than 2010 and group it by automake
-- and number of parts. The expected result is the automake column with its part numbers.
SELECT AutoMake, COUNT(*) AS NumberOfParts
FROM AUTO
INNER JOIN PART ON [AUTO].ID = PART.AutoID
WHERE AutoMake IN (SELECT AutoMake FROM [AUTO] WHERE AutoYear > 2010)
GROUP BY AutoMake;
-- SQL Query 3) The purpose of this query is to get the "Toyota" automake. The expected result is the columns in auto table with AutoMake Toyota.
SELECT *
FROM [AUTO]
WHERE [AUTO].AutoMake = (SELECT VENDOR.VendorName
                    from VENDOR
                    WHERE VENDOR.VendorName = 'Toyota')
-- SQL Query 4) The purpose of this query is to get the columns from the auto and parts tables along with no matches. The expected result is the output of the full outer join.
SELECT *
FROM [AUTO]
FULL OUTER JOIN PART ON [AUTO].ID = PART.AutoID
-- SQL Query 5) The purpose of this query is to get the names of the merchandise and parts table where the quantity is less than the average for both. The expected result is a combination of these two. 
SELECT PartName FROM PART
WHERE PartQty < (SELECT AVG(PartQty) FROM PART)
UNION 
SELECT MerchName FROM MERCHANDISE
WHERE MerchQty < (SELECT AVG(MerchQty) FROM MERCHANDISE) 
--SQL QUERY 6) b) purpose is to get the revenue for the vendors. c) Expected to get columns with vendorname and total revenue for each vendor name.
SELECT V.VendorName, SUM(P.PartPrice * P.PartQty) + SUM(M.MerchPrice * M.MerchQty) AS Revenue
FROM VENDOR V
LEFT JOIN PART P ON V.ID = P.VendorID
LEFT JOIN MERCHANDISE M ON V.ID = M.VendorID
GROUP BY V.VendorName
--SQL QUERY 7) b) If you are a car company and you need more than 100 parts for a certain car c) Will do a join on auto and part tables and get automodel with more than 100 car parts.
SELECT [AUTO].AutoModel
FROM [AUTO]
	JOIN PART
	ON PART.AutoID = AUTO.ID
WHERE PART.PartQty > 100
--SQL QUERY 8) b) purpose is for users to find parts with prices less than avg price. c) Expected result is join of some of the columns in part and auto table with price less than avg part price
SELECT P.PartName, P.PartPrice, A.AutoMake, A.AutoModel, A.AutoYear
FROM PART P 
INNER JOIN AUTO A ON P.AutoID = A.ID
WHERE P.PartPrice < (SELECT AVG(PartPrice) FROM PART);


--SQL QUERY 9) b) purpose is to get average part price and merchandise price for each vendor. Useful when trying to compare price for each vendor. 
-- c) Expected results was to be a join on auto, vendor, and merchandies to create a result table with vendor names and avg pricing for each vendor.
SELECT VENDOR.VendorName, AVG(PART.PartPrice + MERCHANDISE.MerchPrice / 2) AS "Average Price"
FROM VENDOR
    JOIN PART
    ON VENDOR.ID = PART.VendorID
    JOIN MERCHANDISE
    ON VENDOR.ID = MERCHANDISE.VendorID
GROUP BY VENDOR.VendorName
--SQL QUERY 10) b) purpose is for users to find a vendors avg price for parts and Stock. Can be useful to see if average price.
--c) Expected results is join on VENDOR, PART, STOCK and a table that has avg price.
SELECT AVG(STOCK.Price / 2) AS "Average Price"
FROM VENDOR
    JOIN PART as part
    ON VENDOR.ID = part.VendorID
    JOIN STOCK
    ON PART.StockID = STOCK.ID

--query 10
SELECT l.LocName, COUNT(e.ID) AS NumEmployees
FROM LOCSITE l
LEFT JOIN EMPLOYEE e ON l.ID = e.LocID
GROUP BY l.LocName

--QUERY 
SELECT V.VendorName, VE.VehMake, VE.VehModel, VE.VehYear, S.Qty, S.Price, L.LocName, L.LocStreet, L.LocCity, L.LocState
FROM STOCK S
JOIN INVOICE I ON S.InvoiceID = I.ID
JOIN VEHICLE VE ON I.VendorID = VE.VendorID
JOIN VENDOR V ON VE.VendorID = V.ID
JOIN LOCSITE L ON S.LocID = L.ID;


SELECT V.VendorName, SUM(S.Price * S.Qty) AS TotalSales
FROM VENDOR V
INNER JOIN VEHICLE VEH ON V.ID = VEH.VendorID
INNER JOIN PART P ON P.VehID = VEH.ID
INNER JOIN STOCK S ON S.ID = P.StockID
WHERE S.InvoiceID IN (
    SELECT I.ID
    FROM INVOICE I
    WHERE I.InvoiceDate BETWEEN '2022-01-01' AND '2022-12-31'
)
GROUP BY V.VendorName
ORDER BY TotalSales DESC;


SELECT p.PartName, p.PartDesc, v.VehMake, v.VehModel, v.VehYear, 
       (SELECT TOP 1 s.Price 
        FROM STOCK s 
        WHERE s.ID = p.StockID 
        ORDER BY s.Price DESC) AS 'Highest Price'
FROM PART p
INNER JOIN VEHICLE v ON p.VehID = v.ID
WHERE p.PartName LIKE '%filter%'
ORDER BY v.VehYear ASC;