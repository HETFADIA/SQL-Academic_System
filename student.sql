CREATE OR REPLACE FUNCTION create_student(studentid varchar(12))
RETURNS void
LANGUAGE PLPGSQL
AS $$
BEGIN
EXECUTE format('CREATE USER %I WITH PASSWORD ''123''', studentid);
-- Transcript table
EXECUTE format('CREATE TABLE %I (
    courseid varchar(7) primary key,
    credits real not null,
    sem integer not null,
    year integer not null,
    grade integer not null
    );', studentid || '_t');
-- Enrolled table
EXECUTE format('CREATE TABLE %I (
    courseid varchar(7),
    sem integer not null,
    year integer not null,
    primary key(courseid, sem, year)
    );', studentid || '_e');
-- History/Request table
EXECUTE format('CREATE TABLE %I (
    courseid varchar(7) primary key,
    sem integer not null,
    secid integer,
    year integer not null,
    status varchar(50) not null
    );', studentid || '_h');
END;
$$;

select create_student('2019csb1084');

insert into "2019csb1084_e" values('cs301', 1, 2021);
insert into "2019csb1084_e" values('cs302', 1, 2021);
insert into "2019csb1084_e" values('cs303', 1, 2021);
insert into "2019csb1084_e" values('cs201', 1, 2020);
insert into "2019csb1084_e" values('cs202', 1, 2020);
insert into "2019csb1084_e" values('cs203', 1, 2020);
insert into "2019csb1084_e" values('ge103', 1, 2019);
insert into "2019csb1084_e" values('ma101', 1, 2019);

select * from "2019csb1084_e";



select create_student('postgres');

insert into postgres_e values('cs301', 1, 2021);
insert into postgres_e values('cs302', 1, 2021);
insert into postgres_e values('cs303', 1, 2021);
insert into postgres_e values('cs201', 1, 2020);
insert into postgres_e values('cs202', 1, 2020);
insert into postgres_e values('cs203', 1, 2020);
insert into postgres_e values('ge103', 1, 2019);
insert into postgres_e values('ma101', 1, 2019);

select * from postgres_e;


CREATE OR REPLACE FUNCTION check_enrollment()
RETURNS TRIGGER
LANGUAGE PLPGSQL
AS $$
DECLARE
PR record;
avg_last_two_sem_credit real;
this_sem_credit real;
this_course_credit real;
BEGIN
--execute format('INSERT INTO %I VALUES(%L)',  current_user || '_e', courseid);
-- NEW.courseid, course offering table
-- check course existence
-- pre_req
-- batch
-- time-table
-- 1.25 rule
if NEW.courseid not in (select course_offerings.courseid from course_offerings) then
raise exception 'Invalid Course !!';
end if;

for PR in (select * from pre_requisite where pre_requisite.courseid =  NEW.courseid) loop
if PR.pre_req not in EXECUTE format('select courseid from %I where grade >= 4;', current_user || '_t') then
raise exception 'Prequisite not satisfied !!';
end if;
end loop;

-- 2019csb1119 -> 2019csb
if substr(current_user, 1, 7) not in (select course_batches.batch from course_batches where course_batches.courseid = NEW.courseid) then
raise exception 'Course !!';
end if;

-- timetable

--1.25 rule
select lasttwosemcredit() into avg_last_two_sem_credit;
EXECUTE format('select sum(credits) from %I where sem=%L and year=%L;', current_user||'_t', sem_c, year_c) into this_sem_credit;
select credits into this_course_credit from course_catalog where courseid = NEW.courseid;
this_sem_credit := this_sem_credit + this_course_credit;
avg_last_two_sem_credit := 1.25 * avg_last_two_sem_credit;
if this_sem_credit > avg_last_two_sem_credi then
raise exception 'Credit Limit Exceeded!!';
end if;
RETURN NEW;
END;
$$;

CREATE TRIGGER check_enrollment
BEFORE INSERT
ON postgres_e
FOR EACH ROW
EXECUTE PROCEDURE check_enrollment();