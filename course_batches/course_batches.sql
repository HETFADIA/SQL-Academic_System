drop table course_batches;
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

-- insert into course_catalog values('ma101', 3, 1, 0, 5, 3);
-- insert into course_catalog values('cs101', 3, 1, 0, 5, 3);
-- insert into course_catalog values('cs201', 3, 1, 2, 6, 4);
-- insert into course_catalog values('cs202', 3, 1, 2, 6, 4);
-- insert into course_catalog values('cs203', 3, 1, 3, 6, 4);
-- insert into course_catalog values('cs204', 3, 1, 2, 6, 4);
-- insert into course_catalog values('cs301', 3, 1, 2, 6, 4);
-- insert into course_catalog values('cs302', 3, 1, 0, 5, 3);
-- insert into course_catalog values('cs303', 3, 1, 2, 6, 4);
-- insert into course_catalog values('ge103', 3, 0, 3, 7.5, 4.5);


-- cse mnc mech mech dual mmb
-- cse csb
-- mnc mcb
-- mech meb
-- mech dual med
-- metullargy mmb


select * from course_batches;