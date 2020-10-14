/* Delete the tables if they already exist */
drop table if exists customer;
drop table if exists employee;
drop table if exists "order";
drop table if exists recommendation;
drop table if exists "section";
drop table if exists book;


/* Create the schema for our tables */
create table customer(firstname char(15), surname char(20),
                      Gender varchar(1) NOT NULL CHECK (Gender IN ('M', 'F')),
                      SSN integer not null check (SSN between 100000000 and 999999999) primary key,
                      age integer not null check (age between 1 and 99));

create table employee(firstname char(15), surname char(20),
                      Gender varchar(1) NOT NULL CHECK (Gender IN ('M', 'F')),
                      empID integer not null,
                      SSN integer not null check (SSN between 100000000 and 999999999) primary key,
                      age integer not null check (age between 1 and 99),
                      sectNumber varchar not null foreign key);

create table "order"(orderID integer not null primary key,
                     custSSN integer not null foreign key,
                     bookID integer not null foreign key,
                     ordertype varchar(20) not null check(ordertype in ('Rental', 'Purchase')),
                     price integer not null,
                     date date);

CREATE TABLE book(
                     book_id INTEGER NOT NULL,
                     author CHARACTER varying(50) COLLATE pg_catalog."default" NOT NULL,
                     YEAR INTEGER NOT NULL,
                     price numeric(6,2) NOT NULL,
                     title CHARACTER VARYING COLLATE pg_catalog."default" NOT NULL,
                     editor CHARACTER VARYING COLLATE pg_catalog."default" NOT NULL,
                     CONSTRAINT "Book_pkey" PRIMARY KEY (book_id),
                     sectNumber varchar not null foreign key);


CREATE TABLE "section"(
                          NAME CHARACTER VARYING COLLATE pg_catalog."default" NOT NULL,
                          empSSN int not null foreign key,
                          number INTEGER NOT NULL,
                          number_books INTEGER NOT NULL,
                          genre CHARACTER VARYING[] COLLATE pg_catalog."default",
                          CONSTRAINT section_pkey PRIMARY KEY (NAME, "number"));


CREATE TABLE recommendation (
                                Title CHARACTER VARYING,
                                Genre CHARACTER VARYING,
                                Author CHARACTER VARYING,
                                How_it_relates CHARACTER VARYING,
                                orderID int not null foreign key)
    );

create table interacts (custId int not null,
                        empId int not null
                            interaction varchar(100));

create table complains (custId int not null,
                        empId int not null
                            interaction varchar(100));


/* create table employee(firstname char(10), surname char(10), gender char(1), empId int, SSN int(9), Age int(2)); */

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

insert into "order" values (13213, 608416078, 13322, 'Rental', 20, '2020-08-12');
insert into "order" values (12302, 583103289, 43232, 'Purchase', 25, '2020-12-07');
insert into "order" values (12300, 642638810, 43324, 'Purchase', 88, '2020-02-22');
insert into "order" values (13011, 723712379, 55325, 'Rental', 12, '2020-04-19');
insert into "order" values (12312, 828932950, 32223, 'Purchase', 11, '2020-05-15');
insert into "order" values (12322, 123456789, 44334, 'Rental', 2, '2020-10-01');
insert into "order" values (12389, 912093192, 55825, 'Rental', 12, '2020-05-02');
insert into "order" values (12589, 475030039, 63452, 'Purchase', 4, '2020-01-22');
insert into "order" values (14053, 658018083, 76543, 'Rental', 20, '2020-11-09');
insert into "order" values (15012, 138123185, 65433, 'Purchase', 129, '2020-10-21');
insert into "order" values (11023, 254389013, 65403, 'Purchase', 40, '2020-09-23');
insert into "order" values (12430, 248030284, 60482, 'Rental', 20, '2020-01-12');

select * from "order";

-- Adding some examples
--optimise: section name -> integer (1,2,..), division: char: a,b,c... . easier instead of string to describe 'section x' as x is the variable
INSERT INTO book (book_id, author, YEAR, price, title, editor) values(13322, 'J.K Rowlink', 1999, 12.99, 'The white spirit', 'Jean C.', 'Section 3');
INSERT INTO book (book_id, author, YEAR, price, title, editor) values(43232, 'J.K Rowlink', 2001, 11.99, 'The Black spirit', 'Jean C.','Section 1');
INSERT INTO book (book_id, author, YEAR, price, title, editor) values(43324, 'Rollingstone', 1990, 9.99, 'There was a day', 'Pierre Cassis','Section 4');
INSERT INTO book (book_id, author, YEAR, price, title, editor) values(55325, 'Davinci', 1879, 19.99, 'my first artt', 'Oldtimers.inc','Section 2');
INSERT INTO book (book_id, author, YEAR, price, title, editor) values(32223, 'Google', 2019, 2.99, 'There was a time', 'trouxdbal','Section 6');
INSERT INTO book (book_id, author, YEAR, price, title, editor) values(44334, 'Alex lecrivain', 2020, 102.99, 'Mon temps est venu', 'Martens inc.','Section 9');
INSERT INTO book (book_id, author, YEAR, price, title, editor) values(55825, 'Jeje on the top', 2019, 19.99, 'sql is iwipizi', 'UMdistr.','Section 5');
INSERT INTO book (book_id, author, YEAR, price, title, editor) values(63452, 'Luigi a.', 1989, 12.99, 'Mario and I, a long love story', 'Antolini inc','Section 7');
INSERT INTO book (book_id, author, YEAR, price, title, editor) values(76543, 'Yeyetima', 2007, 12.99, ' The absoluut crise', 'Jean Michel Dupre','Section 8');
INSERT INTO book (book_id, author, YEAR, price, title, editor) values(65433, 'VivaLalgerie', 1989, 0.99, 'lalgerie a bruxelles, une nouvelle destination ', 'Jean C.','Section 10');
-- Having a book twice test:
INSERT INTO book (book_id, author, YEAR, price, title, editor) values(65403, 'VivaLalgerie', 1989, 0.99, 'lalgerie a bruxelles, une nouvelle destination ', 'Jean C.','Section 10');
INSERT INTO book (book_id, author, YEAR, price, title, editor) values(60482, 'Luigi a.', 1989, 12.99, 'Mario and I, a long love story', 'Antolini inc','Section 7');


--Table for section:

INSERT INTO "section" (NAME, number, number_books, genre) values('Section 1',512638792 ,1, 332, ARRAY['Fantasy']);
INSERT INTO "section" (NAME, number, number_books, genre) values('Section 2',754830123 ,2, 43, ARRAY['Comedy']);
INSERT INTO "section" (NAME, number, number_books, genre) values('Section 3',574130209 ,3, 643, ARRAY['Music']);
INSERT INTO "section" (NAME, number, number_books, genre) values('Section 4',654931001 ,4, 53, ARRAY['Films']);
INSERT INTO "section" (NAME, number, number_books, genre) values('Section 5',912380239 ,5, 5436, ARRAY['Science']);
INSERT INTO "section" (NAME, number, number_books, genre) values('Section 6',461398012 ,6, 643, ARRAY['History']);
INSERT INTO "section" (NAME, number, number_books, genre) values('Section 7',564731800, 7, 54, ARRAY['Tragedy']);
INSERT INTO "section" (NAME, number, number_books, genre) values('Section 8',123801238 ,8, 754, ARRAY['Action']);
INSERT INTO "section" (NAME, number, number_books, genre) values('Section 9',871028030, 9, 865, ARRAY['Thriller']);
INSERT INTO "section" (NAME, number, number_books, genre) values('Section 10',146371980,10, 76, ARRAY['Roman']);

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

