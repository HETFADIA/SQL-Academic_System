CREATE TABLE course_batches(
    courseid integer not null,
    secid integer not null,
    sem integer not null,
    year integer not null,
    batch varchar(10) not null,
    primary key (secid,sem,year,batch)
);


