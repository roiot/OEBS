--1. Активные ШЕ
select pos.*
from hr.hr_all_positions_f pos
where trunc(sysdate) between pos.effective_start_date and pos.effective_end_date
  and pos.availability_status_id = 1 --активные ШЕ

--2. Активные назначения
select a.*
from hr.per_all_assignments_f a
where a.assignment_status_type_id in (select assignment_status_type_id from xxapps.xxapps_a005_active_asgn_sts_v)
--xxapps.xxapps_a005_is_assign_active(a.assignment_status_type_id, 'HR') = 'ACTIVE' --a.assignment_status_type_id in (1, 99, 100, 102) --активные назначения
  and trunc(sysdate) between a.effective_start_date and a.effective_end_date

--Статусы назначений
select * from per_assignment_status_types_v order by 2-- 102-Ученик; 99-Декретный отпуск; 100-Временное перемещение; 1-Акт. назначение

--3. Активные сотрудники + см. ниже
select *
from hr.per_all_people_f p
where trunc(sysdate) between p.effective_start_date and p.effective_end_date

--определение person_type_id "Работник" для текущей  бизнес группы. Может вернуть более одного значения.
--Используется для доп. обрезки таблицы per_all_people_f
select t.person_type_id
from hr.per_person_types t
where t.system_person_type = 'EMP'
and t.business_group_id = &business_group_id

--4. Активные организации
select *
from hr.hr_all_organization_units ou
where trunc(sysdate) between ou.date_from and nvl(ou.date_to, sysdate+1)

--5. Определение id структуры иерархии должностей
select ppsv.pos_structure_version_id
  from per_position_structures pps,
       per_pos_structure_versions ppsv
 where pps.business_group_id = apps.fnd_profile.value('PER_BUSINESS_GROUP_ID')
   and pps.primary_position_flag = 'Y'
   and ppsv.position_structure_id = pps.position_structure_id
   and trunc(sysdate) between ppsv.date_from and nvl(ppsv.date_to, sysdate+1)

--6. Определение id структуры иерархии Организаций
select v.org_structure_version_id
from hr.per_organization_structures s,
   hr.per_org_structure_versions v
where s.primary_structure_flag = 'Y'
  and s.business_group_id = apps.fnd_profile.value('PER_BUSINESS_GROUP_ID')
  and v.organization_structure_id  = s.organization_structure_id
  and sysdate between nvl(date_from, sysdate-1) and nvl(date_to, sysdate+1)