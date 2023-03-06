/*************************************************************
**************************************************************
** Author: Nelson Nyland									**
** Date Modified: 2/20/18									**
** Department: CPW 210										**
** Database Scripting Assignment							**
**															**
** National Computer Components - NCC						**
**															**
** This database supports NCC online shopping, inventory	**
** management, logistics, HR, and vendor contact info.		**
**															**
** The main table is the product table, which connects to	**
** several important tables that keep track of products.	**
**************************************************************																														
*************************************************************/

USE MASTER
GO

IF DB_ID('NCC') IS NOT NULL DROP DATABASE NCC
GO

CREATE DATABASE NCC
GO

USE NCC
GO

CREATE TABLE Department
(
	DepartmentID			int				NOT NULL	PRIMARY KEY IDENTITY
	,DepartmentName			varchar(50)		NOT NULL	
)
GO

CREATE TABLE Employees
(
	EmployeeID				int				NOT NULL	PRIMARY KEY IDENTITY(10000, 1)
	,DepartmentID			int				NOT NULL	FOREIGN KEY REFERENCES Department(DepartmentID)
	,EmployeeFirstName		varchar(50)		NOT NULL	CHECK(LEN(EmployeeFirstName) > 2)
	,EmployeeLastName		varchar(50)		NOT NULL	CHECK(LEN(EmployeeLastName) > 2)
	,EmployeePhone			varchar(15)		NOT NULL	UNIQUE CHECK(EmployeePhone LIKE '([0-9][0-9][0-9])[0-9][0-9][0-9]-[0-9][0-9][0-9][0-9]')
	,EmployeeEmail			varchar(255)	NOT NULL	UNIQUE CHECK(EmployeeEmail LIKE '%@%.%')			
	,EmployeeHireDate		date			NOT NULL	CHECK(EmployeeHireDate < GETDATE())
	,EmployeeFireDate		date			NULL		CHECK(EmployeeFireDate <= GETDATE())
	,EmployeeWage			smallmoney		NOT NULL
)
GO

CREATE TABLE ProductCategory
(
	CategoryID				int				NOT NULL	PRIMARY KEY IDENTITY
	,CategoryName			varchar(50)		NOT NULL	CHECK(LEN(CategoryName) > 2)
)
GO

CREATE TABLE ProductWharehouse
(
	WharehouseID			int				NOT NULL	PRIMARY KEY IDENTITY
	,ProductWhareCity		varchar(15)		NULL		CHECK(LEN(ProductWhareCity) > 2)
	,ProductWhareState		char(2)			NULL		CHECK(ProductWhareState LIKE '[A-Z][A-Z]')
)
GO

CREATE TABLE UserAccounts
(
	UserID					int				NOT NULL	PRIMARY KEY IDENTITY(100000000, 1)
	,UserAccount			nvarchar(50)	NOT NULL	UNIQUE CHECK(LEN(UserAccount) > 2)
	,UserPWHash				nvarchar(40)	NOT NULL	CHECK(LEN(UserPWHash) = 40)
	,UserEmail				varchar(255)	NOT NULL	UNIQUE CHECK(UserEmail LIKE '%@%.%')
	,UserPhone				varchar(15)		NOT NULL	UNIQUE CHECK(UserPhone LIKE '([0-9][0-9][0-9])[0-9][0-9][0-9]-[0-9][0-9][0-9][0-9]')	
	,UserFirstName			varchar(50)		NOT NULL	CHECK(LEN(UserFirstName) > 2)
	,UserLastName			varchar(50)		NOT NULL	CHECK(LEN(UserLastName) > 2)
	,UserAddress1			varchar(50)		NOT NULL	CHECK(LEN(UserAddress1) > 2)
	,UserAddress2			varchar(50)		NULL		CHECK(LEN(UserAddress2) > 2)
	,UserCity				varchar(15)		NOT NULL	CHECK(LEN(UserCity) > 2)
	,UserState				char(2)			NOT NULL	CHECK(UserState LIKE '[A-Z][A-Z]')
	,UserZip				char(5)			NOT NULL	CHECK(UserZip LIKE '[0-9][0-9][0-9][0-9][0-9]')
)
GO

