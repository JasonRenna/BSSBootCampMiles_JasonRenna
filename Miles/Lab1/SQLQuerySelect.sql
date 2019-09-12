USE [JRenna_2019]
GO

SELECT [Id]
      ,[Name]
      ,[TavernId]
  FROM [dbo].[BasementRats]
GO
SELECT [Id]
      ,[SupplyId]
      ,[TavernId]
      ,[Quanity]
      ,[Date]
  FROM [dbo].[Inventory]
GO
SELECT [Id]
      ,[Name]
  FROM [dbo].[Location]
GO
SELECT [Id]
      ,[Name]
      ,[Description]
  FROM [dbo].[Roles]
GO
SELECT [Id]
      ,[ServiceId]
      ,[GuestId]
      ,[TavernId]
      ,[Price]
      ,[Quanity]
      ,[Date]
  FROM [dbo].[Sales]
GO
SELECT [Id]
      ,[Name]
      ,[StatusId]
  FROM [dbo].[Services]
GO
SELECT [Id]
      ,[Status]
  FROM [dbo].[Status]
GO
SELECT [Id]
      ,[Name]
      ,[Unit]
  FROM [dbo].[Supplies]
GO
SELECT [Id]
      ,[Name]
      ,[LocationId]
      ,[OwnerId]
      ,[Floors]
  FROM [dbo].[Taverns]
GO
SELECT [Id]
      ,[Name]
      ,[RoleId]
  FROM [dbo].[Users]
GO
SELECT [Id]
      ,[SupplyId]
      ,[TavernId]
      ,[cost]
      ,[Quanity]
      ,[Date]
  FROM [dbo].[Receipts]
GO














