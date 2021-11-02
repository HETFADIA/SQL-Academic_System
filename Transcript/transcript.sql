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
-- select transcript_table1('2019csb1072');


-- CREATE OR REPLACE FUNCTION load_grade_to_transcripts()
-- RETURNS void
-- LANGUAGE plpgsql
-- AS $$
-- DECLARE
-- ii record;
-- jj record;
-- credits_now integer;
-- r record;
-- keep_track integer;
-- BEGIN
-- /*
--     Only used by academic section to update all the grades into the student transcript tables
-- */
-- for ii in (select * from course_offerings) loop
-- select C from course_catalog where courseid = ii.courseid into credits_now;
-- keep_track := 0;
-- execute format('select count(*) from (select studentid from %I except select studentid from %I) as extraguys;', ii.courseid || ii.secid || '_g', ii.courseid || ii.secid) into keep_track;
-- continue when keep_track > 0;

-- for jj in execute format('select * from %I;', ii.courseid || ii.secid || '_g') loop
-- execute format('insert into %I values(%L, %L, %L, %L, %L)', jj.studentid || '_t', ii.courseid, credits_now, ii.sem, ii.year, jj.grade);
-- end loop;
-- end loop;
-- END;
-- $$;

create  table cs3011_g(
    studentid varchar(12),
    courseid varchar(12),
    credits real,
    sem int,
    year int,
    grade int
    );

create table cs3011(
    studentid varchar(12),
    courseid varchar(12),
    credits real,
    sem int,
    year int,
    grade int
    );

insert into cs3011_g values('2019csb1072','cs301',3.0,1,2019,4);
insert into cs3011 values('2019csb1072','cs301',3.0,1,2019,4);
select * from cs3011_g;
select * from cs3011;
select * from cs3011_g except select * from cs3011;

CREATE OR REPLACE FUNCTION load_grade_to_transcripts(_courseid varchar(7),_secid integer,_year int,_sem int)
RETURNS void
LANGUAGE plpgsql
AS $$
DECLARE
ii record;
jj record;
credits_now integer;
r record;
keep_track integer;
BEGIN
/*
    Only used by academic section to update all the grades into the student transcript tables
*/

select C from course_catalog  where courseid = _courseid into credits_now;
keep_track := 0;
execute format('select count(*) from (select studentid from %I except select studentid from %I) as extraguys;', _courseid || _secid || '_g', _courseid || _secid) into keep_track;

if(keep_track>0) then
    raise exception '%','The grades have not been updated yet';
end if;


for jj in execute format('select * from %I;', _courseid || _secid || '_g') loop
execute format('insert into %I values(%L, %L, %L, %L, %L)', jj.studentid || '_t', _courseid, credits_now, _sem, _year, jj.grade);
end loop;

END;
$$;


select load_grade_to_transcripts('cs301',1,1,2021);

CREATE OR REPLACE FUNCTION semsg(studentid varchar(12),sem_a integer, year_a integer)
RETURNS real
LANGUAGE PLPGSQL
AS $$
DECLARE
sg real;
num real;
den real;
BEGIN
-- EXECUTE format('select count(*) from %I where coach like %L', 'empty_seats_'||train_id||to_char(date,'_yyyy_mm_dd'), coach_type ||'%') into available;
EXECUTE format('select sum(grade * credits) from %I where sem=%L and year=%L;', studentid||'_t', sem_a, year_a) into num;
EXECUTE format('select sum(credits) from %I where sem=%L and year=%L;', studentid||'_t', sem_a, year_a) into den;
sg := num / den;
return sg;
-- select sum(grade * credit) into num from current_user+'_t'
END;
$$;


CREATE OR REPLACE FUNCTION generate_transcripts(studentid varchar(12),_sem integer, _year integer)
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
ret real;
sum_c real;
RT record;
BEGIN
raise notice '% %',_sem,_year;
if(_sem=0 and _year=0) then 
        ret := 0.0;
        sum_c := 0.0;
        -- grade < 4.0 is fail and not counted in CG
        for RT in execute format('select * from %I where grade > 4.0', studentid || '_t') loop
        sum_c := sum_c + RT.credits;
        ret := ret + RT.credits * RT.grade;
        end loop;

        ret := ret / sum_c;

        raise notice 'The current CGPA of % is %', studentid, ret;
        return query execute format('select courseid,credits,sem,year,grade from %I',studentid||'_t');
else
        ret := semsg(studentid,_sem, _year);
        raise notice 'The SG of % in % sem and % year is %', studentid, _sem , _year, ret;
        return query execute format('select courseid,credits,sem,year,grade from %I where sem=%L and year=%L',studentid||'_t',_sem,_year);

end if;


END;
$$;


select * from generate_transcripts('2019csb1063',1,2019);
select * from generate_transcripts('2019csb1063',0,0);