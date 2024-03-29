/*
*MSSQL TavernDB table select
*Date:	 9/11/2019
*Author: Jason Renna
*/
USE [JRenna_2019]
GO
--Select BasementRats Data
SELECT [Id]
      ,[Name]
      ,[TavernId]
  FROM [dbo].[BasementRats]
GO
--Select Inventory Data
SELECT [Id]
      ,[SupplyId]
      ,[TavernId]
      ,[Quanity]
      ,[Date]
  FROM [dbo].[Inventory]
GO
--Select Location Data
SELECT [Id]
      ,[Name]
  FROM [dbo].[Location]
GO
--Select Roles Data
SELECT [Id]
      ,[Name]
      ,[Description]
  FROM [dbo].[Roles]
GO
--Select Sales Data
SELECT [Id]
      ,[ServiceId]
      ,[GuestId]
      ,[TavernId]
      ,[Price]
      ,[Quanity]
      ,[Date]
  FROM [dbo].[Sales]
GO
--Select Services Data
SELECT [Id]
      ,[Name]
      ,[StatusId]
  FROM [dbo].[Services]
GO
--Select Status Data
SELECT [Id]
      ,[Status]
  FROM [dbo].[Status]
GO
--Select Supplies Data
SELECT [Id]
      ,[Name]
      ,[Unit]
  FROM [dbo].[Supplies]
GO
--Select Taverns Data
SELECT [Id]
      ,[Name]
      ,[LocationId]
      ,[OwnerId]
      ,[Floors]
  FROM [dbo].[Taverns]
GO
--Select Users Data
SELECT [Id]
      ,[Name]
      ,[RoleId]
  FROM [dbo].[Users]
GO
--Select Receipts Data
SELECT [Id]
      ,[SupplyId]
      ,[TavernId]
      ,[cost]
      ,[Quanity]
      ,[Date]
  FROM [dbo].[Receipts]
GO














