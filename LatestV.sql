/* Delete the tables if they already exist */
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
    firstName   char(20),
    secondName     char(20),
    Gender      varchar(1) not null CHECK (Gender IN ('M', 'F')),
    custSSN         integer not null check (custSSN between 000000000 and 999999999) primary key,
    age         integer not null check (age between 1 and 99),
    unique (custSSN)
);

create table employee
(
    firstName  char(20),
    secondName    char(20),
    Gender     varchar(1)   not null CHECK (Gender IN ('M', 'F')),
    empID      integer      not null,
    empSSN        integer      not null check (empSSN between 000000000 and 999999999) primary key,
    age        integer      not null check (age between 1 and 99),
    sectionID varchar(255) not null,
    unique (empSSN)
);

create table custOrder
(
    orderID     integer not null primary key,
    custSSN     integer not null,
    bookID      integer not null,
    ordertype   varchar(20) not null check(ordertype in ('Rental', 'Purchase')),
    price       integer not null,
    date date,
    unique (orderID)
);

CREATE TABLE book
(
    book_id    integer                                            not null primary key ,
    author     varchar                             not null,
    YEAR       integer                                            not null,
    price      numeric(6, 2)                                      not null,
    title      varchar                             not null,
    editor     varchar                             not null,
    sectionID varchar(255)                                       not null,
    unique (book_id)
);

CREATE TABLE section
(
    sectionID character varying (255) not null primary key,
    number_books integer not null,
    genre character varying[],
    unique (sectionID)
);

CREATE TABLE recommendation
(
    Title varchar,
    Genre varchar,
    Author varchar,
    How_it_relates varchar,
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

alter table employee add foreign key (sectionID) references section (sectionID);
alter table custOrder add foreign key (custSSN) references customer (custSSN);
alter table custOrder add foreign key (bookID) references book (book_id);
alter table book add foreign key (sectionID) references section (sectionID);
alter table recommendation add foreign key (orderID) references custOrder (orderID);

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
insert into customer values ('Patric', 'Mahomes', 'M', 247060284,45);
insert into customer values ('Spongebob', 'Squarepants', 'M',485031039, 8);
insert into customer values ('Squidward', 'Houseparty', 'F', 758019083, 7);
insert into customer values ('Morty', 'Rick&Morty', 'M', 133423185, 11);
insert into customer values ('Sloppy', 'Joe', 'F', 345389013, 10);
insert into customer values ('Dora', 'The explorer', 'F', 333030284, 7);

insert into section values('Section 1' , 332, array['Fantasy']);
insert into section  values('Section 2' , 43, array['Comedy']);
insert into section  values('Section 3' , 643, array['Music']);
insert into section  values('Section 4' , 53, array['Films']);
insert into section  values('Section 5' , 5436, array['Science']);
insert into section  values('Section 6' , 643, array['History']);
insert into section  values('Section 7',  54, array['Tragedy']);
insert into section  values('Section 8' , 754, array['Action']);
insert into section  values('Section 9',  865, array['Thriller']);
insert into section  values('Section 10', 76, array['Roman']);
insert into section  values('Section 11', 345, array['Travel']);
insert into section  values('Section 12', 500, array['Biography']);

insert into book values(13322, 'J.K Rowlink', 1999, 12.99, 'The white spirit', 'Jean C.', 'Section 3');
insert into book values(43232, 'J.K Rowlink', 2001, 11.99, 'The Black spirit', 'Jean C.','Section 1');
insert into book values(43324, 'Rollingstone', 1990, 9.99, 'There was a day', 'Pierre Cassis','Section 4');
insert into book values(55325, 'Davinci', 1879, 19.99, 'my first artt', 'Oldtimers.inc','Section 2');
insert into book values(32223, 'Google', 2019, 2.99, 'There was a time', 'trouxdbal','Section 6');
insert into book values(44334, 'Alex lecrivain', 2020, 102.99, 'Mon temps est venu', 'Martens inc.','Section 9');
insert into book values(55825, 'Jeje on the top', 2019, 19.99, 'sql is iwipizi', 'UMdistr.','Section 5');
insert into book values(63452, 'Luigi a.', 1989, 12.99, 'Mario and I, a long love story', 'Antolini inc','Section 7');
insert into book values(76543, 'Yeyetima', 2007, 12.99, ' The absoluut crise', 'Jean Michel Dupre','Section 8');
insert into book values(65433, 'VivaLalgerie', 1989, 0.99, 'lalgerie a bruxelles, une nouvelle destination ', 'Jean C.','Section 10');
insert into book values(36443, 'Dan Brown', 1995, 15.99, ' The da Vinci Code', 'Transworld','Section 8');
insert into book values(28553, 'Grisham John,', 2008, 20.99, 'The Help', 'Random House','Section 3');
insert into book values(15343, 'Victoria Golden', 2002, 5.99, 'About a boy ', 'Bloomsbury','Section 8');

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
insert into custOrder values (13521, 912093192, 55825, 'Purchase', 20, '2020-12-22');
insert into custOrder values (17422, 247060284, 65433, 'Purchase', 15, '2019-01-11');
insert into custOrder values (12556, 485031039, 65433, 'Rental', 5, '2019-02-27');
insert into custOrder values (16034, 758019083, 28553, 'Rental', 6, '2020-07-07');
insert into custOrder values (17088, 133423185, 65433, 'Purchase', 40, '2020-10-13');
insert into custOrder values (18020, 345389013, 28553, 'Purchase', 35, '2020-05-22');
insert into custOrder values (19403, 333030284, 65433, 'Purchase', 22, '2020-03-15');

insert into recommendation values ('Dragon Prince', 'fantasy', 'Melanie Rawn', 'same genre',13213);
insert into recommendation values ('The Bet', 'biography', 'Rachel Van Dyken', 'same length',12302);
insert into recommendation values ('Diary of a Worm', 'thriller', 'Harry Bliss', 'same author',12300);
insert into recommendation values ('SilverFin', 'thriller', 'Charlie Higson', 'same length',13011);
insert into recommendation values ('Rainbow Valley', 'fantasy', 'Joe Montgomery', 'same genre',12312);
insert into recommendation values ('Hold Still', 'fiction', ' Nina LaCour', 'same editor',12322);
insert into recommendation values ('Blue Bloods', 'fantasy',  'Melissa de la Cruz', 'same genre',12389);
insert into recommendation values ('The Colorado Kid', 'drama', 'Stephen King', 'same author',12589);
insert into recommendation values ('The Rising', 'fantasy', 'Ron Powers', 'same length',14053);
insert into recommendation values ('The Firm', 'fiction', ' John Grisham', 'same editor',15012);
insert into recommendation values ('The Colorado Kid', 'drama', 'Stephen King', 'same author',12589);
insert into recommendation values ('The Rising', 'fantasy', 'Ron Powers', 'same length',14053);
insert into recommendation values ('The Firm', 'fiction', ' John Grisham', 'same editor',15012);
insert into recommendation values ('The Broker', 'travel', ' Gillian McKeith', 'same genre',19403);
insert into recommendation values ('Mill Town', 'biography', 'Kerri Arsenault', 'same genre',17422);
insert into recommendation values ('Clutter', 'fiction', ' Jennifer Howard', 'same editor',12556);
insert into recommendation values ('Carry', 'travel', ' Fer Jensen', 'same genre', 16034);

insert into interacts values (608416078, 1);
insert into interacts values (642638810, 2);
insert into interacts values (723712379, 3);

select (firstName, sectionID) from employee join interacts on employee.empID=interacts.empId;

select * from customer;

