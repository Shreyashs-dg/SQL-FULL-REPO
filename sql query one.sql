--to create database use this command 
create database retail;

--to use created database use this command 
use retail;

--use this command to create table strcture 
--here student table is the parent key and next steps we need to insert in this pattren 
CREATE TABLE studenttable(SID int not null,
Sname varchar(20) not null,
Scity varchar(20) not null,
Scommession DECIMAL(4,2),
primary key(SID));

--to insert values into the table use this command 
INSERT INTO studenttable VALUES(101,'Shreyas HS','Bangalore',0.15);
INSERT INTO studenttable VALUES(102,'Shreyas NN','Bangalore',0.15);
INSERT INTO studenttable VALUES(103,'Shrikanth','Bangalore',0.15);
INSERT INTO studenttable VALUES(104,'Sidagond','Bangalore',0.15);
INSERT INTO studenttable VALUES(105,'Shravan','Bangalore',0.15);
INSERT INTO studenttable VALUES(106,'Sangamesh','Bangalore',0.15);
INSERT INTO studenttable VALUES(107,'Sanath','Bangalore',0.15);

--to display whole table use this command 
select * from studenttable;

--use this command to display specific column in this table like range
select * from studenttable where Scommession between 0.11 and 0.16 ;

--use this command to display specific column in this table
select SID,Sname from studenttable;

--use this command if you want to see data by applying some conditions 
select * from studenttable where SID<=103 and SID>=101;

--use this 
select * from studenttable where SID in (101,105,106,102);
select * from studenttable where Sname ='Shreyas HS';
select * from studenttable where Sname !='Shreyas HS';

--between clause 
select * from studenttable where Scommession between 0.15 and 0.20;
select * from studenttable where Scommession  not between 0.10 and 0.20;

--updating table info 
update studenttable
SET Scommession=0.11
where SID=101

update studenttable
SET Scommession=0.12
where SID=102

update studenttable
SET Scommession=0.13
where SID=103

update studenttable
SET Scommession=0.14
where SID=104

update studenttable
SET Scommession=0.16
where SID=106

update studenttable
SET Scommession=0.17
where SID=107


--use this command to see info of the table 
exec sp_help studenttable;


--use this command to delete specific row in the column /cluse 
DELETE FROM studenttable where SID=101;

--use this command to delete the data of the table 
truncate table studenttable ;

--use this command to delete the data + strcture of the table
drop table studenttable;

--Day -02
--customer table is the child table 
CREATE TABLE customer (
cnum INT NOT NULL,
cname VARCHAR(30) NOT NULL,
city VARCHAR(30) NOT NULL,
rating  decimal(4,2) not null,
SID int NOT NULL,
PRIMARY KEY (cnum),
FOREIGN KEY (SID) REFERENCES studenttable(SID)
);
INSERT INTO customer VALUES(1011,'SHREYAS HS CUSTOMER1','BANGALORE',4.9,101);
INSERT INTO customer VALUES(1012,'SHREYAS HS CUSTOMER2','Mandya',4.9,101);
INSERT INTO customer VALUES(1013,'SHREYAS HS CUSTOMER3','Davangere',4.9,101);
INSERT INTO customer VALUES(1021,'NN CUSTOMER3','Cng',4.9,102);
INSERT INTO customer VALUES(1022,'NN CUSTOMER3','Hrp',4.9,102);

SELECT * FROM customer ;

-- all about alter command 
--1) How to add new colum into table
ALTER table customer 
add pincode int ;

--2)add colum with default  values as india 
ALTER table customer
add country varchar(20) default 'india';

--3)change data type of colum
ALTER table customer 
ALTER COLUMN pincode varchar(20) ;



--17/12/2025
--candidate key

CREATE TABLE employee(EID int not null primary key, 
   emp_aadhar char(12),
   emp_pan char(10),
   firstname varchar(50) not null,
   lastname varchar(50) not null,
   gender char(1),
   constraint employees_ck1 unique (emp_aadhar),
   constraint employees_ck2 unique (emp_pan));
