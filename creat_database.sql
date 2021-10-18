create table course_catalog(
courseid varchar(7) primary key,
L real not null,
T real not null,
P real not null,
S real not null,
C real not null
);

insert into course_catalog values('cs301', 3, 1, 2, 6, 4);
insert into course_catalog values('cs303', 3, 1, 2, 6, 4);
insert into course_catalog values('cs201', 3, 1, 2, 6, 4);
insert into course_catalog values('cs203', 3, 1, 3, 6, 4);
insert into course_catalog values('cs202', 3, 1, 2, 6, 4);
insert into course_catalog values('cs204', 3, 1, 2, 6, 4);
insert into course_catalog values('ge103', 3, 0, 3, 7.5, 4.5);
insert into course_catalog values('cs101', 3, 1, 0, 5, 3);
insert into course_catalog values('ma101', 3, 1, 0, 5, 3);
insert into course_catalog values('cs302', 3, 1, 0, 5, 3);

select * from course_catalog;

create table pre_requisite(
courseid varchar(7) not null,
pre_req varchar(7) not null
);

insert into pre_requisite values('cs201', 'ge103');
insert into pre_requisite values('cs202', 'cs201');
insert into pre_requisite values('cs302', 'cs101');
insert into pre_requisite values('cs302', 'cs201');
insert into pre_requisite values('cs204', 'cs203');
insert into pre_requisite values('cs301', 'cs201');
insert into pre_requisite values('cs302', 'cs204');
insert into pre_requisite values('cs302', 'cs201');

select * from pre_requisite;

create table course_offerings(
courseid varchar(7) not null,
teacherid integer not null,
secid integer not null,
sem integer not null,
year integer not null,
cg real,
primary key(courseid, teacherid, secid)
);

CREATE OR REPLACE FUNCTION create_course_sec_table()
RETURNS TRIGGER
LANGUAGE PLPGSQL
AS $$
BEGIN
-- we will create course grade as well as course enrollment table (any one can view the enrollment table as in aims)
EXECUTE format('CREATE TABLE %I (studentid varchar(12));', NEW.courseid || NEW.secid);
EXECUTE format('CREATE TABLE %I (studentid varchar(12) primary key, grade integer);', NEW.courseid || NEW.secid || '_g');
RETURN NEW;
END;
$$;

CREATE TRIGGER insert_course_offering
BEFORE INSERT
ON course_offerings
FOR EACH ROW
EXECUTE PROCEDURE create_course_sec_table();

-- course, teacherid, sec, sem, yr, cg
insert into course_offerings values('cs301', 2, 1, 1, 2021, 7.0);
insert into course_offerings values('cs302', 3, 1, 1, 2021, 7.0);
-- insert into course_offerings values('cs201', 3, 1, 1, 2021, 0.0);
-- insert into course_offerings values('cs203', 2, 1, 1, 2021, 7.5);
-- insert into course_offerings values('cs303', 1, 1, 1, 2021, 8.0);
-- insert into course_offerings values('ge103', 1, 1, 1, 2021, 0.0);
-- insert into course_offerings values('ma101', 3, 1, 1, 2021, 0.0);
-- insert into course_offerings values('ma101', 2, 2, 1, 2021, 0.0);
-- insert into course_offerings values('ge103', 4, 2, 1, 2021, 0.0);


-----------------------------------------------------------------------------------------------------------
/*
in ref to instructors

GRANT select, insert, update on cs3011_g, cs3021_g to user;
GRANT ALL ON FUNCTION load_grade TO user;
GRANT pg_read_server_files TO user;
*/
CREATE OR REPLACE FUNCTION load_grade(courseid varchar(7), secid integer, file_name varchar(1000))
RETURNS void
LANGUAGE plpgsql
AS $$
DECLARE
csv_path varchar(50);
BEGIN
-- change security to Everyone
csv_path := 'C:\Users\Hp\Downloads\' || file_name || '.csv';
execute format('copy %I from %L with delimiter '','' csv;', courseid || secid || '_g', csv_path);
END;
$$;

CREATE OR REPLACE FUNCTION load_grade_to_transcripts()
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
for ii in (select * from course_offerings) loop
select C from course_catalog where courseid = ii.courseid into credits_now;
keep_track := 0;
execute format('select count(*) from (select studentid from %I except select studentid from %I) as extraguys;', ii.courseid || ii.secid || '_g', ii.courseid || ii.secid) into keep_track;
continue when keep_track > 0;

for jj in execute format('select * from %I;', ii.courseid || ii.secid || '_g') loop
execute format('insert into %I values(%L, %L, %L, %L, %L)', jj.studentid || '_t', ii.courseid, credits_now, ii.sem, ii.year, jj.grade);
end loop;
end loop;
END;
$$;

--------------------------------------------------------------------------------------------------------

create table course_catalog(
courseid varchar(7) primary key,
L real not null,
T real not null,
P real not null,
S real not null,
C real not null
);