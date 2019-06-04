-- AR Transactions
select t.customer_trx_id
     , t.trx_number
     , t.trx_date
     , d.gl_date
     , t.exchange_rate_type
     , t.exchange_date
     , t.exchange_rate
     , rctla.sales_order
     , rctla.attribute7 shipment
     --, u.user_name 
     , p.party_name
     , to_char(p.jgzz_fiscal_code) || to_char(ca.global_attribute12)  "CUIT" 
     , b.name source 
     , rctla.line_number
     , nvl(m.description, mm.description) description
     , tt.name sales_type
     , rctla.quantity_invoiced quantity 
     , rctla.unit_selling_price price 
     , t.invoice_currency_code currency
     , t.global_attribute12 old_number
     ,  nvl((select sum(zl.unrounded_tax_amt)
               from zx.zx_lines zl
              where 1 = 1
                and zl.trx_id = t.customer_trx_id
                and zl.trx_line_id = rctla.customer_trx_line_id
                and zl.entity_code = 'TRANSACTIONS'
                and zl.tax = 'TOPCF'
            ), 0 ) cf_amt
     ,  nvl((select sum(zl.unrounded_tax_amt)
               from zx.zx_lines zl
              where 1 = 1
                and zl.trx_id = t.customer_trx_id
                and zl.trx_line_id = rctla.customer_trx_line_id
                and zl.entity_code = 'TRANSACTIONS'
                and zl.tax = 'TOPBA'
            ), 0 ) ba_amt
     ,  nvl((select sum(zl.unrounded_tax_amt)
               from zx.zx_lines zl
              where 1 = 1
                and zl.trx_id = t.customer_trx_id
                and zl.trx_line_id = rctla.customer_trx_line_id
                and zl.entity_code = 'TRANSACTIONS'
                and zl.tax = 'TOPER'
            ), 0 ) er_amt
     ,  nvl((select sum(zl.unrounded_tax_amt)
               from zx.zx_lines zl
              where 1 = 1
                and zl.trx_id = t.customer_trx_id
                and zl.trx_line_id = rctla.customer_trx_line_id
                and zl.entity_code = 'TRANSACTIONS'
                and zl.tax = 'VAT'
            ), 0 ) vat
     ,  nvl((select sum(zl.unrounded_tax_amt)
               from zx.zx_lines zl
              where 1 = 1
                and zl.trx_id = t.customer_trx_id
                and zl.trx_line_id = rctla.customer_trx_line_id
                and zl.entity_code = 'TRANSACTIONS'
                and zl.tax = 'VATADDL'
            ), 0 ) vataddl                 
     , sum(nvl(nvl(rctla.quantity_invoiced, rctla.quantity_credited) * rctla.unit_selling_price, 0)) no_tax_amt
     , nvl((select sum(zl.unrounded_tax_amt)
               from zx.zx_lines zl
              where 1 = 1
                and zl.trx_id = t.customer_trx_id
                and zl.trx_line_id = rctla.customer_trx_line_id
                and zl.entity_code = 'TRANSACTIONS')
            , 0) tax_amt  
     , (sum(nvl(nvl(rctla.quantity_invoiced, rctla.quantity_credited) * rctla.unit_selling_price, 0)) + nvl((select sum(zl.unrounded_tax_amt)
               from zx.zx_lines zl
              where 1 = 1
                and zl.trx_id = t.customer_trx_id
                and zl.trx_line_id = rctla.customer_trx_line_id
                and zl.entity_code = 'TRANSACTIONS')
            , 0) ) line_total_amt
     , d.amount invoice_total_amt         
  from ar.ra_customer_trx_all t
     , ar.ra_cust_trx_line_gl_dist_all d
     , ar.ra_batch_sources_all b
     , ar.ra_cust_trx_types_all tt
     , ar.ar_memo_lines_all_tl mm
     --, xxgla.fnd_user u
     , ar.hz_parties p
     , ar.hz_cust_accounts ca
     , ar.ra_customer_trx_lines_all rctla
     , mtl_system_items_b m
where 1 = 1
   and d.customer_trx_id = t.customer_trx_id
   and d.account_class = 'REC'
   --and u.user_id = t.created_by
   and t.bill_to_customer_id = ca.cust_account_id
   and ca.party_id = p.party_id
   and t.batch_source_id = b.batch_source_id
   and m.inventory_item_id(+) = rctla.inventory_item_id
   and m.organization_id(+) = rctla.warehouse_id
   and mm.memo_line_id(+) = rctla.memo_line_id
   and mm.language(+) = 'US'
   and tt.cust_trx_type_id = t.cust_trx_type_id
   --and b.name = ''
   and t.org_id = 5557
   and d.gl_date between to_date('01.04.2019', 'dd.mm.yyyy') and to_date('30.04.2019', 'dd.mm.yyyy')
   --and b.name = 'NC-A-0050'
   --and b.name in ('NC-A-0050' , 'NC-B-0050', 'ND-A-0050' , 'ND-B-0050')
   --and u.user_name = 'MIROSHNICHENKO_RA@BRK'
   --and trunc(t.creation_date) = to_date('31.05.2019', 'dd.mm.yyyy')
   --and t.trx_number = 'A-0050-00012585#'
   and t.customer_trx_id = rctla.customer_trx_id
   and rctla.line_type = 'LINE'
   group by
           t.customer_trx_id
         , t.trx_number
         , t.trx_date
         , tt.name
         , d.gl_date
         , t.exchange_rate_type
         , t.exchange_date
         , t.exchange_rate
         , rctla.sales_order
         , rctla.attribute7
         , rctla.customer_trx_line_id
         , rctla.line_number
         , nvl(m.description, mm.description)
         , rctla.quantity_invoiced
         , rctla.unit_selling_price
         , t.invoice_currency_code
         , t.global_attribute12
         , d.amount
         --, u.user_name 
         , p.party_name
         , to_char(p.jgzz_fiscal_code) || to_char(ca.global_attribute12)
         , b.name  
         , t.global_attribute16 
   order by
          tt.name
        , t.customer_trx_id
        , t.trx_number 
        , rctla.line_number