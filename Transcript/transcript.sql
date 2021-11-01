CREATE OR REPLACE FUNCTION time_table(filename varchar(1000))
RETURNS void
LANGUAGE plpgsql
AS $$
DECLARE
csv_path varchar(400);
BEGIN
-- change security to Everyone
csv_path := 'C:\Users\Hp\Downloads\' || file_name || '.csv';
execute format('copy %I from %L with delimiter '','' csv;', time_table, csv_path);
END;
$$;

CREATE OR REPLACE FUNCTION transcript_table(studentid varchar(12))
RETURNS void
LANGUAGE plpgsql
AS $$
DECLARE
i record;
BEGIN

for i in execute format('select courseid,credits,sem,year,grade from %I',studentid||'_t')
loop 
raise notice '%',i;
end loop;
END;
$$;

CREATE OR REPLACE FUNCTION transcript_table1(studentid varchar(12))
RETURNS table(
    courseid varchar(12),
    credits real,
    sem int,
    year int,
    grade int
    )
LANGUAGE plpgsql
AS $$
DECLARE
i record;
BEGIN

return query execute format('select courseid,credits,sem,year,grade from %I',studentid||'_t');

END;
$$;
-- select transcript_table('2019csb1072');