CREATE TABLE Orders
(
	OrderID					int				NOT NULL	PRIMARY KEY IDENTITY(100000000, 1)
	,UserID					int				NOT NULL	FOREIGN KEY REFERENCES UserAccounts(UserID)
	,OrderDate				date			NOT NULL	CHECK(OrderDate < GETDATE())
	,OrderTotal				smallmoney		NOT NULL	CHECK(OrderTotal > 0)
)
GO

CREATE TABLE OrderTracking
(
	OrderID					int				NOT NULL	PRIMARY KEY REFERENCES Orders(OrderID)
	,OrderTrackingID		bigint			NULL		CHECK(OrderTrackingID > 10000)
	,OrderStatus			varchar(15)		NULL		
	,OrderLastLocation		varchar(50)		NULL		
)
GO

CREATE TABLE Vendors
(
	VendorID				int				NOT NULL	PRIMARY KEY IDENTITY(10000, 1)
	,VendorName				varchar(50)		NOT NULL	
	,VendorEmail			varchar(255)	NOT NULL	UNIQUE CHECK(VendorEmail LIKE '%_@_%_.__%')
	,VendorPhone			varchar(15)		NULL		UNIQUE CHECK(VendorPhone LIKE '%([0-9][0-9][0-9])[0-9][0-9][0-9]-[0-9][0-9][0-9][0-9]')	
	,VendorAddress			varchar(50)		NULL		CHECK(LEN(VendorAddress) > 2)
	,VendorCity				varchar(15)		NOT NULL	CHECK(LEN(VendorCity) > 2)
	,VendorState			char(2)			NOT NULL	CHECK(VendorState LIKE '[A-Z][A-Z]')
	,VendorZip				char(5)			NOT NULL	CHECK(VendorZip LIKE '[0-9][0-9][0-9][0-9][0-9]')
	,VendorContactFName		varchar(50)		NULL		CHECK(LEN(VendorContactFName) > 2)
	,VendorContactLName		varchar(50)		NULL		CHECK(LEN(VendorContactLName) > 2)
)
GO

CREATE TABLE Invoices
(
	InvoiceID				int				NOT NULL	PRIMARY KEY IDENTITY(1000000000, 1)
	,VendorID				int				NOT NULL	FOREIGN KEY REFERENCES Vendors(VendorID)
	,InvoiceDate			date			NULL	
	,InvoiceTotal			smallmoney		NOT NULL	CHECK(InvoiceTotal > 0)
)
GO

CREATE TABLE Products
(
	ProductID				int				NOT NULL	PRIMARY KEY IDENTITY(1000000, 1)
	,VendorID				int				NOT NULL	FOREIGN KEY REFERENCES Vendors(VendorID)
	,CategoryID				int				NOT NULL	FOREIGN KEY REFERENCES ProductCategory(CategoryID)
	,ProductName			varchar(50)		NOT NULL	CHECK(LEN(ProductName) > 2)
	,ProductManufacturer	varchar(50)		NOT NULL	
	,ProductModel			varchar(50)		NOT NULL	CHECK(LEN(ProductModel) > 0)
	,ProductSerial			varchar(50)		NULL
	,ProductType			varchar(50)		NULL
	,ProductDescription		varchar(200)	NULL
	,ProductWholesalePrice	smallmoney		NOT NULL	CHECK(ProductWholesalePrice > 0)
	,ProductRetailPrice		smallmoney		NULL		CHECK(ProductRetailPrice > 0)
	,ProductSalePrice		smallmoney		NULL		CHECK(ProductSalePrice > 0)
	,ProductWhareWhareLoc	bigint			NULL		CHECK(ProductWhareWhareLoc > 100000)
)
GO

