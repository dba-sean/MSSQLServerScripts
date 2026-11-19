SELECT 
  [database]      = d.name, 
  [recovery]      = ls.recovery_model, 
  [vlf_count]     = ls.total_vlf_count, 
  [active_vlfs]   = ls.active_vlf_count,
  [vlf_size]      = ls.current_vlf_size_mb,
  [active_log_%]  = CONVERT(decimal(5,2), 
                    100.0*ls.active_log_size_mb/ls.total_log_size_mb)
FROM sys.databases AS d
CROSS APPLY sys.dm_db_log_stats(d.database_id) AS ls;

