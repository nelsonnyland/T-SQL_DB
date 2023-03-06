USE MASTER
GO

/*************************************************************
**************************************************************
** Group 2: DBDogs											**
** Date Modified: 3/1/23									**
** Course: TCSS 445											**
** Database Project											**
**															**
** Auto Parts Store Schema (APS)							**
**															**
** Description:												**
** * This is a MS T-SQL document using MS SQL Server and	**
**   MSSMS as a DBMS.										**
** * This database supports auto parts inventory management	**
**   and related vendor information.						**
**															**
**************************************************************
*************************************************************/

IF DB_ID('APS') IS NOT NULL ALTER DATABASE APS SET SINGLE_USER WITH ROLLBACK IMMEDIATE
GO

IF DB_ID('APS') IS NOT NULL DROP DATABASE APS 
GO

CREATE DATABASE APS
GO

USE APS
GO

CREATE TABLE VENDOR
(
	ID				int				NOT NULL	PRIMARY KEY IDENTITY(1000000000, 1)
	,VendorName		varchar(50)		NOT NULL	CHECK(LEN(VendorName) > 1)
)
GO

CREATE TABLE LOCSITE
(
	ID				int				NOT NULL	PRIMARY KEY IDENTITY(1000000000, 1)
	,LocName		varchar(50)		NOT NULL	UNIQUE
	,LocStreet		varchar(50)		NOT NULL	CHECK(LEN(LocStreet) > 2)
	,LocCity		varchar(50)		NOT NULL	CHECK(LEN(LocCity) > 2)
	,LocState		char(2)			NOT NULL	CHECK(LocState LIKE '[A-Z][A-Z]')
	,LocCode		varchar(15)		NOT NULL	CHECK(LEN(LocCode) > 4)
)
GO

CREATE TABLE VEHICLE
(
	ID				int				NOT NULL	PRIMARY KEY IDENTITY(1000000000, 1)
	,VendorID		int				NOT NULL	FOREIGN KEY REFERENCES VENDOR(ID)	ON DELETE NO ACTION		ON UPDATE NO ACTION
	,VehMake		varchar(50)		NOT NULL	CHECK(LEN(VehMake) > 1)
	,VehModel		varchar(50)		NOT NULL	
	,VehYear		int				NOT NULL	CHECK(LEN(VehYear) = 4)
	,VehEngine		varchar(50)		NOT NULL	CHECK(LEN(VehEngine) > 1)
)
GO

CREATE TABLE INVOICE
(
	ID				int				NOT NULL	PRIMARY KEY IDENTITY(1000000000, 1)
	,VendorID		int				NOT NULL	FOREIGN KEY REFERENCES VENDOR(ID)	ON DELETE NO ACTION		ON UPDATE NO ACTION
	,InvoiceDesc	varchar(250)	NULL		DEFAULT ''
	,InvoiceDate	date			NOT NULL	DEFAULT GETDATE()	CHECK(InvoiceDate <= GETDATE())
	,InvoiceTotal	smallmoney		NOT NULL	DEFAULT 0			CHECK(InvoiceTotal > 0)
)
GO

CREATE TABLE STOCK
(
	ID				int				NOT NULL	PRIMARY KEY IDENTITY(1000000000, 1)
	,LocID			int				NOT NULL	FOREIGN KEY REFERENCES LOCSITE(ID)  ON DELETE NO ACTION		ON UPDATE NO ACTION
	,InvoiceID		int				NOT NULL	FOREIGN KEY REFERENCES INVOICE(ID)	ON DELETE NO ACTION		ON UPDATE NO ACTION
	,Qty			int				NOT NULL	DEFAULT 0
	,Price			smallmoney		NOT NULL	DEFAULT 0	CHECK(Price > 0)
)
GO

CREATE TABLE PART
(
	ID				int				NOT NULL	PRIMARY KEY IDENTITY(1000000000, 1)
	,VehID			int				NOT NULL	FOREIGN KEY REFERENCES VEHICLE(ID)	ON DELETE NO ACTION		ON UPDATE NO ACTION
	,VendorID		int				NOT NULL	FOREIGN KEY REFERENCES VENDOR(ID)	ON DELETE NO ACTION		ON UPDATE NO ACTION
	,StockID		int				NOT NULL	FOREIGN KEY REFERENCES STOCK(ID)	ON DELETE NO ACTION		ON UPDATE NO ACTION
	,PartName		varchar(50)		NOT NULL	CHECK(LEN(PartName) > 1)
	,PartDesc		varchar(250)	NULL		DEFAULT ''
)
GO

CREATE TABLE MERCHANDISE
(
	ID				int				NOT NULL	PRIMARY KEY IDENTITY(1000000000, 1)
	,VendorID		int				NOT NULL	FOREIGN KEY REFERENCES VENDOR(ID)	ON DELETE NO ACTION		ON UPDATE NO ACTION
	,StockID		int				NOT NULL	FOREIGN KEY REFERENCES STOCK(ID)	ON DELETE NO ACTION		ON UPDATE NO ACTION
	,MerchName		varchar(50)		NOT NULL	CHECK(LEN(MerchName) > 1)
	,MerchDesc		varchar(250)	NULL		DEFAULT ''
)
GO

CREATE TABLE EMPLOYEE
(
	ID				int				NOT NULL	PRIMARY KEY IDENTITY(1000000000, 1)
	,LocID			int				NOT NULL	FOREIGN KEY REFERENCES LOCSITE(ID)  ON DELETE NO ACTION		ON UPDATE NO ACTION
	,EmpFName		varchar(50)		NOT NULL	CHECK(LEN(EmpFName) > 2)
	,EmpLName		varchar(50)		NOT NULL	CHECK(LEN(EmpLName) > 2)
	,EmpPhone		varchar(15)		NOT NULL	UNIQUE CHECK(EmpPhone LIKE '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]')
	,EmpStreet		varchar(50)		NOT NULL	CHECK(LEN(EmpStreet) > 2)
	,EmpCity		varchar(15)		NOT NULL	CHECK(LEN(EmpCity) > 2)
	,EmpState		char(2)			NOT NULL	CHECK(EmpState LIKE '[A-Z][A-Z]')
	,EmpCode		varchar(15)		NOT NULL	CHECK(LEN(EmpCode) > 4)
)


/************************************************************
** \ \ \ \ \ \ \ \ \ \ \ \ END / / / / / / / / / / / / / / **
*************************************************************/
GO