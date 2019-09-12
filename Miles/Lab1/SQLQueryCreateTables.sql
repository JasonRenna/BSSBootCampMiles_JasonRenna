/*
*MSSQL TavernDB table creation
*Date:	 9/11/2019
*Author: Jason Renna
*/
USE [JRenna_2019]
GO

/*Drop Tables*/
--drop Receipts table
IF OBJECT_ID('dbo.Receipts', 'U') IS NOT NULL DROP TABLE
dbo.Receipts;
--drop Sales table
IF OBJECT_ID('dbo.Sales', 'U') IS NOT NULL DROP TABLE
dbo.Sales;
--drop Inventory table
IF OBJECT_ID('dbo.Inventory', 'U') IS NOT NULL DROP TABLE
dbo.Inventory;
--drop BasementRats table
IF OBJECT_ID('dbo.BasementRats', 'U') IS NOT NULL DROP TABLE
dbo.BasementRats;
--drop Taverns table
IF OBJECT_ID('dbo.Taverns', 'U') IS NOT NULL DROP TABLE
dbo.Taverns;
--drop Users table
IF OBJECT_ID('dbo.Users', 'U') IS NOT NULL DROP TABLE
dbo.Users;
--drop Roles table
IF OBJECT_ID('dbo.Roles', 'U') IS NOT NULL DROP TABLE
dbo.Roles;
--drop Location table
IF OBJECT_ID('dbo.Location', 'U') IS NOT NULL DROP TABLE
dbo.Location;
--drop Supplies table
IF OBJECT_ID('dbo.Supplies', 'U') IS NOT NULL DROP TABLE
dbo.Supplies;
--drop Services table
IF OBJECT_ID('dbo.Services', 'U') IS NOT NULL DROP TABLE
dbo.Services;
--drop Status table
IF OBJECT_ID('dbo.Status', 'U') IS NOT NULL DROP TABLE
dbo.Status;

/*Create Tables*/
--create Status table
CREATE TABLE dbo.Status(
	Id int NOT NULL IDENTITY(1, 1) Primary Key,
	Status varchar(50) NOT NULL
);
--create Services table
CREATE TABLE dbo.Services(
	Id int NOT NULL IDENTITY(1, 1) Primary Key,
	Name varchar(50) NOT NULL,
	StatusId int NOT NULL FOREIGN KEY REFERENCES Status(Id)
);
--create Supplies table
CREATE TABLE dbo.Supplies(
	Id int NOT NULL IDENTITY(1, 1) Primary Key,
	Name varchar(50) NOT NULL,
	Unit varchar(50) NOT NULL
);
--create Location table
CREATE TABLE dbo.Location(
	Id int NOT NULL IDENTITY(1, 1) Primary Key,
	Name varchar(100) NOT NULL
);
--create Roles table
CREATE TABLE dbo.Roles(
	Id int NOT NULL IDENTITY(1, 1) Primary Key,
	Name varchar(50) NOT NULL ,
	Description varchar(max) NOT NULL
);
--create Users table
CREATE TABLE dbo.Users(
	Id int NOT NULL IDENTITY(1, 1) Primary Key,
	Name varchar(250) NOT NULL,
	RoleId int NOT NULL FOREIGN KEY REFERENCES Roles(Id)
);
--create Taverns table
CREATE TABLE dbo.Taverns(
	Id int NOT NULL IDENTITY(1, 1) Primary Key,
	Name varchar(250) NOT NULL,
	LocationId int NOT NULL REFERENCES Location(Id),
	OwnerId int NOT NULL REFERENCES Users(Id),
	Floors int NOT NULL
);
--create BasementRats table
CREATE TABLE dbo.BasementRats(
	Id int NOT NULL IDENTITY(1, 1) Primary Key,
	Name varchar(100) NOT NULL,
	TavernId int NOT NULL FOREIGN KEY REFERENCES Taverns(Id)
);
--create Inventory table
CREATE TABLE dbo.Inventory(
	Id int NOT NULL IDENTITY(1, 1) Primary Key,
	SupplyId int NOT NULL FOREIGN KEY REFERENCES Supplies(Id),
	TavernId int NOT NULL FOREIGN KEY REFERENCES Taverns(Id),
	Quanity int NOT NULL,
	Date datetime NOT NULL
);
--create Receipts table
CREATE TABLE dbo.Receipts(
	Id int NOT NULL IDENTITY(1, 1) Primary Key,
	SupplyId int NOT NULL FOREIGN KEY REFERENCES Supplies(Id),
	TavernId int NOT NULL FOREIGN KEY REFERENCES Taverns(Id),
	cost float(2) NOT NULL,
	Quanity int NOT NULL,
	Date datetime NOT NULL
);
--create Sales table
CREATE TABLE dbo.Sales(
	Id int NOT NULL IDENTITY(1, 1) Primary Key,
	ServiceId int NOT NULL FOREIGN KEY REFERENCES Services(Id),
	GuestId int NOT NULL FOREIGN KEY REFERENCES Users(Id),
	TavernId int NOT NULL FOREIGN KEY REFERENCES Taverns(Id),
	Price float(2) NOT NULL,
	Quanity int NOT NULL,
	Date datetime NOT NULL
);


