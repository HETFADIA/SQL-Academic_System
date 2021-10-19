CREATE OR REPLACE FUNCTION add_tables(studentid varchar(12))
RETURNS void
LANGUAGE PLPGSQL
AS $$
BEGIN
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



select add_tables('postgres');

insert into postgres_e values('cs301', 1, 2021);
insert into postgres_e values('cs302', 1, 2021);
insert into postgres_e values('cs303', 1, 2021);
insert into postgres_e values('cs201', 1, 2020);
insert into postgres_e values('cs202', 1, 2020);
insert into postgres_e values('cs203', 1, 2020);
insert into postgres_e values('cs204', 1, 2020);
insert into postgres_e values('ge103', 1, 2019);
insert into postgres_e values('ma101', 1, 2019);

select * from postgres_e;