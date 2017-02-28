-- Параметры текущего окружения
fnd_profile.value('RESP_APPL_ID');
fnd_profile.value('RESP_ID');
fnd_profile.value('USER_ID');

select 'begin -- ' || rtl.responsibility_name || chr(10)
|| ' fnd_global.apps_initialize(' || chr(10)
|| ' user_id => ' || urg.user_id || chr(10)
|| ' ,resp_id => ' || urg.responsibility_id || chr(10)
|| ' ,resp_appl_id => ' || urg.responsibility_application_id || chr(10)
|| ' );' || chr(10)
|| 'end;' || chr(10)
|| '/'
from fnd_user_resp_groups urg
,fnd_user u
,fnd_application a
,fnd_application_tl atl
,fnd_responsibility r
,fnd_responsibility_tl rtl
where urg.user_id = u.user_id
and urg.responsibility_application_id = a.application_id
and urg.responsibility_id = r.responsibility_id
and r.responsibility_id = rtl.responsibility_id
and r.application_id = rtl.application_id
and rtl.language = 'RU'
and a.application_id = atl.application_id
and atl.language = rtl.language
and u.user_name like 'SKRYABIN_DG@MOSCOW'
order by 1 --u.user_name asc