CREATE TABLE UserWishlists
(
	UserID					int				NOT NULL	FOREIGN KEY REFERENCES UserAccounts(UserID)
	,ProductID				int				NOT NULL	FOREIGN KEY REFERENCES Products(ProductID)
	,WishlistID				int				NOT NULL	UNIQUE IDENTITY(100000, 1)
	,PRIMARY KEY(UserID, ProductID)
)
GO

CREATE TABLE ProductInventory
(
	ProductID				int				NOT NULL	PRIMARY KEY REFERENCES Products(ProductID)
	,WharehouseID			int				NOT NULL	FOREIGN KEY REFERENCES ProductWharehouse(WharehouseID)
	,ProductQty				int				NOT NULL	DEFAULT 0
)
GO

CREATE TABLE ProductPhoto
(
	ProductID				int				NOT NULL	PRIMARY KEY REFERENCES Products(ProductID)
	,PhotoPath				varchar(100)	NOT NULL	CHECK(LEN(PhotoPath) > 2)						
)
GO

/************************************************************
** * * * * * * * * * * * DATA INSERT * * * * * * * * * * * **
*************************************************************/

INSERT INTO Department 
(DepartmentName) 
VALUES
	('Accounting')	
	,('Finance')
	,('HR')
	,('IT')
	,('Logistics')
	,('Management')
	,('Marketing')
	,('Product Management')
	,('Shipping')
	,('Support')
GO

INSERT INTO Employees 
(DepartmentID, EmployeeFirstName, EmployeeLastName, EmployeePhone, EmployeeEmail, EmployeeHireDate, EmployeeFireDate, EmployeeWage)
VALUES
	(1, 'Robert', 'Christopherson', '(206)539-8713', 'nturfin0@themeforest.net', '1/16/2005', NULL, 75.62)
	,(7, 'Rebecca', 'Smith', '(206)298-3754', 'mbelverstone1@bravesites.com', '6/3/2008', NULL, 66.16)
	,(6, 'Melinda', 'Arlington', '(206)732-9472', 'cgetten4@economist.com', '3/2/1999', NULL, 91.50)
	,(6, 'Brad', 'McMaster', '(206)287-3640', 'lbasil5@multiply.com', '4/6/2002', NULL, 80.45)
	,(3, 'Jim', 'Delico', '(206)157-3943', 'nvoff6@wikispaces.com', '6/5/2010', NULL, 50.16)
	,(5, 'Jason', 'Bradley', '(206)527-8329', 'swoodcroft9@stumbleupon.com', '3/4/2014', NULL, 49.86)
	,(4, 'Albert', 'Winipeg', '(206)582-9374', 'cmeedendorpec@purevolume.com', '2/1/2007', NULL, 70.34)
	,(2, 'Dan', 'Robertson', '(206)284-3968', 'bdumphyd@prlog.org', '1/15/2009', '12/21/2010', 74.57)
	,(8, 'Kim', 'Zalifinakis', '(206)284-9367', 'cchestnutte@hostgator.com', '3/16/2016', NULL, 45.76)
	,(9, 'Alice', 'Cheque', '(206)293-7485', 'mtommenf@xing.com', '1/1/2015', NULL, 48.48)
	,(10, 'Jim', 'Wiskers', '(206)394-3847', 'jimbim3654@google.com', '2/4/2008', NULL, 15.00)
GO

INSERT INTO ProductCategory
(CategoryName)
VALUES
	('Computer Systems')
	,('Components')
	,('Electronics')
	,('Gaming')
	,('Networking')
	,('Office Solutions')
	,('Software & Services')
	,('Automotive & Industrial')
	,('Home & Tools')
	,('Health & Sports')
	,('Apparel & Accessories')
	,('Hobbies & Toys')
GO

INSERT INTO ProductWharehouse
(ProductWhareCity, ProductWhareState)
VALUES
	('Newark', 'NJ')
	,('Wilmington', 'DE')
	,('Sacramento', 'CA')
	,('Milwaukee', 'WI')
	,('Kent', 'WA')
	,('Dallas', 'TX')
	,('Jacksonville', 'FL')
