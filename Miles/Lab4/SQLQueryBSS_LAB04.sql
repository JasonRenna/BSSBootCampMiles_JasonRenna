/*
*MSSQL TavernDB Query Assignment 4
*Date:	 9/22/2019
*Author: Jason Renna
*/
USE [JRenna_2019]
GO

--1
select * from Users
	join Roles	on RoleId = Roles.Id
	where Roles.Name = 'Owner';

--2
select distinct Users.Name from Users
	join Roles	on RoleId = Roles.Id
	join Taverns on Users.Id = Taverns.OwnerId
	where Roles.Name = 'Owner' and not Taverns.OwnerId is null;

--3
select Guests.Name, Classes.Name as Class, Levels.Level from Guests
	join levels on Guests.Id = Levels.GuestId
	join Classes on Levels.ClassId = Classes.Id
	order by Guests.Name ASC, Classes.Name, Levels.Level;

--4
select Top 10 Sales.Id, Services.Name as Service, Sales.Price, Sales.Quanity from sales
	join Services on ServiceId = Services.Id
	order by Sales.Price DESC;

--5
select Guests.Name, count(Classes.Name) as Total_Classes FROM Levels
	join Guests on GuestId = Guests.id
	JOIN Classes on ClassId = Classes.id
group by Guests.Name
having count(Classes.Name) > 1; 

--6
select Guests.Name, count(Classes.Name) as Total_Classes FROM Levels
	join Guests on GuestId = Guests.id
	JOIN Classes on ClassId = Classes.id
where level > 5
group by Guests.Name
having count(Classes.Name) > 1; 

--7
select Guests.Name, max(level) as Highest_level FROM Levels
	join Guests on GuestId = Guests.id
	JOIN Classes on ClassId = Classes.id
group by Guests.Name; 

--8
select Guests.Name from RoomLog
	join Guests on GuestId = Guests.Id
where date between '2019-09-20' and '2019-09-25';
 
 --9
SELECT 
CONCAT('CREATE TABLE ',TABLE_NAME, ' (') as queryPiece 
FROM INFORMATION_SCHEMA.TABLES
 WHERE TABLE_NAME = 'Taverns'
UNION ALL
SELECT CONCAT(cols.COLUMN_NAME, ' ', cols.DATA_TYPE, 
(
	CASE WHEN CHARACTER_MAXIMUM_LENGTH IS NOT NULL 
	Then CONCAT
		('(', CAST(CHARACTER_MAXIMUM_LENGTH as varchar(100)), ')') 
	Else '' 
	END)
,
	CASE WHEN refConst.CONSTRAINT_NAME IS NULL and cols.ORDINAL_POSITION = 1
	Then 
		(' IDENTITY(1, 1) Primary Key') 
	Else '' 
	END
,
	CASE WHEN refConst.CONSTRAINT_NAME IS NOT NULL
	Then 
		(CONCAT(' FOREIGN KEY REFERENCES ', constKeys.TABLE_NAME, '(', constKeys.COLUMN_NAME, ')')) 
	Else '' 
	END
, 
',') as queryPiece FROM 
INFORMATION_SCHEMA.COLUMNS as cols
LEFT JOIN INFORMATION_SCHEMA.KEY_COLUMN_USAGE as keys ON 
(keys.TABLE_NAME = cols.TABLE_NAME and keys.COLUMN_NAME = cols.COLUMN_NAME)
LEFT JOIN INFORMATION_SCHEMA.REFERENTIAL_CONSTRAINTS as refConst ON 
(refConst.CONSTRAINT_NAME = keys.CONSTRAINT_NAME)
LEFT JOIN 
(SELECT DISTINCT CONSTRAINT_NAME, TABLE_NAME, COLUMN_NAME 
FROM INFORMATION_SCHEMA.KEY_COLUMN_USAGE) as constKeys 
ON (constKeys.CONSTRAINT_NAME = refConst.UNIQUE_CONSTRAINT_NAME)
 WHERE cols.TABLE_NAME = 'Taverns'
UNION ALL
SELECT ')'; 