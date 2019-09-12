/*
*MSSQL TavernDB table creation and population
*Date:	 9/12/2019
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
/*Populate Tables*/
--populate Roles
INSERT INTO dbo.Roles
           ([Name]
           ,[Description])
     VALUES
           ('Owner','Owner of Tavern'),
           ('Customer','Customer of Tavern'),
           ('Bartender','Provides drink services'),
           ('Waitress','Serves the customers'),
           ('Cleaner','Cleans the Tavern'),
           ('Cook','Cooks the food for the customers');
--populate Users
INSERT INTO [dbo].[Users]
           ([Name]
           ,[RoleId])
     VALUES
           ('Jason Renna',1),
           ('Joe Smith',2),
           ('Ricky Jacobs',3),
           ('Mary Luck',4),
           ('Jack Mars',2),
           ('Lucy Landers',5),
           ('Joe Yander',6);
--populate Location
INSERT INTO [dbo].[Location]
           ([Name])
     VALUES
           ('Mount Holly'),
           ('Lumberton'),
           ('Burlington'),
           ('Pemberton'),
           ('Hainesport');
--populate Taverns
INSERT INTO [dbo].[Taverns]
           ([Name]
           ,[LocationId]
           ,[OwnerId]
           ,[Floors])
     VALUES
           ('Shield',1,1,3),
		   ('Sword',2,1,3),
           ('The Gnome',3,1,2),
           ('Giants Lounge',4,1,5),
           ('Great Hills',5,1,2);
--populate BasementRats
INSERT INTO [dbo].[BasementRats]
           ([Name]
           ,[TavernId])
     VALUES
			('Bob',1),
			('Jack',2),
			('Jim',3),
            ('Mike',4),
		    ('Sandy',5);
--populate Supplies
INSERT INTO [dbo].[Supplies]
           ([Name]
           ,[Unit])
     VALUES
           ('Water','ounce'),
		   ('Fire Breath','strong ale'),
		   ('Tea','cup'),
		   ('Lamb','pound'),
		   ('Rice','cup');
--populate Inventory
INSERT INTO [dbo].[Inventory]
           ([SupplyId]
           ,[TavernId]
           ,[Quanity]
           ,[Date])
     VALUES
           (1,1,100,GETDATE()),
		   (2,1,500,GETDATE()),
		   (3,1,300,GETDATE()),
		   (4,1,70,GETDATE()),
		   (5,1,400,GETDATE());
--populate Status
INSERT INTO [dbo].[Status]
           ([Status])
     VALUES
           ('active'),
		   ('inactive'),
		   ('out of stock'),
		   ('discontinued'),
		   ('discounted');
--populate Services
INSERT INTO [dbo].[Services]
           ([Name]
           ,[StatusId])
     VALUES
           ('Bar',1),
		   ('Cleaning',2),
		   ('Trinkets',3),
		   ('Pool',4),
		   ('Dinner',5);
--populate Sales
INSERT INTO [dbo].[Sales]
           ([ServiceId]
           ,[GuestId]
           ,[TavernId]
           ,[Price]
           ,[Quanity]
           ,[Date])
     VALUES
           (1,2,1,16.12,4,GETDATE()),
		   (1,5,1,56.23,10,GETDATE()),
		   (2,2,1,36.51,1,GETDATE()),
		   (3,2,1,76.45,1,GETDATE()),
		   (4,2,1,20.22,1,GETDATE()),
		   (5,5,1,16.11,1,GETDATE());
--populate Receipts
INSERT INTO [dbo].[Receipts]
           ([SupplyId]
           ,[TavernId]
           ,[cost]
           ,[Quanity]
           ,[Date])
     VALUES
           (1,1,54.23,21,GETDATE()),
		   (2,1,67.25,20,GETDATE()),
		   (3,1,88.93,1,GETDATE()),
		   (4,1,99.13,61,GETDATE()),
		   (5,1,53.22,81,GETDATE());
/*Table Selects*/
--Select BasementRats Data
SELECT * from BasementRats;
--Select Inventory Data
SELECT * from Inventory;
--Select Location Data
SELECT * from Location;
--Select Roles Data
SELECT * from Roles;
--Select Sales Data
SELECT * from Sales;
--Select Services Data
SELECT * from Services;
--Select Status Data
SELECT * from Status;
--Select Supplies Data
SELECT * from Supplies;
--Select Taverns Data
SELECT * from Taverns;
--Select Users Data
SELECT * from Users;
--Select Receipts Data
SELECT * from Receipts;

