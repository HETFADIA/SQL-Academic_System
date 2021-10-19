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


create table "2928_h"(
    nice integer
);
insert into "2928_h" values(10);
select * from "2928_h";