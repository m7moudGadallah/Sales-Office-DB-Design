use master
go

-- create database
create database SalesOffice
on
(
	name= SalesOffice_data,
	filename= 'E:\Web Dev\backend\database\ITI\materials\my_solutions\DBS\sales_office\SalesOffice_data.mdf',
	size= 10,
	maxsize= 10,
	filegrowth= 5
)
log on
(
	name= SalesOffice_log,
	filename= 'E:\Web Dev\backend\database\ITI\materials\my_solutions\DBS\sales_office\SalesOffice_log.mdf',
	size= 5,
	maxsize= 25,
	filegrowth= 5
)
go

use SalesOffice
go

-- create Person table
create table Person
(
	id int identity,
	name varchar(20),
	role varchar(15),

	constraint person_pk primary key(id),
	constraint role_check check(role in ('employee', 'owner'))
)

-- create Employee table
create table Employee
(
	person_id int,
	office_num int,
	
	constraint employee_person_fk foreign key(person_id) references Person(id),
	constraint employee_pk primary key(person_id)
)

-- create Sales_office table
create table Sales_office
(
	num int identity,
	loc varchar(30),
	manager_id int,

	constraint Sales_office_pk primary key(num),
	constraint Sales_office_manager_fk foreign key(manager_id) references Employee(person_id),
)

-- add foreign key constraint of employee_sales_office_fk
alter table Employee
add constraint employee_sales_office_fk foreign key(office_num) references Sales_office (num)

-- create Zip_code_info table
create table Zip_code_info
(
	zip_code varchar(15),
	city varchar(15),
	state varchar(15),

	constraint Zip_code_info_pk primary key(zip_code)
)

-- create Property table
create table Property
(
	id int identity,
	address varchar(20),
	zip_code varchar(15),

	constraint property_pk primary key(id),
	constraint property_zip_code_info_fk foreign key(zip_code) references Zip_code_info(zip_code)
)


-- create Property_list table
create table Property_list
(
	property_id int,
	office_num int,

	constraint property_list_pk primary key(property_id),
	constraint property_list_property_fk foreign key(property_id) references Property(id),
	constraint property_list_sales_office_fk foreign key(office_num) references Sales_office(num)
)

-- create Has table
create table Has
(
	owner_id int,
	property_id int,
	owned_percent decimal(3, 2),

	constraint has_pk primary key(owner_id, property_id),
	constraint has_person_fk foreign key(owner_id) references Person(id),
	constraint has_peroperty_fk foreign key(property_id) references Property(id)
)
