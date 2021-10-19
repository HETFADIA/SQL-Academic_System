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