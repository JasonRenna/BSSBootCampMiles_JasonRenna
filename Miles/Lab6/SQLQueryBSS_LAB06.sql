USE [JRenna_2019]
GO

--1 create/alter
alter procedure findGuestsClass
@ClassName varchar(50)
as
begin
select Guests.id, Guests.Name, Classes.Name, Levels.Level
	from Guests
	join levels on Guests.Id = Levels.GuestId
	join Classes on Levels.ClassId = Classes.Id
	where Classes.Name = @ClassName
end
go

--2 create/alter
alter procedure SumGuestsBill
@GuestId int
as
begin
select sum(Price) as Bill from Sales
	where GuestId = @GuestId
end
go

--3 create/alter
alter procedure GuestsLevel
@level int, @Range varchar(50) = null
as
begin
if (@Range = 'higher')
select Guests.id, Guests.Name, Classes.Name, Levels.Level
	from Guests
	join levels on Guests.Id = Levels.GuestId
	join Classes on Levels.ClassId = Classes.Id
	where Levels.Level >= @level
if (@Range = 'lower')
select Guests.id, Guests.Name, Classes.Name, Levels.Level
	from Guests
	join levels on Guests.Id = Levels.GuestId
	join Classes on Levels.ClassId = Classes.Id
	where Levels.Level <= @level
if (@Range is null)
select Guests.id, Guests.Name, Classes.Name, Levels.Level
	from Guests
	join levels on Guests.Id = Levels.GuestId
	join Classes on Levels.ClassId = Classes.Id
	where Levels.Level = @level
end
go

/*
--4 create/alter
alter procedure deleteTavern
@TavernId int
as
begin
delete from Taverns where Taverns.id = @TavernId
end
go

--5 create/alter
create trigger RemoveTavern
on Taverns
for delete 
as begin
delete from Inventory where Inventory.TavernId = (select top 1 id from inserted)
delete from Receipts where Receipts.TavernId = (select top 1 id from inserted)
delete from Sales where Sales.TavernId = (select top 1 id from inserted)
delete from Rooms where Rooms.TavernId = (select top 1 id from inserted)
end
go
create trigger RemoveRoom
on Rooms
for delete 
as begin
delete from RoomLog where RoomLog.Id = (select top 1 id from inserted)
end
go
create trigger RemoveSupSale
on Sales
for delete 
as begin
delete from SupplySales where SupplySales.Id = (select top 1 id from inserted)
end
go
*/

--6 create/alter
alter procedure BookRoom
@min int, @max int
as
begin
drop table if exists temp
select Taverns.Name as Tavern, Rooms.Id as RoomId, RoomStatus.Name,Rooms.Rate as Rate into temp
from Rooms
	join RoomLog on Rooms.Id = RoomLog.RoomId
	join Taverns on Rooms.TavernId = Taverns.Id
	join RoomStatus on Rooms.StatusId = RoomStatus.Id
where @min <= Rate and @max >= Rate and RoomStatus.Name = 'Open'
order by Rate asc 
update Rooms
set Rooms.StatusId = 2
where Rooms.Id = (select Top 1 RoomId from temp order by Rate asc )
drop table if exists temp
end
go

--7 create/alter
create trigger RoomSale
on Rooms
after update
as begin
INSERT INTO [dbo].[Sales]
           ([ServiceId]
           ,[GuestId]
           ,[TavernId]
           ,[Price]
           ,[Quanity]
           ,[Date])
     VALUES
           (5,1,1,(select top 1 Rate from inserted),1,GETDATE())
end
go

--1
select * from Classes;

exec findGuestsClass
@ClassName = 'Wizzard';

--2
select * from sales;

exec SumGuestsBill
@GuestId = 2;

--3
exec GuestsLevel
@level = 23, @Range='lower';
exec GuestsLevel
@level = 23, @Range='higher';
exec GuestsLevel
@level = 23;
exec GuestsLevel
@level = 25;

--4 & 5
/*
select * from Taverns;
select * from Inventory;
select * from Receipts;
select * from Sales;
select * from Rooms;
exec deleteTavern
@TavernId = 1;
select * from Taverns;
select * from Inventory;
select * from Receipts;
select * from Sales;
select * from Rooms;
*/

--6 & 7
select * from Rooms;
exec BookRoom
@min = 25, @max = 100;
select * from Rooms;
select * from Sales;