GO

INSERT INTO UserAccounts
(UserAccount, UserPWHash, UserEmail, UserPhone, UserFirstName, UserLastName, UserAddress1, UserAddress2, UserCity, UserState, UserZip)
VALUES
	('smackilroe0', '311fda0c6b30c983b2b2fc906445642a55a2b17c', 'smackilroe0@lycos.com', '(253)892-6683', 'Shelli', 'MacKilroe', '0 Debra Terrace', NULL, 'Seattle', 'WA', 72834)
	,('cmcging1', '26eeca75422a78fa080916439c28dabbbe5808f6', 'cmcging1@zimbio.com', '(860)490-8659', 'Callida', 'McGing', '2272 Walton Hill', null, 'Hartford', 'CT', 29374)
	,('hmartinez2', 'ee811660a68418c6d1bcff64d5b1753c7a584e31', 'hmartinez2@hubpages.com', '(318)424-5965', 'Honey', 'Martinez', '6841 Monument Parkway', null, 'Shreveport', 'LA', 90474)
	,('aheinig3', '88ccdbd4a3831d21973734e9ae4d571adc2f0aa2', 'aheinig3@printfriendly.com', '(806)664-7765', 'Alec', 'Heinig', '2139 Valley Edge Point', null, 'Amarillo', 'TX', 92847)
	,('movesen4', '3edbf5e381269cbddba9d4d7f548651b499e33c0', 'movesen4@skyrock.com', '(603)442-7997', 'Magda', 'Ovesen', '40 Utah Crossing', null, 'Portsmouth', 'NH', 29348)
	,('bmcdermid5', '811b1be7ead965beb24d6c2ca4fb7027e285cf21', 'bmcdermid5@t.co', '(757)430-7831', 'Barbaraanne', 'McDermid', '20 Anderson Park', null, 'Norfolk', 'VA', 38495)
	,('crustan6', 'ea76ff2d849c23f6b5f85024f9fbe8b41c8ad425', 'crustan6@hibu.com', '(850)955-6217', 'Crin', 'Rustan', '25476 Bobwhite Park', null, 'Pensacola', 'FL', 28394)
	,('chartwell7', '4d0d982eb18523c5f3633d741d313b944d04f9c4', 'chartwell7@phoca.cz', '(941)923-7599', 'Clare', 'Hartwell', '0105 Melby Terrace', null, 'North Port', 'FL', 39485)
	,('bfirth8', '77ec1505390893664a14773cc3dec955d239bf88', 'bfirth8@1688.com', '(315)594-8362', 'Boycey', 'Firth', '81 Mifflin Parkway', null, 'Syracuse', 'NY', 39485)
	,('bchalder9', '526228fc63b295d98173eb6fcdebace890f5579f', 'bchalder9@bigcartel.com', '(434)375-6662', 'Buck', 'Chalder', '15235 Oxford Drive', null, 'Lynchburg', 'VA', 38440)
GO

INSERT INTO Orders
(UserID, OrderDate, OrderTotal)
VALUES
	(100000000, '2/7/2017', 199.91)
	,(100000001, '10/9/2017', 5587.15)
	,(100000002, '3/1/2017', 2137.72)
	,(100000003, '11/21/2017', 1611.00)
	,(100000004, '1/15/2017', 155.34)
	,(100000005, '10/1/2017', 6324.49)
	,(100000006, '8/26/2017', 20618.09)
	,(100000007, '1/23/2018', 592.27)
	,(100000008, '2/27/2018', 678.83)
	,(100000009, '3/2/2018', 189.08)

GO

