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



--QUERY 1
-- Purpose: useful for customer to find the total number of merchandise.
-- Expected Result: Gives all total quantity of each merchandise item and gives merchandise name, vendor name, and location as well.
SELECT L.LocName, M.MerchName, V.VendorName, SUM(S.Qty) AS TotalQuantity
FROM MERCHANDISE M
INNER JOIN STOCK S ON S.ID = M.StockID
INNER JOIN LOCSITE L ON L.ID = S.LocID
INNER JOIN VENDOR V ON V.ID = M.VendorID
GROUP BY L.LocName, M.MerchName, V.VendorName;

--QUERY 2
-- Purpose: This query gives general information for a user on everything.
-- Expected Result: Gives a table with information on vehicale make, model, year, Stock qty, location name, city, and state.
SELECT V.VendorName, VE.VehMake, VE.VehModel, VE.VehYear, S.Qty, S.Price, L.LocName, L.LocStreet, L.LocCity, L.LocState
FROM STOCK S
JOIN INVOICE I ON S.InvoiceID = I.ID
JOIN VEHICLE VE ON I.VendorID = VE.VendorID
JOIN VENDOR V ON VE.VendorID = V.ID
JOIN LOCSITE L ON S.LocID = L.ID;

--QUERY 3
-- Purpose: Can be useful to find total sales for a certain vendor. Will allow for customer to see which vendor is good.
-- Expected Result: Gives a table that has vendors on one side and total sales on other.

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

--QUERY 4
-- Purpose: This query retrieves information about parts that have "filter" in their name and the vehicle information. It gets the price for that stock and orders it by price in descending order.
-- Expected Result: Finds part name that has filter and sorts by price. Displays filter, partDesc, VehMake, Model, Year, and price of part.

SELECT p.PartName, p.PartDesc, v.VehMake, v.VehModel, v.VehYear, 
       (SELECT TOP 1 s.Price 
        FROM STOCK s 
        WHERE s.ID = p.StockID 
        ORDER BY s.Price DESC) AS 'Highest Price'
FROM PART p
INNER JOIN VEHICLE v ON p.VehID = v.ID
WHERE p.PartName LIKE '%filter%'
ORDER BY v.VehYear ASC;

--Query 5
-- Purpose: This query retrieves data about the number of parts and merchandise items sold by vendors across all locations
-- Expected Result:
SELECT 
    V.VendorName,
    L.LocName,
    COUNT(DISTINCT P.ID) AS PartsCount,
    COUNT(DISTINCT M.ID) AS MerchandiseCount
FROM 
    VENDOR V
    FULL OUTER JOIN VEHICLE VE ON V.ID = VE.VendorID
    FULL OUTER JOIN PART P ON VE.ID = P.VehID
    FULL OUTER JOIN MERCHANDISE M ON V.ID = M.VendorID
    FULL OUTER JOIN STOCK S ON P.StockID = S.ID OR M.StockID = S.ID
    FULL OUTER JOIN LOCSITE L ON S.LocID = L.ID
GROUP BY 
    V.VendorName,
    L.LocName
HAVING 
    COUNT(DISTINCT P.ID) > 0 OR COUNT(DISTINCT M.ID) > 0
ORDER BY 
    V.VendorName ASC,
    L.LocName ASC

--Query 6
--purpose:This query retrieves the names of all parts and merchandise sold by the vendor 'Toyota'. 
-- It does this by using nested queries to first find the ID of the vendor with the name 'Toyota', and then selecting the part names and merchandise names that correspond to that vendor ID using the UNION set operation to combine the two result sets
-- Expected Results: A table with parts and merchandise sold by toyota.
SELECT PartName
FROM PART
WHERE VendorID = (
    SELECT ID
    FROM VENDOR
    WHERE VendorName = 'Toyota'
)
UNION
SELECT MerchName
FROM MERCHANDISE
WHERE VendorID = (
    SELECT ID
    FROM VENDOR
    WHERE VendorName = 'Totota'
);

--Query 7
-- purpose: useful for customer to find parts that are made by ford and see if the part they are looking for is avaliable.
-- expected result: Gives part name, vendor name, quantity, stock price, and location of parts made by ford.
SELECT P.PartName, V.VendorID, S.Qty, S.Price, L.LocName
FROM PART P
JOIN VEHICLE V ON P.VehID = V.ID
JOIN VENDOR VN ON P.VendorID = VN.ID
JOIN STOCK S ON P.StockID = S.ID
JOIN LOCSITE L ON S.LocID = L.ID
WHERE V.VehMake = 'Ford';


--Query 8
-- Purpose: Can be useful for customer to find information for Toyota.
-- Expected Result:
SELECT 
  INV.ID AS InvoiceID,
  INV.InvoiceDesc AS InvoiceDesc,
  V.VendorName AS VendorName,
  P.PartName AS PartName,
  P.PartDesc AS PartDesc,
  PS.Qty AS Qty,
  PS.Price AS Price
FROM 
  INVOICE INV
  JOIN VENDOR V ON INV.VendorID = V.ID
  JOIN STOCK PS ON INV.ID = PS.InvoiceID
  JOIN PART P ON PS.ID = P.StockID
  JOIN VEHICLE VEH ON P.VehID = VEH.ID
WHERE 
  V.VendorName = 'Toyota'
ORDER BY 
  INV.ID DESC;

--Query 9
-- Purpose: Can be useful for customer to see which company is doing good on sales based on parts sold and revenue.
-- Expected Result: Displays a table that retrives total parts sold and total revenue for each vendor part.
SELECT 
    V.VendorName, 
    P.PartName, 
    SUM(S.Qty) AS TotalQtySold, 
    SUM(S.Qty * S.Price) AS TotalRevenue
FROM 
    VENDOR V
    INNER JOIN PART P ON V.ID = P.VendorID
    INNER JOIN STOCK S ON P.StockID = S.ID
GROUP BY 
    V.VendorName, 
    P.PartName


--Query 10
-- Purpose: Can be useful for customer to find if there are any oil filter parts, and find price and location.
-- Expected Result: Displays a table that retrives all vendor names and location and quantity and price for oil filter part.
SELECT p.PartName, v.VendorName, l.LocName, s.Qty, s.Price
FROM PART p
JOIN VEHICLE veh ON p.VehID = veh.ID
JOIN VENDOR v ON p.VendorID = v.ID
JOIN STOCK s ON p.StockID = s.ID
JOIN LOCSITE l ON s.LocID = l.ID
WHERE p.PartName = 'Oil Filter'
ORDER BY s.Price DESC