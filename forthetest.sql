select RowNumber, ID from (select ROW_NUMBER() OVER(ORDER BY ID) as RowNumber, ID from UserRole) as someTable where RowNumber = (select FLOOR(RAND()*(select count(*) from' + quotename(@ParentTable) + ' )+1))