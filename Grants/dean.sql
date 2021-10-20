create user dean with PASSWORD '123';

-- GRANT ALL ON course_batches TO dean;
-- GRANT ALL ON course_catalog TO dean;
-- GRANT ALL ON pre_requisite TO dean;
-- GRANT ALL ON course_offerings TO dean;
-- GRANT ALL ON time_table TO dean;

-- REVOKE ALL ON ALL TABLES IN SCHEMA public FROM dean;
GRANT SELECT, UPDATE, INSERT, DELETE ON ALL TABLES IN SCHEMA public TO dean;
ALTER DEFAULT PRIVILEGES IN SCHEMA PUBLIC GRANT SELECT, INSERT, UPDATE, DELETE ON TABLES TO dean;