INSERT INTO OrderTracking
(OrderID, OrderTrackingID, OrderStatus, OrderLastLocation)
VALUES
	(100000000, 2394883450934850, 'delivered', 'Seattle, WA')
	,(100000001, 2398342093840393, 'delivered', 'Hartford, CT')
	,(100000002, 0234023984023984345, 'delivered', 'Shreveport, LA')
	,(100000003, 3498504958409498, 'delivered', 'Amarillo, TX')
	,(100000004, 45830948503494958, 'delivered', 'Portsmouth, NH')
	,(100000005, 23948734987234873, 'delivered', 'Norfolk, VA')
	,(100000006, 239847239847398473, 'delivered', 'Pensacola, FL')
	,(100000007, 23498237423987438, 'delivered', 'North Port, FL')
	,(100000008, 23987439874239847, 'shipped', 'Newark, NJ')
	,(100000009, 293847328742384732, 'pending', NULL)
GO

INSERT INTO Vendors
(VendorName, VendorEmail, VendorPhone, VendorAddress, VendorCity, VendorState, VendorZip, VendorContactFName, VendorContactLName)
VALUES
	('Corsair', 'bradwilco@corsair.com', '(877)637-3728', '318 Pepper Wood Drive', 'San Luis Obisbo', 'CA', 93847, 'Brad', 'Wilco')
	,('CoolerMaster', 'johnrichards@coolermaster.com', '(332)847-2843', '8233 Farragut Plaza', 'Milwaukee', 'WI', 38271, 'John', 'Richards')
	,('Razer', 'rachelcenwick@razer.com', '(346)385-3748', '343 La Follette Street', 'New York', 'NY', 39475, 'Rachel', 'Cenwick')
	,('Dell', 'arthurpendragon@dell.com', '(378)283-4728', '100 Mosinee Court', 'Austin', 'TX', 93847, 'Arthur', 'Pendragon')
	,('HP', 'chadwinston@hp.com', '(857)384-2849', '6 Buell Avenue', 'Palo Alto', 'CA', 37483, 'Chad', 'Winston')
	,('Samsung', 'zachnakamichi@samsung.com', '1(999)284-3847', '8234 Wisiko Arterial PG6', 'Senzhen', 'CH', 11111, 'Zach', 'Nakamichi')
	,('Logitech', 'shannonwatino@logitech.com', '(384)382-3738', '64355 Lakewood Place', 'Biluxy', 'NC', 38747, 'Shannon', 'Watino')
	,('Intel', 'caseyschuler@intel.com', '(294)283-2384', '293 Intel Ave', 'Los Angeles', 'CA', 28374, 'Casey', 'Schuler')
	,('Zotac', 'ramsybenson@zotac.com', '(274)385-3849', '28490 Zotac Rd', 'Gerge', 'BL', 11111, 'Ramsey', 'Benson')
	,('Kensington', 'robsumier@kensington.com', '(392)284-2847', '2947 Virtio Ave', 'Seattle', 'WA', 94837, 'Rob', 'Sumier')
GO

INSERT INTO Invoices
(VendorID, InvoiceDate, InvoiceTotal)
VALUES
	(10000, '7/2/2013', 16860.13)
	,(10001, '11/27/2017', 4254.23)
	,(10002, '2/28/2013', 26415.97)
	,(10003, '8/26/2014', 16834.50)
	,(10004, '6/16/2012', 47812.47)
	,(10005, '3/15/2015', 34695.71)
	,(10006, '11/30/2016', 39615.53)
	,(10007, '9/7/2013', 8735.99)
	,(10008, '9/11/2015', 35417.51)
	,(10009, '8/12/2016', 23763.02)
GO

INSERT INTO Products
(VendorID, CategoryID, ProductName, ProductManufacturer, ProductModel, ProductSerial, ProductType, ProductDescription, ProductWholesalePrice, 
	ProductRetailPrice, ProductSalePrice, ProductWhareWhareLoc)
