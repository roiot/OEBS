with jrn as
(select h.application_id
      , l.accounted_dr
      , l.accounted_cr
      , l.entered_dr
      , l.entered_cr
      , l.ae_line_num
      , g.segment1
      , g.segment2
      , g.segment3
      , g.segment1||'-'||g.segment2||'-'||g.segment3||'-'||g.segment4||'-'||g.segment5||'-'||g.segment6||'-'||g.segment7||'-'||g.segment8 conc_segs
      , h.event_id
   from xla.xla_ae_headers h
      , xla.xla_ae_lines l
      , gl.gl_code_combinations g
  where h.ae_header_id = l.ae_header_id
    and g.code_combination_id = l.code_combination_id),
   afip as
   (select /*+ MATERIALIZE */ af.cae, af.id from apps.xxotc_gap001_fe_transactions af)
select
       t.transaction_number trx_number
     , (select afip.id || '=>' || afip.cae from afip where ta.customer_trx_id = afip.id) cae
     , tt.name ttype
     , b.name bname
     , t.source_id_int_1 doc_id
     , ta.complete_flag
     , e.event_id
     , e.event_number ||'.'|| jrn.ae_line_num event_num
     , e.event_type_code
     , e.event_status_code
     --, jrn.conc_segs
     , jrn.segment3 gl_account
     , e.event_date gl_date
     , jrn.accounted_dr
     , jrn.accounted_cr
     --, jrn.entered_dr
     --, jrn.entered_cr
  from xla.xla_events e
     , xla.xla_transaction_entities t
     , jrn
     , ar.ra_customer_trx_all ta
     , ar.ra_cust_trx_line_gl_dist_all ds
     , ar.ra_batch_sources_all b
     , ar.ra_cust_trx_types_all tt
where 1 = 1
   and e.entity_id = t.entity_id
   and e.application_id = t.application_id
   and e.application_id = jrn.application_id(+)
   and e.event_id = jrn.event_id(+)  
   and t.security_id_int_1 = 5557
   and t.application_id = 222
--   and t.source_id_int_1 = 11499504
   and ds.account_class = 'REC'
   and ds.event_id = e.event_id
   and ds.customer_trx_id = ta.customer_trx_id
   and ta.customer_trx_id = t.source_id_int_1
   and ta.cust_trx_type_id = tt.cust_trx_type_id
   and ta.batch_source_id = b.batch_source_id
   and e.event_status_code = 'I'
   --and e.event_id = 18797275
   --and t.transaction_number = '19072613'
   and e.event_date >= to_date('31.08.2019', 'dd.mm.yyyy')
   --and e.event_status_code = 'I'   
 order by t.source_id_int_1
        , jrn.accounted_dr
        , jrn.conc_segs
        , e.event_date
        , e.event_number ||'.'|| jrn.ae_line_num