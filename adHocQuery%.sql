SELECT AdHoc_Plan_MB, Total_Cache_MB,
AdHoc_Plan_MB*100.0 / Total_Cache_MB AS 'AdHoc %'
FROM (
SELECT SUM(CASE
WHEN objtype = 'adhoc'
THEN convert(float,size_in_bytes)
ELSE 0 END) / 1048576.0 AdHoc_Plan_MB,
SUM(convert(float,size_in_bytes)) / 1048576.0 Total_Cache_MB
FROM sys.dm_exec_cached_plans) T






 WITH adHocCTE AS
(
 SELECT SUM(CASE WHEN [usecounts] = 1 THEN [size_in_bytes] 
 ELSE 0
 END) / 1024.0 / 1024.0 as singleUseAdHocMB,
 SUM(CASE WHEN [usecounts] = 1 THEN 0
 ELSE [size_in_bytes]
 END) / 1024.0 / 1024.0 as multiUseAdHocMB
 FROM sys.dm_exec_cached_plans
 CROSS APPLY sys.dm_exec_sql_text(plan_handle)
 WHERE LOWER(objtype) = 'adhoc'
)
SELECT singleUseAdHocMB, multiUseAdHocMB, 
 singleUseAdHocMB * 100.00 / 
 (singleUseAdHocMB + multiUseAdHocMB) AS adHocPercent
FROM adHocCTE;