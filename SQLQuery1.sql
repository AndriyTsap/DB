--create table [User](

--	ID bigint primary key IDENTITY(1,1),
--	Username varchar(20) not null unique,
--	Email varchar(50) not null unique,
--	FirsName varchar(20) not null,
--	LastName varchar(20) not null,
--	Phone varchar(20),
--	BirthDate date,
--	HasdedPassword varchar(50) not null,
--	Salt varchar(20) not null,
--	IsLocked bit,
--	DateCreated datetime,
--	Photo varchar(50),
--	About varchar(200) 

--);

--create table [Chat](

--	ID bigint primary key IDENTITY(1,1),
--	[Name] varchar(20) not null unique,
--	DateCreated date,
--	[Type] varchar(20)

--);

create table ChatUser(
	
	ID bigint primary key identity(1,1),
	ChatID bigint FOREIGN KEY REFERENCES Chat(ID),
	UserID bigint foreign key references [User](ID)

);