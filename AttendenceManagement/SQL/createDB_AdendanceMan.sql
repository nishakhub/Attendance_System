CREATE TABLE users (
user_id int(6) NOT NULL AUTO_INCREMENT, password varchar(100) NOT NULL, first_name varchar (100) NOT NULL, last_name varchar (100) NOT NULL, email_id varchar (100) NOT NULL, 
role int(1) NOT NULL, age int(2) NULL, sex varchar(1) NOT NULL, address varchar(400), dob DATE, designation varchar(200), updated_date DATE, created_date DATE, password_auto char(1),
PRIMARY KEY (user_id));

CREATE TABLE subject (subject_id int(3) NOT NULL AUTO_INCREMENT, subject_name varchar(100), class_id int(3), teacher_id int(5), created_date date, modified_date date, primary key (subject_id));

CREATE TABLE student (student_id int(5) NOT NULL, academic_year varchar (10), class_id int (2), user_id int(5), primary key (student_id));

--CREATE TABLE teacher (teacher_id int(5) NOT NULL, user_id int(5), user_id int(5) foreign key, primary key (student_id));

--CREATE TABLE staff (employee_id(int 5) NOT NULL AUTO_INCREMENT, joining_date date, designation varchar(200), user_id int(5) foreign key, primary key (student_id));

CREATE TABLE attendance (at_id int(10) NOT NULL AUTO_INCREMENT, present_date date, user_id int(5), subject_id int(3), from_time varchar(20), to_time varchar(20), added_date date, primary key (at_id));

CREATE TABLE holidays (id int(5) NOT NULL AUTO_INCREMENT, holiday_date date, discription varchar(1000), added_date date, primary key (id));

CREATE TABLE notifications (notification_id int(5) NOT NULL AUTO_INCREMENT, subject varchar(1000), content varchar(2000), notification_type char(1), user_id int(6), sent_date date, primary key (notification_id));

CREATE TABLE class (class_id int(2) NOT NULL AUTO_INCREMENT, name varchar(50), class_teacher int(5), updated_date date, primary key (class_id));

CREATE TABLE leaves (id int(5) NOT NULL AUTO_INCREMENT, user_id int(5), leave_from_date date, leave_to_date date, total int(3), description varchar(400),created_date date, primary key (id));

CREATE TABLE keyvalues (id int(3) NOT NULL AUTO_INCREMENT, prop_key varchar(100), prop_value varchar(100), primary key (id));

insert into users 
values (10000, 'komal123', 'Komal', 'Kambale', 'nzadage@gmail.com', 1, 26, 'M', 'Old Sangavi', STR_TO_DATE('05-05-1989', '%d-%m-%Y'), '', NOW(), NOW(), 'N');


insert into student values (10001, '', 1, 10001), (10002, '', 1, 10002), (10003, '', 1, 10003), (10004, '', 1, 10004);


insert into class values (1, 'FYIF', 10001, now()), (2, 'SYIF', 10002, now()), (3, 'TYIF', 10001, now());

insert into subject values (1, 'Maths', 1, 10000, now(), now()), 
(2, 'Database', 1, 10000, now(), now()), 
(3, 'C Language', 2, 10000, now(), now()),
(4, 'Java', 3, 10000, now(), now()),
(5, 'Advanced Java', 3, 10000, now(), now())
;

