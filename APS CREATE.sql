/*************************************************************
**************************************************************
** Group 2: DBDogs											**
** Date Modified: 2/9/23									**
** Course: TCSS 445											**
** Database Project											**
**															**
** Auto Parts Store Schema (APS)							**
**															**
** This database supports APS inventory	management and		**
** vendor information.										**
**															**
**************************************************************
*************************************************************/

USE MASTER
GO

IF DB_ID('APS') IS NOT NULL ALTER DATABASE APS SET SINGLE_USER WITH ROLLBACK IMMEDIATE
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
	,AutoID			int				NOT NULL	FOREIGN KEY REFERENCES [AUTO](ID)	ON DELETE NO ACTION		ON UPDATE NO ACTION
	,VendorID		int				NOT NULL	FOREIGN KEY REFERENCES VENDOR(ID)	ON DELETE NO ACTION		ON UPDATE NO ACTION
	,PartName		varchar(50)		NOT NULL	CHECK(LEN(PartName) > 1)
	,PartDesc		varchar(250)	NULL		DEFAULT ''
	,PartQty		int				NOT NULL	DEFAULT 0
	,PartPrice		smallmoney		NOT NULL	CHECK(PartPrice > 0)
)
GO

CREATE TABLE MERCHANDISE
(
	ID				int				NOT NULL	PRIMARY KEY IDENTITY(1000000000, 1)
	,VendorID		int				NOT NULL	FOREIGN KEY REFERENCES VENDOR(ID)	ON DELETE NO ACTION		ON UPDATE NO ACTION
	,MerchName		varchar(50)		NOT NULL	CHECK(LEN(MerchName) > 1)
	,MerchDesc		varchar(250)	NULL		DEFAULT ''
	,MerchQty		int				NOT NULL	DEFAULT 0
	,MerchPrice		smallmoney		NOT NULL	CHECK(MerchPrice > 0)
)
GO

/************************************************************
** \ \ \ \ \ \ \ \ \ \ \ \ END / / / / / / / / / / / / / / **
*************************************************************/