/*************************************************************
**************************************************************
** Group 2: DBDogs											**
** Date Modified: 2/10/23									**
** Course: TCSS 445											**
** Database Project											**
**															**
** Auto Parts Store INSERT (APS)							**
**															**
** Description:												**
** * This is a MS T-SQL document using MS SQL Server and	**
**   MSSMS as a DBMS.										**
** * This database supports auto parts inventory management	**
**   and related vendor information.						**
**															**
**************************************************************
*************************************************************/

USE APS
GO



INSERT INTO VENDOR 
(VendorName)
VALUES
	('Toyota'),
	('Honda'),
	('Ford'),
	('Nissan'),
	('Chevrolet'),
	('BMW'),
	('Dodge'),
	('Audi'),
	('Tesla'),
	('Jeep')
GO

INSERT INTO LOCSITE 
(LocName, LocStreet, LocCity, LocState, LocCode)
VALUES
('California Headquarter', '123 Main LN', 'San Francisco', 'CA', '12345'),
('New York Regional Office', '456 Oak Ave', 'Buffalo', 'NY', '67890'),
('Texas Factory', '789 Pine St', 'Houston', 'TX', '54321'),
('Pennsylvania Warehouse', '321 Elm St', 'Philadelphia', 'PA', '09876'),
('Illinois Factory', '654 Maple Ave', 'Springfield', 'IL', '24680'),
('Los Angeles Distribution Center', '51 Nicolls St', 'Los Angeles', 'CA', '90001'),
('New York Warehouse', '456 Broadway', 'Buffalo', 'NY', '10001'),
('Florida Retail Store', '789 Ocean Dr', 'Miami', 'FL', '33139'),
('Illinois Warehouse', '1010 Industrial Blvd', 'Chicago', 'IL', '60609'),
('Seattle Office', '555 1st Ave', 'Seattle', 'WA', '98104')
GO 

INSERT INTO VEHICLE (VendorID, VehMake, VehModel, VehYear, VehEngine)
VALUES (1000000000, 'Toyota', 'Camry', 2022, '2.5L 4-cylinder'),
	   (1000000001, 'Honda', 'Civic', 2021, '1.5L 4-cylinder'),
	   (1000000002, 'Ford', 'F-150', 2020, '3.5L V6'),
	   (1000000003, 'Nissan', 'Rogue', 2022, '2.5L 4-cylinder'), 
	   (1000000004, 'Chevrolet', 'Silverado', 2021, '5.3L V8'),
	   (1000000005, 'BMW', 'X5', 2022, '3.0L 6-cylinder'),
	   (1000000006, 'Dodge', 'Charger', 2022, '3.6L V6'),
	   (1000000007, 'Audi', 'A4', 2021, '2.0L 4-cylinder'),
	   (1000000008, 'Tesla', 'Model S', 2022, 'Electric'),
	   (1000000009, 'Jeep', 'Grand Cherokee', 2021, '3.6L V6')
GO

INSERT INTO INVOICE (VendorID, InvoiceDesc, InvoiceDate, InvoiceTotal)
VALUES (1000000000, 'Parts order', '2022-01-05', 2500.00),
       (1000000001, 'Oil change and tune-up', '2022-01-07', 175.00),
       (1000000002, 'Transmission repair', '2022-01-08', 800.00),
       (1000000003, 'Brake replacement', '2022-01-15', 600.00),
       (1000000004, 'AC system repair', '2022-01-20', 450.00),
	   (1000000005, 'Tire replacement', '2022-02-02', 1200.00),
       (1000000006, 'Diagnostic testing', '2022-02-10', 80.00),
       (1000000007, 'New battery', '2022-02-15', 200.00),
       (1000000008, 'Alignment and balancing', '2022-02-22', 150.00),
       (1000000009, 'Electric motor repair', '2022-02-25', 1200.00)
GO

INSERT INTO STOCK (LocID, InvoiceID, Qty, Price)
VALUES (1000000000, 1000000000, 10, 200.00),
	   (1000000001, 1000000001, 20, 300.00),
	   (1000000002, 1000000002, 15, 150.00),
	   (1000000003, 1000000003, 25, 250.00),
	   (1000000004, 1000000004, 5, 50.00),
	   (1000000005, 1000000005, 15, 25.00),
	   (1000000006, 1000000006, 8, 99.99),
	   (1000000007, 1000000007, 3, 499.99),
	   (1000000008, 1000000008, 25, 12.50),
	   (1000000009, 1000000009, 10, 45.00)
