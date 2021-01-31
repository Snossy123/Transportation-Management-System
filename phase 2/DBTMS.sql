drop database if exists Transport ;

create database if not exists Transport char set utf8 collate utf8_general_ci ;

use Transport ;

/*-- -------------------------------------------------------------- --*/
/*Create table Customer */
create table Customer (
SSN number(10),
Mobile_no number(11),
fname varchar2(10),
lname varchar2(10),
Email varchar2(20),
Address varchar2(20),
constraint pk_customer primary key (SSN)
);

/*create table Employee */
create table Employee(
Emp_id number(10),
licence varchar2(9),
fname varchar2(10),
lname varchar2(10),
Email varchar2(20),
phone_num number(11),
Address varchar2(20),
hire_date date,
job_id number(10),
Emp_id_mgr number(10),
constraint pk_employee primary key (Emp_id),
constraint fk_mgr_emp foreign key (Emp_id_mgr)
references Employee (Emp_id)
);


/*Bus table */
create table Bus(
Bus_id number(10),
Type_bus varchar2(10),
Cost number(7,2),
Capacity number(3),
Com_Email varchar2(20),
Date_m date,
Cost_m number(7,2),
Spare_date date,
Model varchar2(10),
date_buy date,
Cost_buy number(7,2)
constraint pk_Bus primary key (Bus_id) 
);

/*Drive*/
create table Drive(
Bus_id number(10),
Emp_id number(10),
Start_Time time,
End_Time time,
constraint pk_Drive primary key (Bus_id,Emp_id),
constraint fk_Driv_Bus foreign key (Bus_id)
references  Bus(Bus_id)
constraint fk_Driv_Emp foreign key (Emp_id)
references  Employee(Emp_id)
);

/*Route*/
create table Route(
Route_id number(10),
Duration time,
/*cost of ticket route*/
Route_ticket number(7,2),
/*first station*/
pickUp_point number(3),
Route_point number(3),
constraint pk_Route primary key (Route_id),
);

/*travel through */
create table travel_through (
Route_id number(10),
Bus_id number(10),
constraint pk_travel_through primary key (Route_id,Bus_id),
constraint fk_Route_travel foreign key (Route_id)
references Route (Route_id),
constraint fk_Bus_travel foreign key (Bus_id)
references Bus (Bus_id),
);


/*station*/
create table station (
St_id number(10),
stname varchar2(10),
constraint pk_station primary key(St_id)
);

/*station on route*/
create table station_route(
St_id number(10),
Route_id number(10),
constraint pk_station_route primary key (St_id, Route_id),
constraint fk_St foreign key (St_id)
references station (St_id),
constraint fk_route foreign key (Route_id)
references Route (Route_id),
);

/*company*/
create table company (
Email varchar2(20),
cname varchar2(10),
coordinator_name varchar2(20),
constraint pk_company primary key(Email)
);


/* company phone number */
create table com_phone(
Email varchar2(20),
num number(11),
countrycode char(7),
constraint pk_com_phone(countrycode , num , Email),
constraint fk_Email_com foreign key (Email)
references company (Email)
);

/*Booking office*/  
create table Booking_office(
num number(7),
daily_income number(7,2),
Date_income date,
Address varchar2(20),
T_open time,
T_close time,
constraint pk_Booking_office primary key (num),
);


/*complaint*/
create table complaint (
SSN number(10),
Bus_id number(10),
Emp_id number(10),
Time_comp time,
date_comp date,
constraint pk_complaint primary key (SSN , Bus_id , Emp_id),
CONSTANT fk_cust_comp foreign key(SSN)
references Customer (SSN),
CONSTANT fk_Emp_comp foreign key(Emp_id)
references Employee (Emp_id),
CONSTANT fk_Bus_comp foreign key(Bus_id)
references Bus (Bus_id)
);

/*Dependents */
create table dependents(
dname varchar2(10),
Emp_id number(10),
Relationships varchar2(10),
bdate date,
sex char(7),
constraint pk_dependents primary key(dname , Emp_id),
CONSTANT fk_Emp_dep foreign key(Emp_id)
references Employee (Emp_id)
);


/*Request*/ 
create table Request(
num number(10),
SSN number(10),
Time_Req time ,
Date_Req date ,
Route_id number(10),
price number(7,2),
constraint pk_Request primary key(num , SSN),
CONSTANT fk_Booking_Req foreign key(num)
references Booking_office (num),
CONSTANT fk_cust_Req foreign key(SSN)
references Customer (SSN),
CONSTANT fk_Route_Req foreign key(Route_id)
references Route (Route_id)
);


/*Registration*/
create table Registration(
num number(10),
Bus_id number(10),
date_reg date ,
Time_reg time ,
constraint pk_Registration primary key(num , Bus_id),
CONSTANT fk_Booking_Reg foreign key(num)
references Booking_office (num),
CONSTANT fk_Bus_Reg foreign key(Bus_id)
references Bus (Bus_id)
);


/*add foreign key on table Bus*/
alter table Bus 
add constraint fk_Bus_com foreign key(Com_Email)
references company (Email);


/*add salary table */
create table salary(
Emp_id number(10),
sal number(7,2),
bouns number(7,2),
punish number(7,2),
total_salary number(7,2),
constraint pk_salary primary key(Emp_id),
constraint chk_salary check(total_salary between 3000 and 10000)
);

 