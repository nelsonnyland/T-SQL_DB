/*************************************************************
**************************************************************
** Group 2: DBDogs											**
** Date Modified: 2/9/23									**
** Course: TCSS 445											**
** Database Project											**
**															**
** Auto Parts Store CREATE (APS)							**
**															**
** This database supports APS inventory	management and		**
** vendor information.										**
**															**
**************************************************************
*************************************************************/

USE MASTER
GO

IF DB_ID('APS') IS NOT NULL DROP DATABASE APS
GO

CREATE DATABASE APS
GO

USE APS
GO

CREATE TABLE [AUTO]
(
	ID				int				NOT NULL	PRIMARY KEY IDENTITY(1000000000, 1)
	,AutoMake		varchar(50)		NOT NULL	CHECK(LEN(AutoMake) > 1)
	,AutoModel		varchar(50)		NOT NULL	
	,AutoYear		int				NOT NULL	CHECK(LEN(AutoYear) = 4)
	,AutoEngine		varchar(50)		NOT NULL	CHECK(LEN(AutoEngine) > 1)
)
GO

CREATE TABLE VENDOR
(
	ID				int				NOT NULL	PRIMARY KEY IDENTITY(1000000000, 1)
	,VendorName		varchar(50)		NOT NULL	CHECK(LEN(VendorName) > 1)
)
GO

CREATE TABLE PART
(
	ID				int				NOT NULL	PRIMARY KEY IDENTITY(1000000000, 1)
	,AutoID			int				NOT NULL	FOREIGN KEY REFERENCES [AUTO](ID)
	,VendorID		int				NOT NULL	FOREIGN KEY REFERENCES VENDOR(ID)
	,PartName		varchar(50)		NOT NULL	CHECK(LEN(PartName) > 1)
	,PartDesc		varchar(250)	NULL		
	,PartQty		int				NOT NULL	DEFAULT 0
	,PartPrice		smallmoney		NOT NULL	CHECK(PartPrice > 0)
)
GO

CREATE TABLE MERCHANDISE
(
	ID				int				NOT NULL	PRIMARY KEY IDENTITY(1000000000, 1)
	,VendorID		int				NOT NULL	FOREIGN KEY REFERENCES VENDOR(ID)
	,MerchName		varchar(50)		NOT NULL	CHECK(LEN(MerchName) > 1)
	,MerchDesc		varchar(250)	NULL		
	,MerchQty		int				NOT NULL	DEFAULT 0
	,MerchPrice		smallmoney		NOT NULL	CHECK(MerchPrice > 0)
)
GO

/************************************************************
** * * * * * * * * * * * DATA INSERT * * * * * * * * * * * **
*************************************************************/

INSERT INTO [AUTO] 
(AutoMake, AutoModel, AutoYear, AutoEngine) 
VALUES
	('Toyota', 'Corolla', 2015, '2.0 liter four-cylinder'),
	('Toyota', 'Camry', 2019, '2.5L 4-Cylinder'),
    ('Honda', 'Accord', 2020, '1.5L Turbo 4-Cylinder'),
    ('Ford', 'Mustang', 2021, '5.0L V8'),
    ('Chevrolet', 'Camaro', 2022, '6.2L V8'),
    ('Nissan', 'Altima', 2019, '2.5L 4-Cylinder'),
	('Jeep', 'Wrangler', 2021, '2.0L 4-Cylinder Turbo'),
    ('Dodge', 'Charger', 2020, '6.4L V8'),
    ('Tesla', 'Model S', 2021, 'Dual Motor All-Wheel Drive'),
    ('Audi', 'A4', 2022, '2.0L 4-Cylinder Turbo')

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

INSERT INTO PART
(AutoID, VendorID, PartName, PartDesc, PartQty, PartPrice)
VALUES
	(1000000000, 1000000000, 'Spark Plug', 'Iridium spark plug for high performance engines', 50, 5.99),
	(1000000001, 1000000001, 'Oil Filter', 'High-efficiency oil filter for protecting engine components', 100, 7.99),
	(1000000002, 1000000002, 'Air Filter', 'High-flow air filter for improved engine breathing', 75, 9.99),
	(1000000003, 1000000003, 'Brake Pad', 'Premium ceramic brake pad for better stopping power', 200, 29.99),
	(1000000004, 1000000004, 'Battery', 'Maintenance-free battery for reliable starting power', 50, 99.99),
	(1000000005, 1000000005, 'Radiator Hose', 'High-temperature resistant radiator hose for improved cooling', 150, 12.99),
	(1000000006, 1000000006, 'Alternator', 'High-output alternator for improved electrical performance', 75, 199.99),
	(1000000007, 1000000007, 'Ignition Coil', 'High-performance ignition coil for improved engine performance', 100, 44.99),
	(1000000008, 1000000008, 'Throttle Body', 'High-flow throttle body for improved engine responsiveness', 50, 149.99),
	(1000000009, 1000000009, 'Exhaust Manifold', 'Stainless steel exhaust manifold for improved exhaust flow', 25, 199.99)

GO

INSERT INTO MERCHANDISE
(VendorID, MerchName, MerchDesc, MerchQty, MerchPrice)
VALUES
	(1000000000, 'Car Stickers', 'Vinyl car stickers with various designs', 150, 5.99),
	(1000000001, 'Floor Mats', 'Custom-fit floor mats for various car models', 50, 19.99),
	(1000000002, 'Air Freshener', 'Scented air fresheners in various fragrances', 100, 2.49),
	(1000000003, 'Car Cover', 'Water-resistant car cover for all-weather protection', 25, 39.99),
	(1000000004, 'Steering Wheel Cover', 'Leather steering wheel cover for added comfort', 75, 14.99),
	(1000000005, 'Seat Covers', 'Stylish seat covers in various colors and patterns', 30, 24.99),
	(1000000006, 'Car Sun Shade', 'Foldable car sun shade to protect from UV rays', 100, 7.99),
	(1000000007, 'Windshield Wipers', 'High-quality windshield wipers for clear vision', 40, 12.49),
	(1000000008, 'Dash Cam', 'High-definition dash cam with night vision', 20, 59.99),
	(1000000009, 'Engine Oil', '10W-30 motor oil', 500, 29.99)
GO



/************************************************************
** \ \ \ \ \ \ \ \ \ \ \ \ END / / / / / / / / / / / / / / **
*************************************************************/