VALUES
	(10000, 2, 'G150 ModMaster', 'Corsair', 'G150', '1238832950934', 'CPU Heatsink', '120mm CPU radiator', 
		99.99, 120.50, 112.60, 2938575320)
	,(10001, 4, '550XFX Mechanical Keyboard', 'CoolerMaster', '550XFX', '32834205', 'Mechanical Keyboard', '120 key LED mechanical keyboard.',
		80.99, 115.77, 99.99, 2948675720)
	,(10002, 4, 'R220 Saphire Gaming Mouse', 'Razer', 'R220', 'G87DF9987', 'Gaming Mouse', '500 DPI ultra-sensitive gaming mouse.',
		50.00, 85.50, 72.60, 2944673740)
	,(10003, 1, 'Dell OptiPlex 7040', 'Dell', '7040', '2838405059', 'Computer System', 'Full system setup with tower, monitor, keyboard, and mouse.',
		500.50, 850.99, 750.99, 2934683760)
	,(10004, 1, 'HP Envy 15t', 'HP', '15t4605', '230948339', 'Computer System', 'Full system setup with tower, monitor, keyboard, and mouse.',
		880.60, 1500.99, 1200.99, 2932633456)
	,(10005, 2, '500GB EVO SSD', 'Samsung', 'EVO', '1983743', 'Hard Drive', '500 GB SSD for interior installation.', 
		50.00, 85.00, 80.00, 2932675633)
	,(10006, 3, '1080HD Webcam', 'Logitech', '1080HD', '123H8', 'Web Camera', '1080P Full HD USB 3.0 video camera.', 
		40.00, 75.99, 65.89, 2932625479)
	,(10007, 2, 'X299 Processor', 'Intel', 'X299X', 'X299Xrf8920-4', 'Microprocessor', 'Intel X299 10-core workstation class microprocessor.', 
		250.00, 560.99, 499.99, 2932634567)
	,(10008, 1, 'Zotac Mini', 'Zotac', 'LP530', '3829034-5', 'Computer System', 'Zotac Mini LP530 is the most compact system we offer.', 
		455.80, 690.90, 599.99, 2932625828)
	,(10009, 2, '16GB HyperX RAM', 'Kensington', 'HyperX 9880 Series', '23R3-23G4', 'RAM Module', 'Kensington 16GB HyperX RAM comes as a pair.', 
		50.00, 89.99, 79.99, 2932691247)
GO

INSERT INTO UserWishlists
(UserID, ProductID)
VALUES
	(100000000, 1000000)
	,(100000001, 1000001)
	,(100000002, 1000002)
	,(100000003, 1000003)
	,(100000004, 1000004)
	,(100000005, 1000005)
	,(100000006, 1000006)
	,(100000007, 1000007)
	,(100000008, 1000008)
	,(100000009, 1000009)
GO

INSERT INTO ProductInventory
(ProductID, WharehouseID, ProductQty)
VALUES
	(1000000, 2, 154)
	,(1000001, 4, 160)
	,(1000002, 6, 175)
	,(1000003, 3, 145)
	,(1000004, 1, 179)
	,(1000005, 3, 359)
	,(1000006, 5, 198)
	,(1000007, 7, 257)
	,(1000008, 1, 151)
	,(1000009, 3, 110)
GO

INSERT INTO ProductPhoto
(ProductID, PhotoPath)
VALUES
	(1000000, 'C:\Products\ProductPhotos\1000000')
	,(1000001, 'C:\Products\ProductPhotos\1000001')
	,(1000002, 'C:\Products\ProductPhotos\1000002' )
	,(1000003, 'C:\Products\ProductPhotos\1000003')
	,(1000004, 'C:\Products\ProductPhotos\1000004')
	,(1000005, 'C:\Products\ProductPhotos\1000005')
	,(1000006, 'C:\Products\ProductPhotos\1000006')
	,(1000007, 'C:\Products\ProductPhotos\1000007')
	,(1000008, 'C:\Products\ProductPhotos\1000008')
	,(1000009, 'C:\Products\ProductPhotos\1000009')
GO

/************************************************************
** \ \ \ \ \ \ \ \ \ \ \ \ END / / / / / / / / / / / / / / **
*************************************************************/