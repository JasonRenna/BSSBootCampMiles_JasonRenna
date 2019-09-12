USE [JRenna_2019]
GO

IF OBJECT_ID('dbo.Receipts', 'U') IS NOT NULL DROP TABLE
dbo.Receipts;
IF OBJECT_ID('dbo.Sales', 'U') IS NOT NULL DROP TABLE
dbo.Sales;
IF OBJECT_ID('dbo.Inventory', 'U') IS NOT NULL DROP TABLE
dbo.Inventory;
IF OBJECT_ID('dbo.BasementRats', 'U') IS NOT NULL DROP TABLE
dbo.BasementRats;
IF OBJECT_ID('dbo.Taverns', 'U') IS NOT NULL DROP TABLE
dbo.Taverns;
IF OBJECT_ID('dbo.Users', 'U') IS NOT NULL DROP TABLE
dbo.Users;
IF OBJECT_ID('dbo.Roles', 'U') IS NOT NULL DROP TABLE
dbo.Roles;
IF OBJECT_ID('dbo.Location', 'U') IS NOT NULL DROP TABLE
dbo.Location;
IF OBJECT_ID('dbo.Supplies', 'U') IS NOT NULL DROP TABLE
dbo.Supplies;
IF OBJECT_ID('dbo.Services', 'U') IS NOT NULL DROP TABLE
dbo.Services;
IF OBJECT_ID('dbo.Status', 'U') IS NOT NULL DROP TABLE
dbo.Status;

CREATE TABLE dbo.Status(
	Id int NOT NULL IDENTITY(1, 1) Primary Key,
	Status varchar(50) NOT NULL
);
CREATE TABLE dbo.Services(
	Id int NOT NULL IDENTITY(1, 1) Primary Key,
	Name varchar(50) NOT NULL,
	StatusId int NOT NULL FOREIGN KEY REFERENCES Status(Id)
);
CREATE TABLE dbo.Supplies(
	Id int NOT NULL IDENTITY(1, 1) Primary Key,
	Name varchar(50) NOT NULL,
	Unit varchar(50) NOT NULL
);
CREATE TABLE dbo.Location(
	Id int NOT NULL IDENTITY(1, 1) Primary Key,
	Name varchar(100) NOT NULL
);
CREATE TABLE dbo.Roles(
	Id int NOT NULL IDENTITY(1, 1) Primary Key,
	Name varchar(50) NOT NULL ,
	Description varchar(max) NOT NULL
);
CREATE TABLE dbo.Users(
	Id int NOT NULL IDENTITY(1, 1) Primary Key,
	Name varchar(250) NOT NULL,
	RoleId int NOT NULL FOREIGN KEY REFERENCES Roles(Id)
);
CREATE TABLE dbo.Taverns(
	Id int NOT NULL IDENTITY(1, 1) Primary Key,
	Name varchar(250) NOT NULL,
	LocationId int NOT NULL REFERENCES Location(Id),
	OwnerId int NOT NULL REFERENCES Users(Id),
	Floors int NOT NULL
);
CREATE TABLE dbo.BasementRats(
	Id int NOT NULL IDENTITY(1, 1) Primary Key,
	Name varchar(100) NOT NULL,
	TavernId int NOT NULL FOREIGN KEY REFERENCES Taverns(Id)
);
CREATE TABLE dbo.Inventory(
	Id int NOT NULL IDENTITY(1, 1) Primary Key,
	SupplyId int NOT NULL FOREIGN KEY REFERENCES Supplies(Id),
	TavernId int NOT NULL FOREIGN KEY REFERENCES Taverns(Id),
	Quanity int NOT NULL,
	Date datetime NOT NULL
);
CREATE TABLE dbo.Receipts(
	Id int NOT NULL IDENTITY(1, 1) Primary Key,
	SupplyId int NOT NULL FOREIGN KEY REFERENCES Supplies(Id),
	TavernId int NOT NULL FOREIGN KEY REFERENCES Taverns(Id),
	cost float(2) NOT NULL,
	Quanity int NOT NULL,
	Date datetime NOT NULL
);
CREATE TABLE dbo.Sales(
	Id int NOT NULL IDENTITY(1, 1) Primary Key,
	ServiceId int NOT NULL FOREIGN KEY REFERENCES Services(Id),
	GuestId int NOT NULL FOREIGN KEY REFERENCES Users(Id),
	TavernId int NOT NULL FOREIGN KEY REFERENCES Taverns(Id),
	Price float(2) NOT NULL,
	Quanity int NOT NULL,
	Date datetime NOT NULL
);