INSERT INTO employee values (101,'123456789101','ABCDE12345','SHREYAS ','HS','M');
INSERT INTO employee values (102,'123456789102','ABCDE12346','SHREYAS ','HS','M');
INSERT INTO employee values (103,'12345678910','ABCDE1234','SHREYAS ','HS','M');
select* from employee;

--count function 
--how to give header for count 
select count(cnum) as 'Count of customer : ' from customer;
select count(cnum) from customer;
select * from customer;

update customer 
set rating=4.5
where cnum=1021;
--group by command 
--find count of customer leaving in each city
select city as 'city name' ,count(city) as 'no of city' from customer group by city;
select rating as 'rating',count(rating) as 'no of ratings' from customer group by rating; 

select sid,count(sid) from customer group by sid;

--orderby ascending order
select * from studenttable order by sname asc;

--orderby descending  order
select * from studenttable order by Scommession desc;

--18/12/2025
--create  order table 
--use date type to store it yyyy-mm-dd
CREATE TABLE orders (onum int not null primary key,
amt decimal(7,2) not null,
odate date not null,
cnum int NOT NULL,
FOREIGN KEY (cnum) REFERENCES customer(cnum));

INSERT INTO orders VALUES(1011458,458.99,'2025-12-18',1011);
INSERT INTO orders VALUES(3001548,18.69,'2025-03-24',1012);
INSERT INTO orders VALUES (3003,767.19,'2025/03/15', 1013);
INSERT INTO orders VALUES (3002,1900.10,'2025/03/16',1021);
INSERT INTO orders VALUES (3005,5160.45,'2025/03/18',1022);
INSERT INTO orders VALUES (2026,125.66,'2025/12/25',1022);
INSERT INTO orders VALUES(3001547,18.69,'2025-03-24',1012);
INSERT INTO orders VALUES(1011454,48.99,'2025-12-18',1011);


select * from orders;
select * from customer;
exec sp_help orders;

--find total values of all the orders
select sum(amt) as 'Total sales ' from orders;

--find the values of all orders for c num 2022
select sum(amt) as 'Total amount of 1012' from orders
where cnum = 1011;

--find total value of each customer from heigher value to lower value min total amt is 1000
--these is aggregate data(dummy data orginal remains same) that's why we are using having insted of where

select cnum,sum(amt) as 'Total amt' from orders
group by cnum
having sum(amt)>=1500
order by sum(amt) desc ;
--order of task execution is 
--1)group by 
--2)sum
--3)having
--4)order by


--19/12/2025
--find the highest amount 
select max(amt) as 'Maximum amount is : ' from orders;

--find all heighest value of  order for each/per  customer
select cnum,max(amt) as 'max amount of each customer ' from orders 
group by cnum;
--can we aggregrate sum and max in a command 
--for each customer get the total sales and heighest order
select cnum,
sum(amt) as 'Total sales',
max(amt) as 'heighest order', 
min(amt) as 'Minum order ',
avg(amt) as 'average amt of the customer',
count(onum) as 'no of orders' 
from orders
group by cnum;

--string functions 
select * from customer;
--functions to check no of character
select cname,len(cname) from customer;
--functions to covert into upper case
select cname,upper(cname) from customer;
--functions to covert into lower case
select cname,lower(cname) from customer;
--substring 'function '
--substring(string which you want ,start,howmaney);
select substring('string',3,5) as 'sub string ';  
select substring('hello',1,2) as 'sub string '; 
--concat function 
select concat('Shreyas',' ',' HS');
select concat(cname,' from ',city) from customer;
select concat('Hello',' ','MR',' ',cname,' from ',city) from customer;
select * from customer;
select concat(' Mr ',' Shreyas ',' HS ');
select upper(concat('mr ',' Shreyas ',' HS '));

select * from customer;
--making first letter as capital 
select concat(upper(substring(cname,1,1)),substring(cname,2,100)) from customer;

--pattren searching 
--for pattern searching use like command 
--find all the name which  contain r 
select * from studenttable where sname like '%r%';
--find the name starting with S
select * from studenttable where sname like 'S%';

--find the name ending with S
select * from studenttable where sname like '%S' or  sname like '%N';
select * from studenttable;


