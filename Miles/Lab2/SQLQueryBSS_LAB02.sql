/*
*MSSQL TavernDB table creation and population
*Date:	 9/15/2019
*Author: Jason Renna
*/
USE [JRenna_2019]
GO

/*Drop Tables*/
--drop SupplySales table
IF OBJECT_ID('dbo.SupplySales', 'U') IS NOT NULL DROP TABLE
dbo.SupplySales;
--drop Levels table
IF OBJECT_ID('dbo.Levels', 'U') IS NOT NULL DROP TABLE
dbo.Levels;
--drop Guests table
IF OBJECT_ID('dbo.Guests', 'U') IS NOT NULL DROP TABLE
dbo.Guests;
--drop GuestStatus table
IF OBJECT_ID('dbo.GuestStatus', 'U') IS NOT NULL DROP TABLE
dbo.GuestStatus;
--drop Classes table
IF OBJECT_ID('dbo.Classes', 'U') IS NOT NULL DROP TABLE
dbo.Classes;
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
--IF OBJECT_ID('dbo.BasementRats', 'U') IS NOT NULL DROP TABLE
--dbo.BasementRats;
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
--create Classes table
CREATE TABLE dbo.Classes(
	Id int NOT NULL IDENTITY(1, 1) Primary Key,
	Name varchar(50) NOT NULL
);
--create GuestStatus table
CREATE TABLE dbo.GuestStatus(
	Id int NOT NULL IDENTITY(1, 1) Primary Key,
	Name varchar(50) NOT NULL
);
--create Guests table
CREATE TABLE dbo.Guests(
	Id int NOT NULL IDENTITY(1, 1) Primary Key,
	Name varchar(250) NOT NULL,
	Notes varchar(MAX) NOT NULL,
	BirthDate date NOT NULL,
	CakeDay date NOT NULL,
	StatusId int NOT NULL FOREIGN KEY REFERENCES GuestStatus(Id)
);
--create Guests table
CREATE TABLE dbo.Levels(
	Id int NOT NULL IDENTITY(1, 1) Primary Key,
	GuestId int NOT NULL FOREIGN KEY REFERENCES Guests(Id),
	ClassId int NOT NULL FOREIGN KEY REFERENCES Classes(Id),
	Level int NOT NULL,
	Date date NOT NULL
);
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
	Id int NOT NULL IDENTITY(1, 1),
	Name varchar(250) NOT NULL,
	RoleId int NOT NULL
);
ALTER TABLE dbo.Users
ADD CONSTRAINT PK_Users PRIMARY KEY (Id),
	CONSTRAINT FK_Role FOREIGN KEY (RoleId) REFERENCES Roles(Id);

--create Taverns table
CREATE TABLE dbo.Taverns(
	Id int NOT NULL IDENTITY(1, 1),
	Name varchar(250) NOT NULL,
	LocationId int NOT NULL,
	OwnerId int NOT NULL,
	Floors int NOT NULL
);
ALTER TABLE dbo.Taverns
ADD CONSTRAINT PK_Taverns PRIMARY KEY (Id),
	CONSTRAINT FK_Location FOREIGN KEY (LocationId) REFERENCES Location(Id),
	CONSTRAINT FK_Owner FOREIGN KEY (OwnerId) REFERENCES Users(Id);
--create BasementRats table
--CREATE TABLE dbo.BasementRats(
--	Id int NOT NULL IDENTITY(1, 1) Primary Key,
--	Name varchar(100) NOT NULL,
--	TavernId int NOT NULL FOREIGN KEY REFERENCES Taverns(Id)
--);
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
CREATE TABLE dbo.SupplySales(
	Id int NOT NULL IDENTITY(1, 1) Primary Key,
	SupplyId int NOT NULL FOREIGN KEY REFERENCES Supplies(Id),
	SaleId int NOT NULL FOREIGN KEY REFERENCES Sales(Id),
	Date datetime NOT NULL
);
/*Populate Tables*/
--populate GuestStatus Data
INSERT INTO [dbo].[GuestStatus]
           ([Name])
     VALUES
           ('Sick'),
		   ('Angry'),
		   ('Happy'),
		   ('Sad'),
		   ('Nuetral');
--populate Guests Data
INSERT INTO [dbo].[Guests]
           ([Name]
           ,[Notes]
           ,[BirthDate]
           ,[CakeDay]
           ,[StatusId])
     VALUES
           ('John Doe','Very Reputable Adventurer','1975-04-11','2019-04-11',3),
		  ('Ricky Rocky','Rough personallity','1989-02-13','2019-02-13',2),
		  --insert error
		  --('Ricky Rocky','Rough personallity','1989-02-13','2019-02-13',6),
		  --
		  ('Matt Door','Needs a shower','1996-12-12','2019-12-12',1),
		  ('Laz Yee','Never goes on quests','1969-07-2','2019-07-2',4),
		  ('Mac Burg','Afraid of cows','1970-09-18','2019-09-18',4);
--populate Classes Data
INSERT INTO [dbo].[Classes]
           ([Name])
     VALUES
           ('Bard'),
		   ('Warrior'),
		   ('Cleric'),
		   ('Ranger'),
		   ('Wizzard');
--populate Levels Data
INSERT INTO [dbo].[Levels]
           ([GuestId]
           ,[ClassId]
		   ,[Level]
           ,[Date])
     VALUES
           (1,1,99,GETDATE()),
		   (2,3,45,GETDATE()),
		   --insert error
		   --(8,7,45,GETDATE()),
		   --
		   (3,4,23,GETDATE()),
		   (4,2,1,GETDATE()),
		   (5,5,12,GETDATE());
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
		   --insert error
		   --('Ricky Jacobs',9),
		   --
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
		   --insert error
		   --('The Gnome',3,8,2),
		   --
           ('The Gnome',3,1,2),
           ('Giants Lounge',4,1,5),
           ('Great Hills',5,1,2);
--populate BasementRats
--INSERT INTO [dbo].[BasementRats]
--           ([Name]
--           ,[TavernId])
--     VALUES
--			('Bob',1),
--			('Jack',2),
--			('Jim',3),
--            ('Mike',4),
--		    ('Sandy',5);
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
--populate SupplySales Data
INSERT INTO [dbo].[SupplySales]
           ([SupplyId]
           ,[SaleId]
           ,[Date])
     VALUES
           (1,1,GETDATE()),
		   (2,2,GETDATE()),
		   (1,3,GETDATE()),
		   (5,4,GETDATE()),
		   (4,5,GETDATE());
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
--SELECT * from BasementRats;
--Select SupplySales Data
SELECT * from SupplySales;
--Select Guests Data
SELECT * from Guests;
--Select Classes Data
SELECT * from Classes;
--Select Levels Data
SELECT * from Levels;
--Select GuestStatus Data
SELECT * from GuestStatus;
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

