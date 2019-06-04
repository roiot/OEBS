declare
-- Local variables here
   i   number;
   r   number;
begin
   --USER
   select u.user_id
     into i
     from fnd_user u
    where u.user_name = 'SKRYABIN_DG@MOSCOW';
   --RESP
   select responsibility_id
   into r
   from fnd_responsibility_tl
   where responsibility_name = 'System Administrator'
     and language = 'US';
   --INIT
   fnd_global.apps_initialize (user_id           => i,
                               resp_id           => r, --20420,
                               resp_appl_id      => 1
                              );
   fnd_user_resp_groups_api.insert_assignment     (user_id                            => i,
                                                   responsibility_id                  => 20420,
                                                   responsibility_application_id      => 1,
                                                   security_group_id                  => 0,
                                                   start_date                         => sysdate,
                                                   end_date                           => sysdate + 20000,
                                                   description                        => ''
                                                  );                                          
   commit;
   dbms_output.put_line('Inserted!');        
exception 
    when others then 
        if sqlerrm like '%FND_CANT_INSERT_USER_ROLE%' 
            or sqlerrm like '%APP-FND-01971%' -- Ошибка в программе FND_USER_RESP_GROUPS_API.Insert_Assignment: вставка строки невозможна, поскольку уже существует прямое назначение пользователя SKRYABIN_DG@MOSCOW на роль FND_RESP|SYSADMIN|SYSTEM_ADMINISTRATOR|STANDARD в таблицах пользователей/ролей потока операций. в программе FND_USER_RESP_GROUPS_API.INSERT
        then 
            fnd_user_resp_groups_api.Update_Assignment  (  user_id                            => i,
                                                           responsibility_id                  => 20420,
                                                           responsibility_application_id      => 1,
                                                           security_group_id                  => 0,
                                                           start_date                         => sysdate,
                                                           end_date                           => sysdate + 20000,
                                                           description                        => ''
                                                        );       
            commit;                                         
            dbms_output.put_line('Updated!');              
        else 
            raise;
        end if;                                
end;
/


--Решение проблемы - не появились выданные полномочия
update wf_local_user_roles
set effective_end_date=null
where user_name='SKRYABIN_DG@MOSCOW'
--and role_name like '%APPLICATION_DEVELOPER%'   --RESP_KEY
and effective_end_date < sysdate;


select * 
from wf_local_user_roles
where user_name='SKRYABIN_DG@MOSCOW'
and effective_end_date < sysdate
--and role_name like '%APPLICATION_DEVELOPER%'   --RESP_KEY


