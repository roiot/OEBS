select *
  from fnd_profile_options_tl
 where user_profile_option_name like 'БОП: диагностика';

select *
  from fnd_profile_options_tl
 where profile_option_name = 'FND_NATIVE_CLIENT_ENCODING';


select p.profile_option_name short_name,
       n.user_profile_option_name name,
       decode(v.level_id,
              10001, 'Site',
              10002, 'Application',
              10003, 'Responsibility',
              10004, 'User',
              10005, 'Server',
              10007, 'SERVRESP',
              'UnDef'
             )
           level_set,
       decode(to_char(v.level_id),
              '10001', '',
              '10002', app.application_short_name,
              '10003', rsp.responsibility_key,
              '10005', svr.node_name,
              '10006', org.name,
              '10004', usr.user_name,
              '10007', 'Serv/resp',
              'UnDef'
             )
           "CONTEXT",
       v.profile_option_value value
  from fnd_profile_options p,
       fnd_profile_option_values v,
       fnd_profile_options_tl n,
       fnd_user usr,
       fnd_application app,
       fnd_responsibility rsp,
       fnd_nodes svr,
       hr_operating_units org
 where p.profile_option_id = v.profile_option_id(+)
   and p.profile_option_name = n.profile_option_name
   and upper(n.user_profile_option_name) like upper('%&p%')
   and usr.user_id(+) = v.level_value
   and rsp.application_id(+) = v.level_value_application_id
   and rsp.responsibility_id(+) = v.level_value
   and app.application_id(+) = v.level_value
   and svr.node_id(+) = v.level_value
   and org.organization_id(+) = v.level_value;


fnd_profile.value

fnd_profile.value_specific (
      name               in varchar2,
      user_id            in number default null,
      responsibility_id  in number default null,
      application_id     in number default null,
      org_id             in number default null,
      server_id          in number default null
                           ) return varchar2