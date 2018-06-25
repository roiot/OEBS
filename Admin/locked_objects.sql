-- Залоченные объекты
SELECT   lo.object_id, lo.session_id, ses.status, ses.serial#, ses.action,
         al.object_name
    FROM all_objects al, SYS.v_$locked_object lo, SYS.v_$session ses
   WHERE lo.object_id = al.object_id AND ses.SID = lo.session_id
ORDER BY object_name
 
-- Убить сессию
ALTER SYSTEM
KILL SESSION '45,2572'   --session_id, serial#
 
-- Кто держит пакет
begin
sys.who_is_using('XXGLA_A025_PKG');
end;

-- Кто держит временную таблицу
select --+rule
   s.INST_ID, s.SID, s.SERIAL#, s.USERNAME, s.STATUS, s.MACHINE
from gv$lock l, gv$session s
where l.INST_ID=s.INST_ID
and l.TYPE='TO'
and l.SID=s.SID
and l.id1 in (select o.object_id from dba_objects o
where o.object_name = Upper('XXGTH_A005_SHIP_QNT'))

 