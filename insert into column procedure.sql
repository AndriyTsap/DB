
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

alter PROCEDURE generateDataForColumn
	@tableName nvarchar(40),  
	@inputColumName nvarchar(40),
	@rowsCount int
AS
BEGIN
	DECLARE @isFK bit = 0;
	DECLARE @FKName NVARCHAR(MAX);
	DECLARE @ParentTable NVARCHAR(MAX); 
	declare @sql varchar(500);
	declare @ParmDefinition nvarchar(500);
	declare @StringVariable nvarchar(500);

	DECLARE columnsCursor1 CURSOR FOR 
		 SELECT  kcu.column_name,
                ccu.table_name AS references_table
			 FROM information_schema.table_constraints tc
		INNER JOIN information_schema.key_column_usage kcu
			   ON tc.constraint_catalog = kcu.constraint_catalog
			  AND tc.constraint_schema = kcu.constraint_schema
			  AND tc.constraint_name = kcu.constraint_name
		INNER JOIN information_schema.referential_constraints rc
			   ON tc.constraint_catalog = rc.constraint_catalog
			  AND tc.constraint_schema = rc.constraint_schema
			  AND tc.constraint_name = rc.constraint_name
			  AND  tc.constraint_type = 'FOREIGN KEY'
		INNER JOIN information_schema.constraint_column_usage ccu
			   ON rc.unique_constraint_catalog = ccu.constraint_catalog
			  AND rc.unique_constraint_schema = ccu.constraint_schema
			  AND rc.unique_constraint_name = ccu.constraint_name
			  WHERE tc.table_name = @tableName
       OPEN columnsCursor1;
       
	FETCH NEXT FROM columnsCursor1
		INTO @FKName, @ParentTable

	WHILE @@FETCH_STATUS = 0
	BEGIN
         -- ïğîâåğÿåì, ÿâëÿåòñÿ ëè ïğèøåäøèé íà âõîä ïğîöåäóğå ñòîëáåö @inputColumName íàéäåííûì ğàíåå âíåøíèì êëş÷îì äàííîé òàáëèöû 
		IF (@inputColumName = @FKName)
		BEGIN
			SET @isFK = 1;   --óñòàíàâëèâàåì ôëàã â true - ğàáîòàåì ñ FK è äğóãèõ ïğîâåğîê íà òèï äàííûõ äåëàòü íå íóæíî. 

			declare @SqlString nvarchar(500)
			declare @RandomedParentID int

			set @SqlString = N'select RowNumber, ID from (select ROW_NUMBER() OVER(ORDER BY ID) as RowNumber, ID from ' + 
				quotename(@ParentTable) +' ) as someTable where RowNumber = (select FLOOR(RAND()*(select count(*) from' + 
				quotename(@ParentTable) + ' )+1))' ;
			SET @ParmDefinition = N'@Table varchar(MAX)';  
			
			create table #TempTable
			(
				rn int,
				id int
			)

			--insert into #TempTable
			--exec sp_executesql   @SqlString, @ParmDefinition,  
   --                   @ParentTable;

			--select * from #TempTable;
			--delete from #TempTable;
			
			declare @i int
			declare @id int

			while @i >=1 and @i <= @rowsCount
			begin
				select 1;

				--insert into #TempTable
				--exec sp_executesql   @SqlString, @ParmDefinition,  
    --                  @ParentTable;

				--select * from #TempTable;

				select @i = @i + 1
				select @id = @id + 1
			end

		END
									
		FETCH NEXT FROM columnsCursor1
		INTO @FKName,@ParentTable
	END;
	CLOSE columnsCursor1;
	DEALLOCATE columnsCursor1;

END
GO
