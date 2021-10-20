CREATE TABLE time_table(
    courseid varchar(7) not null,
    slot integer not null,
    PRIMARY KEY(courseid,slot)
);
-- insert into course_catalog values('cs301', 3, 1, 2, 6, 4);
-- insert into course_catalog values('cs303', 3, 1, 2, 6, 4);
-- insert into course_catalog values('cs201', 3, 1, 2, 6, 4);
-- insert into course_catalog values('cs203', 3, 1, 3, 6, 4);
-- insert into course_catalog values('cs202', 3, 1, 2, 6, 4);
-- insert into course_catalog values('cs204', 3, 1, 2, 6, 4);
-- insert into course_catalog values('ge103', 3, 0, 3, 7.5, 4.5);
-- insert into course_catalog values('cs101', 3, 1, 0, 5, 3);
-- insert into course_catalog values('ma101', 3, 1, 0, 5, 3);
-- insert into course_catalog values('cs302', 3, 1, 0, 5, 3);
insert into time_table values('cs301',11);
insert into time_table values('cs301',12);
insert into time_table values('cs301',13);
insert into time_table values('cs301',14);

insert into time_table values('cs303',15);
insert into time_table values('cs303',16);
insert into time_table values('cs303',17);
insert into time_table values('cs303',18);

insert into time_table values('cs201',19);
insert into time_table values('cs201',21);
insert into time_table values('cs201',22);
insert into time_table values('cs201',23);

insert into time_table values('cs203',24);
insert into time_table values('cs203',25);
insert into time_table values('cs203',26);
insert into time_table values('cs203',27);

insert into time_table values('cs202',11);
insert into time_table values('cs202',28);
insert into time_table values('cs202',29);
insert into time_table values('cs202',30);

insert into time_table values('cs204',31);
insert into time_table values('cs204',32);
insert into time_table values('cs204',33);
insert into time_table values('cs204',34);

insert into time_table values('ge103',31);
insert into time_table values('ge103',35);
insert into time_table values('ge103',36);

insert into time_table values('cs101',37);
insert into time_table values('cs101',38);
insert into time_table values('cs101',39);
insert into time_table values('cs101',40);

insert into time_table values('ma101',41);
insert into time_table values('ma101',42);
insert into time_table values('ma101',43);
insert into time_table values('ma101',44);

insert into time_table values('cs302',45);
insert into time_table values('cs302',46);
insert into time_table values('cs302',47);
insert into time_table values('cs302',48);

CREATE TABLE course_batches(
    courseid varchar(7) not null,
    secid integer not null,
    sem integer not null,
    year integer not null,
    batch varchar(10) not null
);

insert into course_batches values('ma101', 1, 1, 2021, '2021csb');
insert into course_batches values('ma101', 2, 1, 2021, '2021csb');
insert into course_batches values('ma101', 1, 1, 2021, '2021mnc');
insert into course_batches values('ma101', 2, 1, 2021, '2021mnc');
insert into course_batches values('ma101', 1, 1, 2021, '2021mcb');
insert into course_batches values('ma101', 2, 1, 2021, '2021mcb');
insert into course_batches values('ma101', 1, 1, 2021, '2021med');
insert into course_batches values('ma101', 2, 1, 2021, '2021med');
insert into course_batches values('ma101', 1, 1, 2021, '2021mmb');
insert into course_batches values('ma101', 2, 1, 2021, '2021mmb');

insert into course_batches values('ge103', 1, 1, 2021, '2021csb');
insert into course_batches values('ge103', 2, 1, 2021, '2021csb');
insert into course_batches values('ge103', 1, 1, 2021, '2021mcb');
insert into course_batches values('ge103', 2, 1, 2021, '2021mcb');
insert into course_batches values('ge103', 1, 1, 2021, '2021meb');
insert into course_batches values('ge103', 2, 1, 2021, '2021meb');
insert into course_batches values('ge103', 1, 1, 2021, '2021med');
insert into course_batches values('ge103', 2, 1, 2021, '2021med');
insert into course_batches values('ge103', 1, 1, 2021, '2021mmb');
insert into course_batches values('ge103', 2, 1, 2021, '2021mmb');

