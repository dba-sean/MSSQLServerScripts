--Index Size--

SELECT i.[name] AS IndexName
    ,(CAST(ROUND((SUM(s.[used_page_count]) / 128.00), 2) AS NUMERIC(36, 2))) AS IndexSizeMB
FROM sys.dm_db_partition_stats AS s
INNER JOIN sys.indexes AS i ON s.[object_id] = i.[object_id]
    AND s.[index_id] = i.[index_id]
GROUP BY i.[name]
ORDER BY i.[name]