/*

EXECUTE format('CREATE TABLE %I (
    courseid varchar(7) primary key,
    sem integer not null,
    year integer not null,
    status varchar(50) not null
    );', studentid || '_h');
    


    create table course_offerings students(
courseid varchar(7) not null,
teacherid integer not null,
secid integer not null,
sem intger not null,
year integer not null,
cg real,
primary key(courseid, teacherid, secid)
);

-- History/Request table of instructor request
EXECUTE format('CREATE TABLE %I (
    courseid varchar(7) primary key,
    sem integer not null,
    year integer not null,
    status varchar(50) not null,
    secid integer not null,
    entry_no varchar(10)
    );', studentid || '_h');

-- History/Request table of batch advisor
EXECUTE format('CREATE TABLE %I (
    courseid varchar(7) primary key,
    sem integer not null,
    year integer not null,
    status varchar(50) not null,
    secid integer not null,
    entry_no varchar(10)
    );', studentid || '_h');

    table of dean for request/history
EXECUTE format('CREATE TABLE %I (
    courseid varchar(7) primary key,
    sem integer not null,
    year integer not null,
    status varchar(50) not null,
    secid integer not null,
    entry_no varchar(10)
    );', studentid || '_h');
    */
CREATE OR REPLACE FUNCTION student_request()
RETURNS TRIGGER
LANGUAGE PLPGSQL
AS $$
DECLARE
_instructorid integer;
BEGIN
select instructorid into _instructorid from course_offerings where NEW.courseid=courseid and NEW.secid=secid;
execute format('INSERT INTO %I VALUES(%L,%L,%L,%L,%L,%L)',  _instructorid || '_h',NEW.courseid,NEW.sem,NEW.year,'pending instructor approved',NEW.secid,current_user);
END;
$$;

-- shows the changes the request 
CREATE TRIGGER student_request
AFTER INSERT
ON postgret_h
FOR EACH ROW
EXECUTE PROCEDURE student_request();


CREATE OR REPLACE FUNCTION teacher_request()
RETURNS TRIGGER
LANGUAGE PLPGSQL
AS $$
DECLARE
batchadvisorid varchar(7);
BEGIN
-- execute format('INSERT INTO %I VALUES(%L,%L,%L,%L,%L)',  current_user || '_h', NEW.courseid,NEW.sem,NEW.year,NEW.secid,NEW.status);

/*
UPDATE current_user || '_h'
SET status=NEW.status
WHERE courseid=NEW.courseid;
*/
if NEW.status='Y' then
-- 'instructor approved '
batchadvisor := substr(entry_no, 1, 7);
execute format('INSERT INTO %I VALUES(%L,%L,%L,%L,%L)',  batchadvisor || '_h',NEW.courseid,NEW.sem,NEW.year,NEW.secid,'pending batch advisor approval');
execute format('UPDATE %I SET status=%L WHERE courseid=%L',  entry_no || '_h', 'pending batch advisor approval',NEW.courseid);
;
ELSIF NEW.status='N' THEN
execute format('UPDATE %I SET status=%L WHERE courseid=%L',  entry_no || '_h', 'instructor declined',NEW.courseid);
END if;
END;
$$;

CREATE TRIGGER teacher_request
AFTER UPDATE
ON postgret_h
FOR EACH ROW
EXECUTE PROCEDURE teacher_request();

CREATE OR REPLACE FUNCTION batch_advisor_request()
RETURNS TRIGGER
LANGUAGE PLPGSQL
AS $$
DECLARE
_instructorid integer;
batchadvisorid varchar(7);
BEGIN
batchadvisor := substr(entry_no, 1, 7);
select instructorid into _instructorid from course_offerings where NEW.courseid=courseid and NEW.secid=secid;
if NEW.status='Y' then
-- 'instructor approved '

execute format('INSERT INTO %I VALUES(%L,%L,%L,%L,%L)',  'dean' || '_h',NEW.courseid,NEW.sem,NEW.year,NEW.secid,'pending dean approval');
execute format('UPDATE %I SET status=%L WHERE courseid=%L',  entry_no || '_h', 'pending dean approval',NEW.courseid);
execute format('UPDATE %I SET status=%L WHERE courseid=%L',  _instructorid || '_h', 'pending dean approval',NEW.courseid);
ELSIF NEW.status='N' THEN

execute format('UPDATE %I SET status=%L WHERE courseid=%L',  entry_no || '_h', 'batch advisor declined',NEW.courseid);
execute format('UPDATE %I SET status=%L WHERE courseid=%L',  _instructorid || '_h', 'batch advisor declined',NEW.courseid);
END IF;
END;
$$;

CREATE TRIGGER batch_advisor_request
AFTER UPDATE
ON postgret_h
FOR EACH ROW
EXECUTE PROCEDURE batch_advisor_request();

CREATE OR REPLACE FUNCTION to_dean_request()
RETURNS TRIGGER
LANGUAGE PLPGSQL
AS $$
DECLARE
_instructorid integer;
batchadvisorid varchar(7);
BEGIN
batchadvisor := substr(entry_no, 1, 7);
select instructorid into _instructorid from course_offerings where NEW.courseid=courseid and NEW.secid=secid;
if NEW.status='Y' THEN
-- 'instructor approved '
execute format('UPDATE %I SET status=%L WHERE courseid=%L',  batchadvisor || '_h', 'enrolled',NEW.courseid);
execute format('UPDATE %I SET status=%L WHERE courseid=%L',  _instructorid || '_h', 'enrolled',NEW.courseid);
execute format('UPDATE %I SET status=%L WHERE courseid=%L',  entry_no || '_h', 'enrolled',NEW.courseid);
ELSIF NEW.status='N' THEN
execute format('UPDATE %I SET status=%L WHERE courseid=%L',  batchadvisor || '_h', 'dean declined',NEW.courseid);
execute format('UPDATE %I SET status=%L WHERE courseid=%L',  _instructorid || '_h', 'dean declined',NEW.courseid);
execute format('UPDATE %I SET status=%L WHERE courseid=%L',  entry_no || '_h', 'dean declined',NEW.courseid);
END IF;
END;
$$;

CREATE TRIGGER to_dean_request
AFTER UPDATE
ON postgret_h
FOR EACH ROW
EXECUTE PROCEDURE to_dean_request();