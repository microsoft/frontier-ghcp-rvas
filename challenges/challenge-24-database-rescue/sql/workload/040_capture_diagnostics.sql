SET NOCOUNT ON;
GO

SELECT TOP (20)
    qs.execution_count,
    qs.total_worker_time / NULLIF(qs.execution_count, 0) AS avg_worker_time,
    qs.total_logical_reads / NULLIF(qs.execution_count, 0) AS avg_logical_reads,
    qs.total_elapsed_time / NULLIF(qs.execution_count, 0) AS avg_elapsed_time,
    SUBSTRING(
        sql_text.text,
        (qs.statement_start_offset / 2) + 1,
        (
            (
                CASE qs.statement_end_offset
                    WHEN -1 THEN DATALENGTH(sql_text.text)
                    ELSE qs.statement_end_offset
                END
                - qs.statement_start_offset
            ) / 2
        ) + 1
    ) AS statement_text
FROM sys.dm_exec_query_stats AS qs
CROSS APPLY sys.dm_exec_sql_text(qs.sql_handle) AS sql_text
WHERE sql_text.text LIKE '%Query ID: Q%'
ORDER BY avg_logical_reads DESC;
GO

SELECT
    requests.session_id,
    requests.blocking_session_id,
    requests.status,
    requests.wait_type,
    requests.wait_time,
    requests.logical_reads,
    requests.cpu_time,
    requests.total_elapsed_time
FROM sys.dm_exec_requests AS requests
WHERE requests.session_id <> @@SPID;
GO

SELECT
    waits.wait_type,
    waits.waiting_tasks_count,
    waits.wait_time_ms,
    waits.signal_wait_time_ms
FROM sys.dm_os_wait_stats AS waits
WHERE
    waits.waiting_tasks_count > 0
    AND waits.wait_type NOT LIKE 'SLEEP%'
ORDER BY waits.wait_time_ms DESC;
GO
