select t.balance
from RA_CUSTOMER_TRX_ALL t
where org_id = 5557;


BEGIN
  apps.mo_global.set_policy_context('S', 5557);
END;
/

select h.total_amount, h.exchange_rate, h.invoice_currency_code, h.balance_due, h.* 
from apps.AR_INVOICE_HEADER_V h;


select * from AR_OPEN_TRX_V;