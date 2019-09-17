select * from hz_geographies where country_code = 'AR' and geography_type = 'PROVINCE';

select ca.attribute1 vat_cond
     , a.global_attribute8 contr_class
     , to_char(d.jgzz_fiscal_code) || to_char(ca.global_attribute12)  "CUIT"
     , d.party_name "CUSTOMER"
     , e.province 
     , e.last_update_date
     , ca.account_number "CUSTOMER NUMBER"
     , d.party_type "TYPE"
     , d.country
     , ztp2.rep_registration_number "VAT REG NUM"
     , nvl(ztp.rep_registration_number,  e.address2) "Second VAT reg"
     , b2.location "Location Ship to"
     , b.location "Location Bill to",
                 regexp_replace(
              trim(
                nvl2(e.postal_code, e.postal_code || ', ', e.postal_code) ||
                nvl2(e.province, e.province || ', ', e.province) ||
                nvl2(e.county, e.county || ', ', e.county) ||
                nvl2(e.city, e.city || ', ', e.city) ||
                nvl2(e.address1, e.address1 || ', ', e.address1) ||
                nvl2(e.address2, e.address2 || ', ', e.address2) ||
                nvl2(e.address3, e.address3 || ', ', e.address3) ||
                e.address4
              )
            , ',$', '') "Address"
            , ca.account_termination_date
            , c.start_date_active
            , c.status
            , c.end_date_active
            , ca.status
            --, a.*
  from      ar.hz_parties d,
            ar.HZ_CUST_ACCOUNTS ca,
            HZ_CUST_ACCT_SITES_ALL a,
            ar.hz_cust_site_uses_all b,
            ar.hz_cust_site_uses_all b2,
            ar.hz_party_sites c,
            ar.hz_locations e,
            apps.fnd_territories_vl l
          , apps.zx_party_tax_profile ztp
          , apps.zx_party_tax_profile ztp2
    where       c.party_id = d.party_id
            and ca.party_id = d.party_id
            and b.cust_acct_site_id = a.cust_acct_site_id
            and b.org_id = a.org_id
            and b2.cust_acct_site_id = a.cust_acct_site_id
            and b2.org_id = a.org_id
            and a.cust_account_id = ca.cust_account_id
            and a.party_site_id = c.party_site_id
            and e.location_id = c.location_id
            and l.territory_code = e.country
            and a.party_site_id = ztp.party_id
            and d.party_id = ztp2.party_id
            and ztp.party_type_code = 'THIRD_PARTY_SITE'
            and ztp2.party_type_code = 'THIRD_PARTY'
            and b.site_use_code = 'BILL_TO'
            and b2.site_use_code = 'SHIP_TO'
            and a.org_id = 5557 -- AREFO
            and e.province not in (select geography_code from hz_geographies where country_code = 'AR' and geography_type = 'PROVINCE')
            and d.country = 'AR'
            -- and d.party_name = 'NEXUS AGRI S.A.'
           order by e.last_update_date desc;