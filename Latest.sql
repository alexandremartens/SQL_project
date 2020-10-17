drop table if exists customer cascade ;
drop table if exists employee cascade ;
drop table if exists custOrder cascade ;
drop table if exists recommendation;
drop table if exists section cascade ;
drop table if exists book cascade ;
drop table if exists interacts;
drop table if exists complains;


/* Create the schema for our tables */
create table customer
(
    firstName   char(15),
    secondName     char(20),
    Gender      varchar(1) NOT NULL CHECK (Gender IN ('M', 'F')),
    custSSN         integer not null check (custSSN between 000000000 and 999999999) primary key,
    age         integer not null check (age between 1 and 99),
    unique (custSSN)
);

create table employee
(
    firstName  char(15),
    secondName    char(20),
    Gender     varchar(1)   NOT NULL CHECK (Gender IN ('M', 'F')),
    empID      integer      not null,
    empSSN        integer      not null check (empSSN between 000000000 and 999999999) primary key,
    age        integer      not null check (age between 1 and 99),
    sectionID varchar(255) not null
);

create table custOrder
(
    orderID     integer not null primary key,
    custSSN     integer not null,
    bookID      integer not null,
    ordertype   varchar(20) not null check(ordertype in ('Rental', 'Purchase')),
    price       integer not null,
    date date,
    unique(custSSN),
    unique (orderID)
);

CREATE TABLE book
(
    book_id    INTEGER                                            NOT NULL,
    author     CHARACTER varying(255)                             NOT NULL,
    YEAR       INTEGER                                            NOT NULL,
    price      numeric(6, 2)                                      NOT NULL,
    title      CHARACTER VARYING(255)                             NOT NULL,
    editor     CHARACTER VARYING(255)                             NOT NULL,
    CONSTRAINT "Book_pkey" PRIMARY KEY (book_id),
    sectionID varchar(255)                                       not null,
    unique (sectionID)
);

CREATE TABLE section
(
    sectionID CHARACTER VARYING (255) NOT NULL,
    number_books INTEGER NOT NULL,
    genre CHARACTER VARYING[] COLLATE pg_catalog."default",
    CONSTRAINT section_pkey PRIMARY KEY (sectionID),
    unique (sectionID)
);

CREATE TABLE recommendation
(
    Title CHARACTER VARYING(255),
    Genre CHARACTER VARYING(255),
    Author CHARACTER VARYING(255),
    How_it_relates CHARACTER VARYING(255),
    orderID int not null
);

create table interacts
(
    custSSN int not null,
    empId int not null,
    interaction varchar(100)
);

create table complains
(
    custSSN int not null,
    empId int not null,
    interaction varchar(100)
);

alter table employee add foreign key (sectionID) references book (sectionID);
alter table custOrder add foreign key (custSSN) references customer (custSSN);
alter table custOrder add foreign key (bookID) references book (book_id);
alter table book add foreign key (sectionID) references section (sectionID);
alter table recommendation add foreign key (orderID) references custOrder (orderID);


/* create table employee(firstsectionID char(10), sursectionID char(10), gender char(1), empId int, SSN int(9), Age int(2)); */

/* Populate the tables with our data */
insert into customer values ('Jerome', 'de Bruyn', 'M', 123456789, 19);
insert into customer values ('John', 'Doe', 'M', 828932950, 20);
insert into customer values ('Sarah', 'Farthy', 'F', 723712379, 23);
insert into customer values ('Jamie', 'Tovel', 'M', 642638810, 22);
insert into customer values ('Modie', 'Deran', 'M', 583103289, 26);
insert into customer values ('Sully', 'Liller', 'M', 608416078, 29);
insert into customer values ('Dushane', 'Hill', 'M', 658018083, 33);
insert into customer values ('Shelley', 'Bachman', 'F', 475030039, 29);
insert into customer values ('Jac', 'Bachman', 'F', 912093192, 23);
insert into customer values ('Stefan', 'Tovel', 'M', 138123185, 9);
insert into customer values ('Aaron', 'Tovel', 'M', 254389013, 19);
insert into customer values ('Lizzie', 'McArthy', 'F', 248030284, 45);
insert into customer values ('Evelin', 'Marcell', 'F', 219676356, 43);
insert into customer values ('Lapo', 'Elkann', 'M', 044446124, 23);
insert into customer values ('Clive', 'Ridge', 'M', 551451385, 39);
insert into customer values ('Donald', 'Romey', 'M', 624063642, 55);
insert into customer values ('Jade', 'Laurence', 'F', 351015365, 35);
insert into customer values ('Joe', 'Sleepy', 'M', 751016365, 5);
insert into customer values ('Riley', 'Reid', 'F', 821216385, 12);

--Table for section:
INSERT INTO section values('Section 1' , 332, ARRAY['Fantasy']);
INSERT INTO section  values('Section 2' , 43, ARRAY['Comedy']);
INSERT INTO section  values('Section 3' , 643, ARRAY['Music']);
INSERT INTO section  values('Section 4' , 53, ARRAY['Films']);
INSERT INTO section  values('Section 5' , 5436, ARRAY['Science']);
INSERT INTO section  values('Section 6' , 643, ARRAY['History']);
INSERT INTO section  values('Section 7',  54, ARRAY['Tragedy']);
INSERT INTO section  values('Section 8' , 754, ARRAY['Action']);
INSERT INTO section  values('Section 9',  865, ARRAY['Thriller']);
INSERT INTO section  values('Section 10', 76, ARRAY['Roman']);

