SELECT 
    qsq.query_id,
    qsq.last_execution_time,
	qsq.query_hash,
    qsqt.query_sql_text
FROM sys.query_store_query qsq
    INNER JOIN sys.query_store_query_text qsqt
        ON qsq.query_text_id = qsqt.query_text_id
WHERE
	qsq.query_hash=<query_hash_value>