--Основная процедура
    procedure run(errbuf     out 	varchar2, --error text
                  retcode    out 	number,
                  p_param1   in     number,
                  p_param2   in     date);

-- retcode:
-- 0 – Concurrent Program is successful.
-- 1 – Concurrent program completed with warning.
-- 2 – Concurrent Program has some Error.

--Вывод результатов конкарента
apps.fnd_file.put(apps.fnd_file.output, p_text);
apps.fnd_file.put(apps.fnd_file.log, p_text);


fnd_global.conc_request_id -- текуйщий id конкарента, -1 если отсутствует значение

--Набор значений для параметра с типом Date:
FND_STANDARD_DATE
--Тип данных параметра - varchar2, Преобразование в date:
apps.fnd_date.canonical_to_date(p_date_from)