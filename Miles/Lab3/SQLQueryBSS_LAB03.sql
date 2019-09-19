/*
*MSSQL TavernDB table creation and population for Assignment 3
*Date:	 9/18/2019
*Author: Jason Renna
*/
USE [JRenna_2019]
GO

/*Drop Tables*/
--drop RoomStatus table
IF OBJECT_ID('dbo.RoomLog', 'U') IS NOT NULL DROP TABLE
dbo.RoomLog;
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
--drop Sales table
IF OBJECT_ID('dbo.Sales', 'U') IS NOT NULL DROP TABLE
dbo.Sales;
--drop Services table
IF OBJECT_ID('dbo.Services', 'U') IS NOT NULL DROP TABLE
dbo.Services;
--drop Rooms table
IF OBJECT_ID('dbo.Rooms', 'U') IS NOT NULL DROP TABLE
dbo.Rooms;
--drop RoomStatus table
IF OBJECT_ID('dbo.RoomStatus', 'U') IS NOT NULL DROP TABLE
dbo.RoomStatus;




/*Create Tables*/
--create RoomStatus table
CREATE TABLE dbo.RoomStatus(
	Id int NOT NULL IDENTITY(1, 1) Primary Key,
	Name varchar(250) NULL,
);
--create Rooms table
CREATE TABLE dbo.Rooms(
	Id int NOT NULL IDENTITY(1, 1) Primary Key,
	StatusId int NOT NULL FOREIGN KEY REFERENCES RoomStatus(Id),
	TavernId int NOT NULL FOREIGN KEY REFERENCES Taverns(Id)
);
--create Services table
CREATE TABLE dbo.Services(
	Id int NOT NULL IDENTITY(1, 1) Primary Key,
	Name varchar(50) NOT NULL,
	StatusId int NOT NULL FOREIGN KEY REFERENCES Status(Id)
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
CREATE TABLE dbo.SupplySales(
	Id int NOT NULL IDENTITY(1, 1) Primary Key,
	SupplyId int NOT NULL FOREIGN KEY REFERENCES Supplies(Id),
	SaleId int NOT NULL FOREIGN KEY REFERENCES Sales(Id),
	Date datetime NOT NULL
);
--create RoomLog table
CREATE TABLE dbo.RoomLog(
	Id int NOT NULL IDENTITY(1, 1) Primary Key,
	SaleId int NOT NULL FOREIGN KEY REFERENCES Sales(Id),
	GuestId int NOT NULL FOREIGN KEY REFERENCES Guests(Id),
	RoomId int NOT NULL FOREIGN KEY REFERENCES Rooms(Id),
	date datetime NOT NULL,
	rate int NOT NULL
);
/*Populate Tables*/
--populate RoomStatus
INSERT INTO [dbo].[RoomStatus]
           ([Name])
     VALUES
           ('Open'),
		   ('Occupied');
--populate Rooms
INSERT INTO [dbo].[Rooms]
           ([StatusId]
           ,[TavernId])
     VALUES
           (2,1),
		   (2,1),
		   (2,1),
		   (1,1),
		   (2,2),
		   (2,3),
		   (2,4),
		   (2,5);
--populate Services
INSERT INTO [dbo].[Services]
           ([Name]
           ,[StatusId])
     VALUES
           ('Bar',1),
		   ('Cleaning',2),
		   ('Trinkets',3),
		   ('Pool',4),
		   ('Dinner',5),
		   ('Room',5);
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
		   (5,5,1,16.11,1,GETDATE()),
		   (6,1,1,500,1,GETDATE()),
		   (6,2,1,200,1,GETDATE()),
		   (6,3,1,100,1,GETDATE()),
		   (6,4,2,25,1,GETDATE()),
		   (6,5,3,50,1,GETDATE()),
		   (6,6,4,250,1,GETDATE()),
		   (6,7,5,400,1,GETDATE());
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
		  ('Matt Door','Needs a shower','1996-12-12','2019-12-12',1),
		  ('Laz Yee','Never goes on quests','1969-07-2','2019-07-2',4),
		  ('Mac Burg','Afraid of cows','1970-09-18','2019-09-18',4),
		  ('Max Pro','Very good','2011-07-2','2019-07-2',3),
		  ('Rick Roll','Never gonna...','2001-09-18','2019-09-18',3),
		  ('Rick Roll','you up...','2001-09-18','2019-09-18',3);
--populate RoomLog Data
INSERT INTO [dbo].[RoomLog]
           ([SaleId]
           ,[GuestId]
		   ,[RoomId]
           ,[date]
           ,[rate])
     VALUES
			(7,1,1,GETDATE(),50),
			(8,2,2,GETDATE(),50),
			(9,3,3,GETDATE(),50),
			(10,4,5,GETDATE(),25),
			(11,5,6,GETDATE(),25),
			(12,6,7,GETDATE(),50),
			(13,7,8,GETDATE(),200);
--populate Levels Data
INSERT INTO [dbo].[Levels]
           ([GuestId]
           ,[ClassId]
		   ,[Level]
           ,[Date])
     VALUES
           (1,1,99,GETDATE()),
		   (2,3,45,GETDATE()),
		   (3,4,23,GETDATE()),
		   (4,2,1,GETDATE()),
		   (5,5,12,GETDATE());

/*Table Selects*/
--Select Guests Data
SELECT * from Guests;
--Select Sales Data
SELECT * from Sales;
--Select Services Data
SELECT * from Services;
--Select RoomLog Data
SELECT * from RoomLog;
--Select Rooms Data
SELECT * from Rooms;
--Select RoomStatus Data
SELECT * from RoomStatus;

/*Assignment Queries*/
--2
SELECT * from Guests where BirthDate < '2000-1-1';
--3
SELECT * from RoomLog where rate > 100;
--4
SELECT Distinct Name from Guests;
--5
SELECT Name from Guests order by Name ASC;
--6
SELECT TOP 10 * from Sales order by Price desc;
--7
select TABLE_NAME from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME = 'Classes'
UNION
select TABLE_NAME from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME = 'GuestStatus'
UNION
select TABLE_NAME from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME = 'Location'
UNION
select TABLE_NAME from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME = 'Roles'
UNION
select TABLE_NAME from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME = 'RoomStatus'
UNION
select TABLE_NAME from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME = 'Status'
UNION
select TABLE_NAME from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME = 'Supplies';
--8
SELECT Guests.Name, Guests.Notes, Level, Classes.Name, 
	(Case when level < 10 then '1-10'
		when level > 10 and level < 20 then '10-20' 
		when level > 20 and level < 30 then '20-30' 
		when level > 30 and level < 40 then '30-40' 
		when level > 40 and level < 50 then '40-50' 
		when level > 50 and level < 60 then '50-60' 
		when level > 60 and level < 70 then '60-70' 
		when level > 70 and level < 80 then '70-80' 
		when level > 80 and level < 90 then '80-90' 
		when level > 90 and level < 100 then '90-100' 
		end) As 'Level Range'
    from Levels 
	JOIN Guests on (GuestId = Guests.Id) 
	JOIN Classes on (ClassId = Classes.Id);
--9
INSERT INTO [dbo].[RoomStatus]
       SELECT Name from GuestStatus;


