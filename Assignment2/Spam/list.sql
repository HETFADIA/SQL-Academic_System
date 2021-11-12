create table casting (
    m_id int not null,
    a_id int not null,
    FOREIGN KEY (a_id) REFERENCES Actor(a_id),
    FOREIGN KEY (m_id) REFERENCES Movie(m_id),
    primary key (m_id,a_id)
);


