/* HR Organizations */
select * 
from hr.hr_all_organization_units
where name like '%KZAGR%'
order by name;


/* Operating Units */
select * 
from hr_operating_units
order by short_code;
