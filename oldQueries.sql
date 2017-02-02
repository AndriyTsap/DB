--insert role
--insert into [Role] ([Name]) values('Admin'), ('User');  

declare @i int
declare @id int
--insert users
select @i = 1
select @id = ISNULL((select max(ID) from [User]), 0)+1

while @i >=1 and @i <= 1000
begin
	insert into [User] (Username, Email, FirsName, LastName, HasdedPassword, Salt) values('jack' + convert(varchar(6), @id),
	 'jack.deniel' + convert(varchar(6), @id)+ '@gmail.com', 'jack', 'daniels', 'asd23iu534trhjeg54tre', 'g678tgf34')
    select @i = @i + 1
	select @id = @id + 1
end

--insert chat
--select @i = 1
--select @id = ISNULL((select max(ID) from [Chat]), 0)+1

--while @i >=1 and @i <= 10000
--begin
--	WITH ChatTypes AS 
--	( SELECT 'Dialog' AS [Name], 
--          1 AS Number
--	UNION SELECT 'Chat' AS [Name], 
--         2 AS Number
--	)
--	insert into Chat([Name], DateCreated, [Type]) values ('eleks402'+convert(varchar(6), @id), GETDATE(), (select ChatTypes.[Name] from ChatTypes where ChatTypes.Number = FLOOR(RAND()*(3-1)+1)))
    
--    select @i = @i + 1
--	select @id = @id + 1
--end

