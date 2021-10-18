create table course_catalog(
courseid varchar(7) primary key,
L real not null,
T real not null,
P real not null,
S real not null,
C real not null
);

insert into course_catalog values('CS301', 3, 1, 2, 6, 4);
insert into course_catalog values('CS303', 3, 1, 2, 6, 4);
insert into course_catalog values('CS201', 3, 1, 2, 6, 4);
insert into course_catalog values('CS203', 3, 1, 3, 6, 4);
insert into course_catalog values('CS202', 3, 1, 2, 6, 4);
insert into course_catalog values('CS204', 3, 1, 2, 6, 4);
insert into course_catalog values('GE103', 3, 0, 3, 7.5, 4.5);
insert into course_catalog values('CS101', 3, 1, 0, 5, 3);
insert into course_catalog values('MA101', 3, 1, 0, 5, 3);
insert into course_catalog values('CS302', 3, 1, 0, 5, 3);

select * from course_catalog;

create table pre_requisite(
courseid varchar(7) not null,
pre_req varchar(7) not null
);

insert into pre_requisite values('CS201', 'GE103');
insert into pre_requisite values('CS202', 'CS201');
insert into pre_requisite values('CS302', 'CS101');
insert into pre_requisite values('CS302', 'CS201');
insert into pre_requisite values('CS204', 'CS203');
insert into pre_requisite values('CS301', 'CS201');
insert into pre_requisite values('CS302', 'CS204');
insert into pre_requisite values('CS302', 'CS201');

select * from pre_requisite;

create table course_offerings(
courseid varchar(7) not null,
teacherid integer not null,
secid integer not null,
sem intger not null,
year integer not null,
cg real,
primary key(courseid, teacherid, secid)
);

CREATE OR REPLACE FUNCTION create_course_sec_table()
RETURNS TRIGGER
LANGUAGE PLPGSQL
AS $$
DECLARE
seat record;
BEGIN
EXECUTE format('CREATE TABLE %I (pnr bigint primary key, booking_agent varchar(256));', 'bookings_' || NEW.train_id::text || '_' || to_char(NEW.date, 'yyyy_mm_dd'));
EXECUTE format('CREATE TABLE %I (coach char(5), berth integer, primary key(coach, berth));', 'empty_seats_' || NEW.train_id::text || '_' || to_char(NEW.date, 'yyyy_mm_dd'));
RETURN NEW;
END;
$$;

CREATE TRIGGER insert_course_offering
BEFORE INSERT
ON course_offerings
FOR EACH ROW
EXECUTE PROCEDURE create_course_sec_table();



/*
CREATE OR REPLACE FUNCTION random_check_function()
RETURNS real
LANGUAGE PLPGSQL
AS $$
DECLARE
cnt real;
cnt2 real;
BEGIN
select count(*) into cnt from course_catalog;
cnt := cnt + 10;
cnt := cnt / 6;

select count(*) into cnt2 from course_catalog;
cnt := cnt + cnt2;
RETURN cnt;
END;
$$;

CREATE OR REPLACE FUNCTION nicenice(courseid varchar(7))
RETURNS TABLE(
    pre_req varchar(7)
)
LANGUAGE PLPGSQL
AS $$
BEGIN
return query EXECUTE format('select pre_req from pre_requisite where pre_requisite.courseid = %L;', courseid);
END;
$$;
*/

-- Enroll ?
-- Course enrollment table 
-- 

-- Student
-- Transcript table, Enrolled table, Request/History table (only when 1.25 rule breaks)

-- Teacher
-- Enrolled table, Grade table, REQUEST

-- BA
-- REQUEST

-- DEAN
-- REQUEST + extra

-- Student tables exists
-- Triggers
-- Enroll, History

-- xyz(course); -> (current_user)
--(2019CSB1119_T), (2019CSB1119_E), ...

CREATE TABLE postgres_e(
    courseid varchar(7) primary key
);

CREATE OR REPLACE FUNCTION enroll(courseid varchar(7))
RETURNS void
LANGUAGE PLPGSQL
AS $$
BEGIN
execute format('INSERT INTO %I VALUES(%L)',  current_user || '_e', courseid);
END;
$$;

