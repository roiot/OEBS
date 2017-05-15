-- Concurrent Responsibilities
select * from fnd_concurrent_programs_vl where concurrent_program_name = 'XXOPM_B116_N';

select * from fnd_request_group_units where request_unit_id = 168484;

select * from fnd_responsibility_vl where request_group_id in (2129, 794, 2049) and responsibility_name like 'RUNEV%';


--User Responsibilities
 select u.user_id, r.application_id, r.responsibility_id, rl.responsibility_name, m.user_menu_name, ur.*
    from apps.fnd_user u,
         apps.fnd_user_resp_groups ur,
         apps.fnd_responsibility r,
         apps.fnd_responsibility_tl rl,
         apps.fnd_menus_vl m
   where ur.user_id = u.user_id
     and ur.responsibility_id = r.responsibility_id
     and r.responsibility_id = rl.responsibility_id
     and r.menu_id = m.menu_id 
     --
     and trunc(sysdate) between ur.start_date and nvl(ur.end_date, sysdate+1)
     and rl.language = 'RU'
     and u.user_name = 'SKRYABIN_DG@MOSCOW'
     and rl.responsibility_name like '%'
order by rl.responsibility_name


-- Menu Functions 
select mf.*, m.*
  from applsys.fnd_compiled_menu_functions mf,
       applsys.fnd_form_functions ff,
       apps.fnd_menus_vl m
 where ff.function_name = 'XXAPPS_A005_FORM_HIST'
   and mf.menu_id = m.menu_id
   and m.menu_name in ('XXAPPS_A005_ADMIN', 'XXOKE_NEW_USER')
   and mf.function_id = ff.function_id
   and mf.grant_flag = 'Y'
