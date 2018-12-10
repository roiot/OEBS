Insert into ZX.ZX_TRX_HEADERS_GT
   (INTERNAL_ORGANIZATION_ID, INTERNAL_ORG_LOCATION_ID, APPLICATION_ID, ENTITY_CODE, EVENT_CLASS_CODE, 
    EVENT_TYPE_CODE, TRX_ID, TRX_DATE, LEDGER_ID, TRX_CURRENCY_CODE, 
    CURRENCY_CONVERSION_DATE, CURRENCY_CONVERSION_RATE, CURRENCY_CONVERSION_TYPE, PRECISION, LEGAL_ENTITY_ID, 
    ROUNDING_BILL_TO_PARTY_ID, RNDG_BILL_TO_PARTY_SITE_ID, RECEIVABLES_TRX_TYPE_ID, TAX_REPORTING_FLAG, BILL_TO_CUST_ACCT_SITE_USE_ID, 
    BILL_THIRD_PTY_ACCT_ID, BILL_THIRD_PTY_ACCT_SITE_ID)
 Values
   (5557, 90543, 222, 'TRANSACTIONS', 'INVOICE', 
    'INV_CREATE', 11227622, TO_DATE('04.12.2018', 'DD.MM.YYYY'), 2448, 'USD', 
    TO_DATE('04.12.2018', 'DD.MM.YYYY'), 36.9999959300004476999507530054171694041, '1341', 2, 45274, 
    3866347, 3135315, 165125, 'Y', 4095418, 
    3551276, 4030539);
    
Insert into ZX.ZX_TRANSACTION_LINES_GT
   (APPLICATION_ID, ENTITY_CODE, EVENT_CLASS_CODE, TRX_ID, TRX_LEVEL_TYPE, 
    TRX_LINE_ID, LINE_LEVEL_ACTION, LINE_CLASS, TRX_SHIPPING_DATE, TRX_LINE_TYPE, 
    LINE_AMT, TRX_LINE_QUANTITY, CASH_DISCOUNT, PRODUCT_ID, PRODUCT_ORG_ID, 
    UOM_CODE, SHIP_TO_PARTY_ID, SHIP_FROM_PARTY_ID, POA_PARTY_ID, POO_PARTY_ID, 
    BILL_TO_PARTY_ID, SHIP_TO_PARTY_SITE_ID, BILL_TO_PARTY_SITE_ID, SHIP_TO_LOCATION_ID, SHIP_FROM_LOCATION_ID, 
    POA_LOCATION_ID, POO_LOCATION_ID, BILL_TO_LOCATION_ID, BILL_FROM_LOCATION_ID, ACCOUNT_CCID, 
    TRX_LINE_NUMBER, TRX_LINE_DESCRIPTION, TRX_LINE_GL_DATE, LINE_AMT_INCLUDES_TAX_FLAG, HISTORICAL_FLAG, 
    CTRL_HDR_TX_APPL_FLAG, OUTPUT_TAX_CLASSIFICATION_CODE, UNIT_PRICE, EXEMPTION_CONTROL_FLAG)
 Values
   (222, 'TRANSACTIONS', 'INVOICE', 11227622, 'LINE', 
    9528157, 'CREATE', 'INVOICE', TO_DATE('04.12.2018', 'DD.MM.YYYY'), 'ITEM', 
    13750, 25, 0, 1225650, 5866, 
    'mt', 3866347, 5866, 5557, 5557, 
    3866347, 3135315, 3135315, 91156, 90997, 
    90543, 90543, 91156, 90543, 7311497, 
    1, 'POTASSIUM SULPHATE BULK OR.TESSENDERLO', TO_DATE('04.12.2018', 'DD.MM.YYYY'), 'S', 'N', 
    'N', 'VAT 10.5%', 550, 'S');
    
declare
  l_return_status varchar2(32000);
  l_msg_count     number;
  l_msg_data      varchar2(32000);
begin
  fnd_global.apps_initialize(5038, 54356, 222);
  MO_GLOBAL.init('AR');
  mo_global.set_policy_context('S', fnd_global.org_id);
  zx_api_pub.Calculate_tax
    ( p_api_version           => 1.0,
      p_init_msg_list         => 'T',
      p_commit                => 'F',
      p_validation_level      => 1,
      x_return_status         => l_return_status,
      x_msg_count             => l_msg_count,
      x_msg_data              => l_msg_data
    );
  
  dbms_output.put_line('l_return_status='||l_return_status);
  dbms_output.put_line('l_msg_count='||l_msg_count);
  dbms_output.put_line('l_msg_data='||l_msg_data);
  dbms_output.put_line('-----------');
end;
/

select * 
  from zx_lines
 where trx_id = 11227622;
 
select *
  from zx_lines_det_factors 
 where trx_id = 11227622;