-- Adding some examples
--optimise: section sectionID -> integer (1,2,..), division: char: a,b,c... . easier instead of string to describe 'section x' as x is the variable
INSERT INTO book values(13322, 'J.K Rowlink', 1999, 12.99, 'The white spirit', 'Jean C.', 'Section 3');
INSERT INTO book values(43232, 'J.K Rowlink', 2001, 11.99, 'The Black spirit', 'Jean C.','Section 1');
INSERT INTO book values(43324, 'Rollingstone', 1990, 9.99, 'There was a day', 'Pierre Cassis','Section 4');
INSERT INTO book values(55325, 'Davinci', 1879, 19.99, 'my first artt', 'Oldtimers.inc','Section 2');
INSERT INTO book values(32223, 'Google', 2019, 2.99, 'There was a time', 'trouxdbal','Section 6');
INSERT INTO book values(44334, 'Alex lecrivain', 2020, 102.99, 'Mon temps est venu', 'Martens inc.','Section 9');
INSERT INTO book values(55825, 'Jeje on the top', 2019, 19.99, 'sql is iwipizi', 'UMdistr.','Section 5');
INSERT INTO book values(63452, 'Luigi a.', 1989, 12.99, 'Mario and I, a long love story', 'Antolini inc','Section 7');
INSERT INTO book values(76543, 'Yeyetima', 2007, 12.99, ' The absoluut crise', 'Jean Michel Dupre','Section 8');
INSERT INTO book values(65433, 'VivaLalgerie', 1989, 0.99, 'lalgerie a bruxelles, une nouvelle destination ', 'Jean C.','Section 10');
-- Having a book twice test


--Idea, empid other fixed length than ssn tot avoid confusion
insert into employee values ('KSI', '', 'M', 1, 512638792, 45, 'Section 1');
insert into employee values ('Tom', 'Cruise', 'M', 2, 754830123, 70, 'Section 4');
insert into employee values ('John', 'Cena', 'M',3,  574130209, 18, 'Section 5');
insert into employee values ('Dwayne', 'Johnson', 'M', 4, 654931001, 43, 'Section 6');
insert into employee values ('Mia', 'Khalifa', 'F', 5, 912380239, 32, 'Section 8');
insert into employee values ('Amy', 'Schrumer', 'F', 6,  461398012, 44, 'Section 7');
insert into employee values ('Kevin', 'Hart', 'M', 7, 564731800, 31, 'Section 9');
insert into employee values ('Johnny', 'Sins', 'M', 8, 123801238, 49, 'Section 10');
insert into employee values ('Barack', 'Barack', 'M', 9, 871028030, 28, 'Section 3');
insert into employee values ('Joe', 'Biden', 'M', 10, 146371980, 36, 'Section 2');
insert into employee values ('Donald', 'Trump', 'M', 11, 458423171, 24, 'Section 10');
insert into employee values ('Elon', 'Musk', 'M', 12, 609127896, 37, 'Section 7');
insert into employee values ('Jeff', 'Bezos', 'M', 13, 423785787, 36, 'Section 5');
insert into employee values ('Christine', 'Lagarde', 'F', 14, 437910261, 23, 'Section 2');
insert into employee values ('Lana', 'Rhoades', 'F', 15, 262094875, 21, 'Section 1');


insert into custOrder values (13213, 608416078, 13322, 'Rental', 20, '2020-08-12');
insert into custOrder values (12302, 583103289, 43232, 'Purchase', 25, '2020-12-07');
insert into custOrder values (12300, 642638810, 43324, 'Purchase', 88, '2020-02-22');
insert into custOrder values (13011, 723712379, 55325, 'Rental', 12, '2020-04-19');
insert into custOrder values (12312, 828932950, 32223, 'Purchase', 11, '2020-05-15');
insert into custOrder values (12322, 123456789, 44334, 'Rental', 2, '2020-10-01');
insert into custOrder values (12389, 912093192, 55825, 'Rental', 12, '2020-05-02');
insert into custOrder values (12589, 475030039, 63452, 'Purchase', 4, '2020-01-22');
insert into custOrder values (14053, 658018083, 76543, 'Rental', 20, '2020-11-09');
insert into custOrder values (15012, 138123185, 65433, 'Purchase', 129, '2020-10-21');

--Table for recommendation:

INSERT INTO recommendation VALUES ('Dragon Prince', 'fantasy', 'Melanie Rawn', 'same genre',13213);
INSERT INTO recommendation VALUES ('The Bet', 'biography', 'Rachel Van Dyken', 'same length',12302);
INSERT INTO recommendation VALUES ('Diary of a Worm', 'thriller', 'Harry Bliss', 'same author',12300);
INSERT INTO recommendation VALUES ('SilverFin', 'thriller', 'Charlie Higson', 'same length',13011);
INSERT INTO recommendation VALUES ('Rainbow Valley', 'fantasy', 'Joe Montgomery', 'same genre',12312);
INSERT INTO recommendation VALUES ('Hold Still', 'fiction', ' Nina LaCour', 'same editor',12322);
INSERT INTO recommendation VALUES ('Blue Bloods', 'fantasy',  'Melissa de la Cruz', 'same genre',12389);
INSERT INTO recommendation VALUES ('The Colorado Kid', 'drama', 'Stephen King', 'same author',12589);
INSERT INTO recommendation VALUES ('The Rising', 'fantasy', 'Ron Powers', 'same length',14053);
INSERT INTO recommendation VALUES ('The Firm', 'fiction', ' John Grisham', 'same editor',15012);

select * from customer