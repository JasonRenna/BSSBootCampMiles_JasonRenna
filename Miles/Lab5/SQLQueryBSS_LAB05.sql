/*
*MSSQL TavernDB Assignment 5
*Date:	 9/25/2019
*Author: Jason Renna
*/
USE [JRenna_2019]
GO

--1
select concat(Users.Name,': ',Roles.Name,', ',Roles.Description) as Report from Users
	join roles on Users.RoleId = Roles.Id;

--2
select Classes.Name as 'Class', count(Guests.Id) as 'Count' from classes 
	join Levels on Classes.Id = Levels.ClassId
	join Guests on Levels.GuestId = Guests.Id
	group by Classes.Name;

--3
select Guests.Name as Guest, Classes.Name as 'Class', Levels.Level,  
		(Case when Levels.Level <=5 then 'Beginner (lvl 1-5)' 
		      when Levels.Level >=5  and Levels.Level <=10 then 'Intermediate (lvl 5-10)'
		      when Levels.Level >=10 then 'Expert (lvl 10+)' end) as Experience
		from classes
	join Levels on Classes.Id = Levels.ClassId
	join Guests on Levels.GuestId = Guests.Id
	order by Guest ASC;

--4
DROP FUNCTION IF EXISTS dbo.LevelGrouping; 
GO  
create function dbo.LevelGrouping(@level int)
returns varchar(100)
as
begin
	declare @group varchar(100);
	if (@Level is null)
		set @group = 'No Grouping'
	if (@Level < 1)
		set @group = 'Out of Bounds'
	if (@Level >= 1 and @Level <= 5)
		set @group = 'lvl 1-5'
	if (@Level >= 5 and @Level <= 10)
		set @group = 'lvl 5-10'
	if (@Level >= 10 and @Level <= 15)
		set @group = 'lvl 10-15'
	if (@Level >= 15 and @Level <= 20)
		set @group = 'lvl 15-20'
	if (@Level > 20)
		set @group = 'lvl 20+, VERY HIGH LEVEL'
	return @group
end;
GO
select dbo.LevelGrouping(2);
select dbo.LevelGrouping(1);
select dbo.LevelGrouping(5);
select dbo.LevelGrouping(11);
select dbo.LevelGrouping(16);
select dbo.LevelGrouping(21);

--5
DROP FUNCTION IF EXISTS dbo.RoomAvalability; 
GO  
create function dbo.RoomAvalability(@date date)
returns TABLE
as
return
(
select Taverns.Name as Tavern, Rooms.Id as RoomId, 
(case when Roomlog.date = @date then 'Full' else 'Open' end) as 'Room Status'
from Rooms
	join RoomLog on Rooms.Id = RoomLog.RoomId
	join Taverns on Rooms.TavernId = Taverns.Id
);
GO
select * from dbo.RoomAvalability('2019-09-10');
select * from dbo.RoomAvalability('2019-09-11');
select * from dbo.RoomAvalability('2019-09-12');
select * from dbo.RoomAvalability('2019-09-15');
select * from dbo.RoomAvalability('2019-09-21');
select * from dbo.RoomAvalability('2019-09-22');
select * from dbo.RoomAvalability('2019-09-17');

--6
DROP FUNCTION IF EXISTS dbo.RoomPriceRange; 
GO  
create function dbo.RoomPriceRange(@min int, @max int)
returns TABLE
as
return
(
select Taverns.Name as Tavern, Rooms.Id as RoomId, Rooms.Rate as Rate
from Rooms
	join RoomLog on Rooms.Id = RoomLog.RoomId
	join Taverns on Rooms.TavernId = Taverns.Id
	where @min <= Rate and @max >= Rate
);
GO
select * from dbo.RoomPriceRange(0,50);
select * from dbo.RoomPriceRange(50,200);
select * from dbo.RoomPriceRange(0,200);
select * from dbo.RoomPriceRange(200,300);
select * from dbo.RoomPriceRange(300,400);
select * from dbo.RoomPriceRange(75,100);

--7
insert into [dbo].[Rooms]
       select Top 1 2 as StatusId, (select Top 1 Taverns.Id from Taverns where Taverns.Name != Tavern) as TavernId, Rate-0.01 as Rate from dbo.RoomPriceRange(50,200)
	where Rate = (select min(Rate)from dbo.RoomPriceRange(50,200));

select * from Rooms;

