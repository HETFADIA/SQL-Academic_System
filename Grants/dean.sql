create user dean with PASSWORD '123';

-- GRANT ALL ON course_batches TO dean;
-- GRANT ALL ON course_catalog TO dean;
-- GRANT ALL ON pre_requisite TO dean;
-- GRANT ALL ON course_offerings TO dean;
-- GRANT ALL ON time_table TO dean;

-- REVOKE ALL ON ALL TABLES IN SCHEMA public FROM dean;
GRANT SELECT, UPDATE, INSERT, DELETE ON ALL TABLES IN SCHEMA public TO dean;
ALTER DEFAULT PRIVILEGES IN SCHEMA PUBLIC GRANT SELECT, INSERT, UPDATE, DELETE ON TABLES TO dean;
-- insert into student_info values('2019csb1072', 'Name Surname', 'CSE');
-- insert into student_info values('2019eeb1063', 'Nice Guy', 'EE');
-- insert into student_info values('2019meb1214', 'Another Guy', 'ME');
-- insert into student_info values('2019mmb1372', 'Random guy', 'MM');
-- insert into student_info values('2019mcb1141', 'Another One', 'MNC');
-- insert into student_info values('2019chb1217', 'Guy Random', 'CH');
-- insert into student_info values('2019ceb1319', 'Guy Random', 'CE');
insert into "2019ceb1319_t" values ('ma101', 3, 1, 2019, 7);
insert into "2019ceb1319_t" values ('ge103', 4.5, 1, 2019, 8);
insert into "2019ceb1319_t" values ('ns101', 1, 1, 2019, 7);

insert into "2019ceb1319_t" values ('cs101', 3, 2, 2019, 7);
insert into "2019ceb1319_t" values ('ma102', 3, 2, 2019, 8);
insert into "2019ceb1319_t" values ('ma102', 3, 2, 2019, 7);
insert into "2019ceb1319_t" values ('ns102', 1, 2, 2019, 6);

insert into "2019ceb1319_t" values ('cs201', 4, 1, 2020, 8);
insert into "2019ceb1319_t" values ('cs203', 4, 1, 2020, 7);

insert into "2019ceb1319_t" values ('cs202', 4, 2, 2020, 8);
insert into "2019ceb1319_t" values ('cs204', 4, 2, 2020, 7);