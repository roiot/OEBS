        l_code_combination_id      := apps.fnd_flex_ext.get_ccid(
                                          application_short_name   => 'SQLGL',
                                          key_flex_code            => 'GL#',
                                          structure_number         => p_chart_of_accounts_id,
                                          validation_date          => apps.fnd_date.date_to_canonical(sysdate),
                                          concatenated_segments    => p_concatenated_segments
                                      );