GO

INSERT INTO PART
(VehID, VendorID, StockID, PartName, PartDesc)
VALUES
	(1000000000, 1000000000, 1000000000, 'Spark Plug', 'Iridium spark plug for high performance engines'),
	(1000000001, 1000000001, 1000000001, 'Oil Filter', 'High-efficiency oil filter for protecting engine components'),
	(1000000002, 1000000002, 1000000002, 'Air Filter', 'High-flow air filter for improved engine breathing'),
	(1000000003, 1000000003, 1000000003, 'Brake Pad', 'Premium ceramic brake pad for better stopping power'),
	(1000000004, 1000000004, 1000000004, 'Battery', 'Maintenance-free battery for reliable starting power'),
	(1000000005, 1000000005, 1000000005, 'Radiator Hose', 'High-temperature resistant radiator hose for improved cooling'),
	(1000000006, 1000000006, 1000000006, 'Alternator', 'High-output alternator for improved electrical performance'),
	(1000000007, 1000000007, 1000000007, 'Ignition Coil', 'High-performance ignition coil for improved engine performance'),
	(1000000008, 1000000008, 1000000008, 'Throttle Body', 'High-flow throttle body for improved engine responsiveness'),
	(1000000009, 1000000009, 1000000009, 'Exhaust Manifold', 'Stainless steel exhaust manifold for improved exhaust flow')
GO

INSERT INTO MERCHANDISE
(VendorID, StockID, MerchName, MerchDesc)
VALUES
	(1000000000, 1000000000, 'Car Stickers', 'Vinyl car stickers with various designs'),
	(1000000001, 1000000001, 'Floor Mats', 'Custom-fit floor mats for various car models'),
	(1000000002, 1000000002,'Air Freshener', 'Scented air fresheners in various fragrances'),
	(1000000003, 1000000003,'Car Cover', 'Water-resistant car cover for all-weather protection'),
	(1000000004, 1000000004,'Steering Wheel Cover', 'Leather steering wheel cover for added comfort'),
	(1000000005, 1000000005,'Seat Covers', 'Stylish seat covers in various colors and patterns'),
	(1000000006, 1000000006,'Car Sun Shade', 'Foldable car sun shade to protect from UV rays'),
	(1000000007, 1000000007,'Windshield Wipers', 'High-quality windshield wipers for clear vision'),
	(1000000008, 1000000008,'Dash Cam', 'High-definition dash cam with night vision'),
	(1000000009, 1000000009,'Engine Oil', '10W-30 motor oil')
GO

INSERT INTO EMPLOYEE (LocID, EmpFName, EmpLName, EmpPhone, EmpStreet, EmpCity, EmpState, EmpCode)
VALUES (1000000000, 'John', 'Doe', '1234567890', '123 Main St', 'Buffalo', 'NY', '67890'),
	   (1000000001, 'Jane', 'Smith', '2345678901', '456 High St', 'San Francisco', 'CA', '90001'),
	   (1000000002, 'Bob', 'Johnson', '3456789012', '789 Elm St', 'Houston', 'TX', '54321'),
	   (1000000003, 'Sara', 'Lee', '4567890123', '321 Oak Ave', 'Miami', 'FL', '33139'),
	   (1000000004, 'Mike', 'Williams', '5678901234', '654 Pine St', 'Chicago', 'IL', '60609'),
	   (1000000005, 'David', 'Brown', '8732369177', '987 Pine St', 'Seattle', 'WA', '98104'),
	   (1000000006, 'Mary', 'Jones', '7234920127', '321 Maple Ave', 'Miami', 'FL', '33139'),
	   (1000000007, 'Benjamin', 'Chen', '6392547295', '22 West Newcastle St', 'Boston', 'MA', '02101'),
	   (1000000008, 'David', 'Wang', '2296822733', '8417 East Circle', 'Denver', 'CO', '80201'),
	   (1000000009, 'Elizabeth', 'Smith', '4154643898', '123 Cedar St', 'Austin', 'TX', '78701');
GO
/************************************************************
** \ \ \ \ \ \ \ \ \ \ \ \ END / / / / / / / / / / / / / / **
*************************************************************/