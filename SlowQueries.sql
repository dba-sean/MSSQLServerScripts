SELECT TOP 100
		creation_time,
        last_execution_time,
        (total_worker_time+0.0)/1000 AS total_worker_time,
        (total_worker_time+0.0)/(execution_count*1000) AS [AvgCPUTime],
	 	total_elapsed_time/1000000/execution_count as 'AVGElapsedTimeSeconds',
        total_logical_reads AS [LogicalReads],
        total_logical_writes AS [LogicalWrites],
        execution_count,
        total_logical_reads+total_logical_writes AS [AggIO],
        (total_logical_reads+total_logical_writes)/(execution_count+0.0) AS [AvgIO],
      	st.TEXT,
        DB_NAME(st.dbid) AS database_name,
        st.objectid AS OBJECT_ID,
		ep.query_plan
FROM sys.dm_exec_query_stats  qs
outer APPLY sys.dm_exec_query_plan(qs.plan_handle) ep
CROSS APPLY sys.dm_exec_sql_text(sql_handle) st
WHERE total_logical_reads+total_logical_writes > 0
AND sql_handle IS NOT NULL
AND last_execution_time > dateadd(hh,-24,getdate())
ORDER BY [AvgIO] DESC


--get full text
--bcp "SELECT dm_t.TEXT FROM sys.dm_exec_requests dm_r CROSS APPLY sys.dm_exec_sql_text (dm_r.sql_handle) dm_t WHERE dm_r.session_id = 105"  queryout c:\temp\temp.txt -c -T -S MS170