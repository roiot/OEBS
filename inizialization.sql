-- Параметры текущего окружения
select fnd_profile.value('RESP_APPL_ID'),
       fnd_profile.value('RESP_ID'),
       fnd_profile.value('USER_ID'),
       apps.fnd_global.org_id,
       apps.fnd_global.user_id -- и т.п. Данные берутся из контектса сесиии
from dual

--Инициализация окружения
begin
  fnd_global.apps_initialize(user_id => 7033, resp_id => 51088, resp_appl_id => 552);
  apps.mo_global.set_policy_context('S', 221); -- R12
end;

 select 'begin -- ' || rtl.responsibility_name || chr(10) || 
        '   fnd_global.apps_initialize(user_id => ' || urg.user_id || ' ,resp_id => ' || urg.responsibility_id || ' ,resp_appl_id => ' || urg.responsibility_application_id || ');' || chr(10) || 
        'end;' as init_sql
    from fnd_user_resp_groups urg,
         fnd_user u,
         fnd_application a,
         fnd_application_tl atl,
         fnd_responsibility r,
         fnd_responsibility_tl rtl
   where urg.user_id = u.user_id
     and urg.responsibility_application_id = a.application_id
     and urg.responsibility_id = r.responsibility_id
     and r.responsibility_id = rtl.responsibility_id
     and r.application_id = rtl.application_id
     and rtl.language = 'RU'
     and a.application_id = atl.application_id
     and atl.language = rtl.language
     and u.user_name like 'SKRYABIN_DG@MOSCOW'
order by 1