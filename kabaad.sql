/*
CREATE OR REPLACE FUNCTION neci()
RETURNS TRIGGER
LANGUAGE PLPGSQL
AS $$
DECLARE
str varchar(100);
BEGIN
str := '' || NEW.courseid || NEW.pre_req || ' __ ' || OLD.courseid || OLD.pre_req;
raise notice 'Value: %', str;
return NEW;
END;
$$;

CREATE TRIGGER niceh
AFTER UPDATE
ON pre_requisite
FOR EACH ROW
EXECUTE PROCEDURE neci();

UPDATE pre_requisite SET pre_req = 'changed' where courseid = 'cs201';
*/

CREATE OR REPLACE FUNCTION ticket(course varchar(12), sm integer, sec integer, yr integer)
RETURNS void
LANGUAGE PLPGSQL
AS $$
BEGIN

END;
$$;


create table "2928_h"(
    nice integer
);
insert into "2928_h" values(10);
select * from "2928_h";


------------------------------------

create table student_info(
    studentid varchar(12) primary key,
    _name varchar(50) not null,
    dept_name varchar(20) not null
);

insert into student_info values('2019csb1119', 'Shikhar Soni', 'CSE');
insert into student_info values('2019csb1084', 'Het Fadia', 'CSE');
-- insert into student_info values('2019csb1064', 'Aditya Agarwal', 'CSE');
-- insert into student_info values('2019csb1072', 'Name Surname', 'CSE');
-- insert into student_info values('2019csb1063', 'Nice Guy', 'CSE');
-- insert into student_info values('2019meb1214', 'Another Guy', 'ME');
-- insert into student_info values('2019med1252', 'Some One', 'ME_dual');
-- insert into student_info values('2019mcb1141', 'Another One', 'MNC');
-- insert into student_info values('2019mmb1372', 'Random guy', 'MMB');
-- insert into student_info values('2019meb1217', 'Guy Random', 'ME');

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
    secid integer,
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

CREATE OR REPLACE FUNCTION generate_students()
RETURNS void
LANGUAGE PLPGSQL
AS $$
DECLARE
i record;
BEGIN
-- this function generates 10 students for testing every functionality appropriately

for i in (select * from student_info)
loop
perform create_student(i.studentid);
execute format('GRANT select on %I to %I', i.studentid || '_t', i.studentid);
-- grant them select to enrollment table of course on enrollment too
execute format('GRANT select, insert on %I, %I to %I', i.studentid || '_e', i.student || '_h', i.studentid);

end loop;

END;
$$;

create table instrutor_info(
    teacherid varchar(12) primary key,
    _name varchar(50) not null,
    dept_name varchar(20) not null,
    courseid integer,
    secid integer
);

insert into instructor_info values('2019csb1119', 'Shikhar Soni', 'CSE');