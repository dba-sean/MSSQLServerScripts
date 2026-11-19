select 
	db_name(database_id), 
	name,
	type_desc,
	physical_name, 
	(size*8.0)/1024/1024 sizegb , 
	case
		when max_size = -1 then 'Unlimited'
		else cast((cast(max_size as float)*8)/1024/1024 as varchar) + ' GB'
	end as max_size,
	case
		when is_percent_growth=1 then cast(growth as varchar) + '%'
		when is_percent_growth=0 then cast((growth*8)/1024 as varchar) + ' MB'
	end as growth
from sys.master_files 
--where type = 1 
order by 3 desc, 5 desc