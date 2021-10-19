DO $$ 
DECLARE
a integer:=5;
BEGIN 
RAISE NOTICE '%', a;
END $$;


DO $$ 
DECLARE

BEGIN 
show data_directory;
END $$;



DO $$ 
DECLARE
a integer:=5;
BEGIN 
RAISE NOTICE '%', current_user;
END $$;



DO $$ 
DECLARE
a integer:=5;
BEGIN 
execute format ('select %I.courseid from %I', current_user||'_e',current_user||'_e');
END $$;



DO $$ 
DECLARE
BEGIN 
for i in 1..5 loop
    
    RAISE NOTICE '%', current_user;
end loop;
END $$;

DO $$ 
DECLARE
i record;
BEGIN 
for i in (select current_user) loop
    
    RAISE NOTICE '%', current_user;
end loop;
END $$;