-- Trace file location
select * from v$parameter where name = 'user_dump_dest'; 

--WEEK12RU
--/snap_ssd_week12ru/oracle/WEEK12RU/11.2.0/admin/WEEK12RU_appstest04/diag/rdbms/week12ru/WEEK12RU/trace

select oracle_process_id from apps.fnd_concurrent_requests where request_id=9505885

cd <user_dump_dest>
ls *<oracle_process_id>*

--Tabular Statistics in TKPROF
--https://docs.oracle.com/cd/B10500_01/server.920/a96533/sqltrace.htm#1317