-- sg=summation(credit*grade)/sumattion(credit) for each courses in that sem,year
CREATE OR REPLACE FUNCTION semsg(sem_a integer, year_a integer)
RETURNS real
LANGUAGE PLPGSQL
AS $$
DECLARE
sg real;
num real;
den real;
BEGIN
-- EXECUTE format('select count(*) from %I where coach like %L', 'empty_seats_'||train_id||to_char(date,'_yyyy_mm_dd'), coach_type ||'%') into available;
EXECUTE format('select sum(grade * credits) from %I where sem=%L and year=%L;', current_user||'_t', sem_a, year_a) into num;
EXECUTE format('select sum(credits) from %I where sem=%L and year=%L;', current_user||'_t', sem_a, year_a) into den;
sg := num / den;
return sg;
-- select sum(grade * credit) into num from current_user+'_t'
END;
$$;

-- sum(credtis) for each courses in that sem,year
CREATE OR REPLACE FUNCTION semcredits(sem_a integer, year_a integer)
RETURNS real
LANGUAGE PLPGSQL
AS $$
DECLARE
den int;
BEGIN
-- EXECUTE format('select count(*) from %I where coach like %L', 'empty_seats_'||train_id||to_char(date,'_yyyy_mm_dd'), coach_type ||'%') into available;

EXECUTE format('select sum(credits) from %I where sem=%L and year=%L;', current_user||'_t', sem_a, year_a) into den;
return den;
-- select sum(grade * credit) into num from current_user+'_t'
END;
$$;

CREATE TABLE current_ay(
    sem integer,
    year integer
);

CREATE OR REPLACE FUNCTION lasttwosemcredit()
RETURNS real
LANGUAGE PLPGSQL
AS $$
DECLARE
last_credit real;
last2_credit real;
avg_credit real;
sem_c integer;
year_c integer;
BEGIN
select (sem,year) into (sem_c,year_c) from current_ay;


-- going to the prev semester courses
if sem_c=2 then 
sem_c=1;

else 
    sem_c=2;
    year_c=year_c-1;
end if;
-- select sum(credits) into last_credit from postgres_t where sem=sem_c and year=year_c;
EXECUTE format('select sum(credits) from %I where sem=%L and year=%L;', current_user||'_t', sem_c, year_c) into last_credit;

if sem_c=2 then 
sem_c=1;
year_c=year_c-1;
else 
    sem_c=2;
end if;
EXECUTE format('select sum(credits) from %I where sem=%L and year=%L;', current_user||'_t', sem_c, year_c) into last_credit2;
avg_credit=(last_credit+last2_credit)/2.0;
return avg_credit;
END;
$$;


-- postgres_t 
CREATE TABLE postgres_t (
    courseid varchar(7) primary key,
    credits real not null,
    sem integer not null,
    year integer not null,
    grade integer not null
);
insert into postgres_t values('MA101',3,1,2019,2);
insert into postgres_t values('CS101',3,2,2019,9);
insert into postgres_t values('CS201',4,1,2020,10);
insert into postgres_t values('CS204',4,2,2020,8);
insert into postgres_t values('BM101',3,2,2020,8);
insert into postgres_t values('GE107',1.5,2,2020,9);
insert into postgres_t values('CS301',4,1,2021,8);
insert into postgres_t values('CS302',3,1,2021,9);
insert into postgres_t values('CS303',4,1,2021,7);


-- insert into course_catalog values('CS301', 3, 1, 2, 6, 4);
-- insert into pre_requisite values('CS201', 'GE103');
-- EXECUTE format('CREATE TABLE %I (
--     courseid varchar(7) primary key,
--     credits real not null,
--     sem integer not null,
--     year integer not null,
--     grade integer not null
--     );', studentid || '_t');


CREATE OR REPLACE FUNCTION check_enrollment()
RETURNS TRIGGER
LANGUAGE PLPGSQL
AS $$
DECLARE
PR record;
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



RETURN NEW;
END;
$$;

CREATE TRIGGER check_enrollment
BEFORE INSERT
ON postgres_e
FOR EACH ROW
EXECUTE PROCEDURE check_enrollment();


--
-- 2019 csb 1119 (lower case only)
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
    year integer not null,
    status varchar(50) not null,
    secid integer not null
    );', studentid || '_h');
END;
$$;
/*
-- History/Request table of teacher
EXECUTE format('CREATE TABLE %I (
    treacherid varchar(7),
    courseid varchar(7) primary key,
    sem integer not null,
    year integer not null,
    
    );', studentid || '_h');
    */