-- Наборы значений КГП плана счетов
select * 
from apps.fnd_flex_value_sets s
where s.flex_value_set_name like 'EC_CORP_%';

/*
EC_CORP_ACCOUNT
EC_CORP_ACCOUNT_DETAIL
EC_CORP_COMPANY
EC_CORP_COST_CENTER
EC_CORP_EXPENSE_TARGET
EC_CORP_INTERCOMPANY
EC_CORP_OPERATION_TYPE
*/


-- SEGMENT1 - EC_CORP_COMPANY
select v.flex_value, l.description, v.*
from apps.fnd_flex_value_sets s,
     apps.fnd_flex_values v,
     apps.fnd_flex_values_tl l
where s.flex_value_set_name = 'EC_CORP_COMPANY'
  and s.flex_value_set_id = v.flex_value_set_id
  and v.flex_value_id = l.flex_value_id
  and l.language = 'RU'
  -- and v.flex_value = '442'
order by v.flex_value;

-- SEGMENT8 - EC_CORP_EXPENSE_TARGET
select v.flex_value, l.description, v.*
from apps.fnd_flex_value_sets s,
     apps.fnd_flex_values v,
     apps.fnd_flex_values_tl l
where s.flex_value_set_name = 'EC_CORP_EXPENSE_TARGET'
  and s.flex_value_set_id = v.flex_value_set_id
  and v.flex_value_id = l.flex_value_id
  and l.language = 'RU'
  and v.flex_value in ('2451', '2431', '1011', '1013')
order by v.flex_value;



-- Настройки DFF
select * 
from applsys.fnd_descr_flex_column_usages# u
where u.descriptive_flexfield_name like 'GL%';



-- Настройки KFF
select * 
from apps.fnd_flex_kff_seg_vset_v;