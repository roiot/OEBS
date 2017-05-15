select te.entity_code,
       te.source_id_int_1, --id учетного объекта в модуле
       l.* --Строки учета
  from xla.xla_transaction_entities te,
       xla.xla_events e,
       xla.xla_ae_headers h,
       xla.xla_ae_lines l
 where te.entity_id = e.entity_id
   and te.application_id = e.application_id
   and e.event_id = h.event_id
   and te.ledger_id = h.ledger_id
   and h.ae_header_id = l.ae_header_id;
   --!!! Добавить обрезку всех таблиц по application_id для использования партиций


select et.entity_code
  from apps.fnd_application a,
       xla.xla_entity_types_b et
 where a.application_short_name = 'GMF'
   and et.application_id = a.application_id;

