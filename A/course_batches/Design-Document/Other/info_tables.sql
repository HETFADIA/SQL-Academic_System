student_info( studentid varchar(12) primary key, _name varchar(50), dept_name varchar(20) );


ba_info( batchadvisorid varchar(8), teacherid integer, primary key(batchadvisorid) );

instructor_info( teacherid integer, _name varchar(50) not null, dept_name varchar(20) not null, courseid varchar(7), secid integer, primary key(courseid, secid) );