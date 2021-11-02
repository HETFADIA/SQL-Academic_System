-- -- Transcript table
-- EXECUTE format('CREATE TABLE %I (
--     courseid varchar(7) primary key,
--     credits real not null,
--     sem integer not null,
--     year integer not null,
--     grade integer not null
--     );', studentid || '_t');
-- -- Enrolled table
-- EXECUTE format('CREATE TABLE %I (
--     courseid varchar(7),
--     sem integer not null,
--     year integer not null,
--     secid integer,
--     primary key(courseid, sem, year)
--     );', studentid || '_e');
-- -- History/Request table
-- EXECUTE format('CREATE TABLE %I (
--     courseid varchar(7) primary key,
--     sem integer not null,
--     secid integer,
--     year integer not null,
--     status varchar(50) not null
--     );', studentid || '_h');
-- END;
-- $$;

-- insert into student_info values('2019csb1072', 'Name Surname', 'CSE');
-- insert into student_info values('2019csb1063', 'Nice Guy', 'CSE');
-- insert into student_info values('2019meb1214', 'Another Guy', 'ME');

create table "2019csb1072_t" (
    courseid varchar(7) primary key,
    credits real not null,
    sem integer not null,
    year integer not null,
    grade integer not null
    );
create table "2019csb1063_t" (
    courseid varchar(7) primary key,
    credits real not null,
    sem integer not null,
    year integer not null,
    grade integer not null
    );

create table "2019csb1072_e"(
    courseid varchar(7),
    sem integer not null,
    year integer not null,
    secid integer,
    primary key(courseid, sem, year)
    );
create table "2019csb1063_e"(
    courseid varchar(7),
    sem integer not null,
    year integer not null,
    secid integer,
    primary key(courseid, sem, year)
    );

insert into "2019csb1072_t" values ('ma101', 3, 1, 2019, 7);
insert into "2019csb1072_t" values ('ge103', 4.5, 1, 2019, 6);
insert into "2019csb1072_t" values ('ns101', 1, 1, 2019, 10);


insert into "2019csb1072_t" values ('cs101', 3, 2, 2019, 8);
insert into "2019csb1072_t" values ('ma102', 3, 2, 2019, 8);
insert into "2019csb1072_t" values ('ma102', 3, 2, 2019, 8);
insert into "2019csb1072_t" values ('ns102', 1, 2, 2019, 10);



insert into "2019csb1072_t" values ('cs201', 4, 1, 2020, 6);
insert into "2019csb1072_t" values ('cs203', 4, 1, 2020, 8);

insert into "2019csb1072_t" values ('cs202', 4, 2, 2020, 8);
insert into "2019csb1072_t" values ('cs204', 4, 2, 2020, 8);

insert into "2019csb1072_e" values ('cs301',  1, 2021, 1);
insert into "2019csb1072_e" values ('cs302',  1, 2021, 1);
insert into "2019csb1072_e" values ('cs303',  1, 2021, 1);
insert into "2019csb1072_e" values ('bm101',  1, 2021, 1);











insert into "2019csb1063_t" values ('ma101', 3, 1, 2019, 7);
insert into "2019csb1063_t" values ('ge103',  4.5, 1, 2019, 8);
insert into "2019csb1063_t" values ('ns101', 1, 1, 2019, 10);


insert into "2019csb1063_t" values ('cs101', 3, 2, 2019, 7);
insert into "2019csb1063_t" values ('ma102', 3, 2, 2019, 8);
insert into "2019csb1063_t" values ('ma102', 3, 2, 2019, 9);
insert into "2019csb1063_t" values ('ns102', 1, 2, 2019, 9);



insert into "2019csb1063_t" values ('cs201', 4, 1, 2020, 9);
insert into "2019csb1063_t" values ('cs203', 4, 1, 2020, 9);

insert into "2019csb1063_t" values ('cs202', 4, 2, 2020, 7);
insert into "2019csb1063_t" values ('cs204', 4, 2, 2020, 9);



insert into "2019csb1063_e" values ('cs301',  1, 2021, 2);
insert into "2019csb1063_e" values ('cs302',  1, 2021, 2);
insert into "2019csb1063_e" values ('cs303',  1, 2021, 2);




insert into "2019meb1214_t" values('cs101', 3, 2, 2019, 9);
insert into "2019meb1214_t" values('ge103', 4.5, 1, 2019, 9);
insert into "2019meb1214_t" values('cs201', 4, 1, 2020, 9);
insert into "2019meb1214_t" values('cs203', 4, 1, 2020, 9);
insert into "2019meb1214_t" values('cs202', 4, 2, 2020, 8);
insert into "2019meb1214_t" values('cs204', 4, 2, 2020, 10);

insert into "2019csb1214_e" values ('cs301',  1, 2021, 2);
insert into "2019csb1214_e" values ('cs302',  1, 2021, 2);
insert into "2019csb1214_e" values ('cs303',  1, 2021, 2);