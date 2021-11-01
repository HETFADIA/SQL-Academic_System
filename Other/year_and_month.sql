select extract(year from now());
select extract(month from now());



DO $$ 
DECLARE
year integer;
month integer;
BEGIN 
select extract(year from now()) into year;
select extract(month from now()) into month;
raise notice '%', year;
raise notice '%', month;


END $$;