insert into course_batches values('cs101', 1, 1, 2021, '2021csb');
insert into course_batches values('cs101', 1, 1, 2021, '2021mcb');

insert into course_batches values('cs201', 1, 1, 2021, '2020csb');
insert into course_batches values('cs203', 1, 1, 2021, '2020csb');
insert into course_batches values('cs201', 1, 1, 2021, '2020mcb');
insert into course_batches values('cs203', 1, 1, 2021, '2020mcb');
insert into course_batches values('cs202', 1, 2, 2021, '2020csb');
insert into course_batches values('cs204', 1, 2, 2021, '2020csb');
insert into course_batches values('cs202', 1, 2, 2021, '2020mcb');
insert into course_batches values('cs204', 1, 2, 2021, '2020mcb');

insert into course_batches values('cs301', 1, 1, 2021, '2019csb');
insert into course_batches values('cs301', 1, 1, 2021, '2019mcb');
insert into course_batches values('cs302', 1, 1, 2021, '2019csb');
insert into course_batches values('cs302', 1, 1, 2021, '2019mcb');
insert into course_batches values('cs303', 1, 1, 2021, '2019csb');
insert into course_batches values('cs303', 1, 1, 2021, '2019mcb');
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

SELECT 'DROP FUNCTION' || oid::regprocedure
FROM   pg_proc
WHERE  proname = 'my_function_name'  -- name without schema-qualification
AND    pg_function_is_visible(oid);  -- restrict to current search_path

GRANT ALL ON PROCEDURE load_grade TO ab;

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



CREATE OR REPLACE FUNCTION enroll(courseid varchar(7),secid integer)
RETURNS void
LANGUAGE PLPGSQL
AS $$
DECLARE
ret record;
BEGIN
select yearsem() into ret;
execute format('INSERT INTO %I VALUES(%L, %L, %L,%L)',  current_user || '_e', courseid, ret.year, ret.sem,secid);
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

-- CREATE TABLE current_ay(
--     sem integer,
--     year integer
-- );

CREATE OR REPLACE FUNCTION yearsem()
RETURNS RECORD
LANGUAGE PLPGSQL
AS $$
DECLARE
ret record;
BEGIN
select extract(year from now()) as year, extract(month from now()) as sem into ret;

if ret.sem <=6 then
ret.sem=2;
ret.year=ret.year-1;
else
ret.sem=1;
end if;

return ret;
END;
$$;

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
-- select (sem,year) into (sem_c,year_c) from current_ay;
-- sem_c and year_c from current time
select yearsem() into (year_c, sem_c);

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

/*
time table
1 to 5 for mon to friday
time slot
1 for 9 to 10
2 for 10 to 11
3 for 11 to 12
4 for 12 to 1
5 for 1 to 2
...

*/
CREATE TABLE time_table_slot(
    courseid varchar(7),
    slot integer
);
CREATE OR REPLACE FUNCTION enrollment_clashes(_courseid varchar(7))
RETURNS integer
LANGUAGE PLPGSQL
AS $$
DECLARE
ret integer:=0;
_slot integer;
BEGIN
-- execute format('select courseid from %I;',current_user||'_e');
-- select slot into ret from time_table where time_table.courseid=_courseid;
-- (select "2019csb1084_e".courseid from "2019csb1084_e")
-- execute format ('select %I.courseid from %I',current_user||'_e', current_user||'_e');
-- (select postgres_e.courseid from postgres_e)
for _slot in execute format('select slot from time_table where time_table.courseid in (select courseid from %I)',current_user||'_e')
loop
    if _slot in (select slot from time_table where time_table.courseid=_courseid) 
    then 
        raise exception 'this slot % clashes with other courses slots',_slot;
        ret:=ret+1;
    end if;
end loop;
return ret;
END;
$$;

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
if substr(current_user, 1, 7) not in (select course_batches.batch from course_batches where course_batches.courseid = NEW.courseid and course_batches.secid=NEW.secid) then
raise exception 'Course !!';
end if;

-- timetable
select enrollment_clashes(NEW.courseid);

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
    secid integer not null,
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

