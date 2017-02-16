-- Concurrent Responsibilities

select * from  fnd_concurrent_programs_vl where concurrent_program_name = 'XXOPM_B116_N';

select * from   fnd_request_group_units where request_unit_id = 168484;

select * from fnd_responsibility_vl where request_group_id in (2129, 794, 2049) and responsibility_name like 'RUNEV%';



--User Responsibilities
 select u.user_id, r.application_id, r.responsibility_id, r.responsibility_name
    from apps.fnd_user u,
         apps.fnd_user_resp_groups ur,
         apps.fnd_responsibility_tl r
   where ur.user_id = u.user_id
     and ur.responsibility_id = r.responsibility_id
     and r.language = 'RU'
     and u.user_name = 'SKRYABIN_DG@MOSCOW'
     and r.responsibility_name like 'LTLIF%'
order by r.responsibility_name