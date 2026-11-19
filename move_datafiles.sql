alter database [database_name]
	modify file (name=[logical_file_name],	
				filename='[NEW_FILE_PATH\filename]');
go

alter database [database_name] set offline;
go

--physically move file

alter database [database_name] set online;
go