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

--day 22/12/2025
--nvarchar
create table student(id int primary key,
name nvarchar(10) not null );

insert into student values(101,N'ರಮೇಶ್');
insert into student values(102,'SHREYAS');
insert into student values(103,'SHREYAS');
insert into student values(104,N'ರಮೇಶ್');

select * from student;

--day 23/12/2025
--mathematical functions 
--flore function  
select floor(25.66);
select floor(-25.66);

--ceiling function 
select ceiling(25.66);
select CEILING(-25.66);

--abs function  
select abs(-25);

--round function 
select avg(amt) from orders;
select round(avg(amt),1) from orders;
select round(100.844,2);

--convert function 
select convert(dec(10,2),round(avg(amt),2)) from orders;
--square function
select square(9);
--sqrt function 
select sqrt(9);
--power function 
select power(5,2);

--compound intrest 
select convert(dec(10,2),500000 * power( 1 + 7.00/100.00 , 0.5) - 500000);
-- ans 17204.02

select * from orders;
--month,year,day function in date 
select *,day(odate) as 'day',month(odate) as 'month',year(odate) as 'year' from orders;

select month(odate) as'month of 2025' ,sum(amt) as'total amount per month' from orders 
where year(odate)=2025
group by month(odate) ;

--find total amount of sales on 2025/12/18
select day(odate) as 'day 18 of 12 th month 2025' ,sum(amt) as'total amount per day of 18' from orders 
where year(odate)=2025 and month(odate)=12 and day(odate)=18
group by day(odate) ;

select * from orders ;



--24/12/2006
--find the total sales in every month
select datename(mm,odate) as 'month' ,
year(odate) as 'year' ,
sum(amt) as 'Total sales'
from orders
group by year(odate),datename(mm,odate),month(odate)
order by year(odate),month(odate) ;

-- this will show you name of the month 
select datename(mm,odate) from orders;

--print month date 
select *,datename(dw,odate) from orders
order by day(odate) ;


select *,datename(dw,odate),datepart(dw,odate) from orders
order by datepart(dw,odate);

--to take current date and time 
select  getdate();

-- i want only date 
select convert(date,getDate());

-- i want only time 
select convert(time,getDate());

--round of the amount with 2 digits 
select  convert(dec(10,2) ,round(avg(amt),2)) from orders;

--to find the difference between the dates
select *,datediff(dd,odate,convert(date,getdate())) as 'No of days difference ' from orders;

select datediff(dd,'2006-12-24',convert(date,getdate())) ;

--to take first five 
select top 5* ,datediff(dd,odate,convert(date,getdate())) from orders;
select (1000000*0.09*(datediff(dd,'2025-04-01',convert(date,getdate()))+1)/365.00 );




--26/12/2025

-- print customer wise total sales
select cnum,sum(amt) from orders 
group by cnum ;

-- joining tables 
--join syntax

select * from orders join customer
on 
orders.cnum = customer.cnum;

select orders.cnum , cname from orders join customer 
on orders.cnum=customer.cnum
group by orders.cnum,cname;

select  orders.cnum,
cname,sum(amt) as 'Total sales',
max(amt) as 'highest order '   
from   orders  join customer 
on 
orders.cnum = customer.cnum
group by orders.cnum,cname;

select * from customer ;
select * from studenttable;

select * from  customer join studenttable  
on customer.sid=studenttable.sid;


--print snum,sname and count no of customer

select studenttable.sid,sname,count(cnum) from customer right outer  join studenttable 
on customer.sid = studenttable.sid
group by studenttable.sid,sname;


--29/12/2025
--right outer joint
select * from customer   join orders
on customer.cnum= orders.cnum;
--right outer joint
select * from customer right outer join studenttable
on customer.sid= studenttable.sid;


--distinct clause
--distint : it will give all names without repeation 
select * from customer;
select distinct city,rating from customer;
--we can se in this output bangalore not repeating twice 
insert into customer values (1031,'Shravan S','Bangalore',4.5,103,'india');
insert into customer values (1032,'Shravan S','Bangalore',4.5,103,'india');



--create  stored procedure 
--syntax to made our own procedure 
create PROCEDURE display_customer
as
select * from customer;
go
--
create PROCEDURE display_customer_name_city
as
select cname,city from customer;
go
--
exec display_customer_name_city
exec display_customer

exec sp_help customer;

--using procedure if user intered city name all details has to come who are belongs to that city 
--NOTE : HERE WE ARE USING 'set nocount on ' -->> THIS will not show how maney rows are effecte like that message
CREATE PROCEDURE display_customer_city
@city varchar(30)
as 
set nocount on ;
select * from customer where city=@city;
go

exec display_customer_city mandya


--30/12/2025
--take maltiple inputs from the users
create procedure oders_insert
@onum int 
@amt decimal(10,12)
@odate date

cname 
as 
set nocount on;
insert into orders values(@onum,@amt,@odate,(select ));

select * from orders;
