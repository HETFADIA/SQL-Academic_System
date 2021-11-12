create table movie (
    m_id int not null,
    name varchar(10),
    year int not null,
    imdb real not null,
    pc_id int,
    FOREIGN KEY (pc_id) REFERENCES production_company(pc_id),
    primary key (m_id)
);
create table Actor (
    a_id int not null,
    name varchar(15),
    primary key (a_id)
);
create table casting (
    m_id int not null,
    a_id int not null,
    FOREIGN KEY (a_id) REFERENCES Actor(a_id),
    FOREIGN KEY (m_id) REFERENCES Movie(m_id),
    primary key (m_id,a_id)
);
create table production_company (
    pc_id int not null,
    name varchar(10),
    address varchar(30),
    primary key (pc_id)
);
-- Join Actor and Casting; Where m_id < 50; finally, the query outputs actor name and movie name
select Actor.name, Movie.name from Actor, Casting, Movie where Actor.a_id = Casting.a_id and Casting.m_id = Movie.m_id and Movie.m_id < 50;


-- Join Movie and Production Company; where year is between 1950 and 2000. Finally, the query outputs the movie name and production company.


