drop table time_table;
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

drop function enrollment_clashes;

CREATE OR REPLACE FUNCTION enrollment_clashes(_courseid varchar(7))
RETURNS integer
LANGUAGE PLPGSQL
AS $$
DECLARE
ret integer:=0;
_slot integer;
BEGIN
-- select slot into ret from time_table where time_table.courseid=_courseid;
for _slot in (select slot from time_table where time_table.courseid in (select "2019csb1084_e".courseid from "2019csb1084_e")) 
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
select enrollment_clashes('ma101');
-- select * from time_table;