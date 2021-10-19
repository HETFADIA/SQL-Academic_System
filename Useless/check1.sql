CREATE OR REPLACE FUNCTION enrollment_clashes(_courseid varchar(7))
RETURNS integer
LANGUAGE PLPGSQL
AS $$
DECLARE
ret integer:=0;
_slot record;
BEGIN
-- select slot into ret from time_table where time_table.courseid=_courseid;
-- (select "2019csb1084_e".courseid from "2019csb1084_e")
-- execute format ('select %I.courseid from %I',current_user||'_e', current_user||'_e');
for _slot in (select slot from time_table where time_table.courseid in (select postgres_e.courseid from postgres_e))  
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



postgres=# CREATE OR REPLACE FUNCTION enrollment_clashes(_courseid varchar(7))
postgres-# RETURNS integer
postgres-# LANGUAGE PLPGSQL
postgres-# AS $$
postgres$# DECLARE
postgres$# ret integer:=0;
postgres$# _slot integer;
postgres$# BEGIN
postgres$# -- select slot into ret from time_table where time_table.courseid=_courseid;
postgres$# -- (select "2019csb1084_e".courseid from "2019csb1084_e")
postgres$# -- execute format ('select %I.courseid from %I',current_user||'_e', current_user||'_e');
postgres$# for _slot in (select slot from time_table where time_table.courseid in (select "2019csb1084_e".courseid from "2019csb1084_e")  )
postgres$# loop
postgres$#     if _slot in (select slot from time_table where time_table.courseid=_courseid)
postgres$#     then
postgres$#         raise exception 'this slot % clashes with other courses slots',_slot;
postgres$#         ret:=ret+1;
postgres$#     end if;
postgres$#
postgres$# end loop;
postgres$#
postgres$# return ret;
postgres$# END;
postgres$# $$;
CREATE FUNCTION
postgres=# select * from select enrollment_clashes('ma101');
ERROR:  syntax error at or near "select"
LINE 1: select * from select enrollment_clashes('ma101');
                      ^
postgres=# select enrollment_clashes('ma101');
ERROR:  this slot 10 clashes with other courses slots