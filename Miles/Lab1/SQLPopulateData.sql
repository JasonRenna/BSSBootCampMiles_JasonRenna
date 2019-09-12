USE [JRenna_2019]
GO

INSERT INTO dbo.Roles
           ([Name]
           ,[Description])
     VALUES
           ('Owner','Owner of Tavern'),
           ('Customer','Customer of Tavern'),
           ('Bartender','Provides drink services'),
           ('Waitress','Serves the customers'),
           ('Cleaner','Cleans the Tavern'),
           ('Cook','Cooks the food for the customers')
GO
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
           ('Joe Yander',6)
GO
INSERT INTO [dbo].[Location]
           ([Name])
     VALUES
           ('Mount Holly'),
           ('Lumberton'),
           ('Burlington'),
           ('Pemberton'),
           ('Hainesport')
GO
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
           ('Great Hills',5,1,2)
GO
INSERT INTO [dbo].[BasementRats]
           ([Name]
           ,[TavernId])
     VALUES
			('Bob',1),
			('Jack',2),
			('Jim',3),
            ('Mike',4),
		    ('Sandy',5)
GO
INSERT INTO [dbo].[Supplies]
           ([Name]
           ,[Unit])
     VALUES
           ('Water','ounce'),
		   ('Fire Breath','strong ale'),
		   ('Tea','cup'),
		   ('Lamb','pound'),
		   ('Rice','cup')
GO
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
		   (5,1,400,GETDATE())
GO
INSERT INTO [dbo].[Status]
           ([Status])
     VALUES
           ('active'),
		   ('inactive'),
		   ('out of stock'),
		   ('discontinued'),
		   ('discounted')
GO
INSERT INTO [dbo].[Services]
           ([Name]
           ,[StatusId])
     VALUES
           ('Bar',1),
		   ('Cleaning',2),
		   ('Trinkets',3),
		   ('Pool',4),
		   ('Dinner',5)
GO
USE [JRenna_2019]
GO

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
		   (5,5,1,16.11,1,GETDATE())
GO
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
		   (5,1,53.22,81,GETDATE())
GO




















