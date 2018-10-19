use Training_19Sep18_Pune
select * from Book_Master
select DB_NAME()
sp_help 
select @@VERSION
select GETDATE()

create table PRANIT_Employee (EMP_ID INT,FIRSTNAME VARCHAR(20), LASTNAME VARCHAR(20), EMAIL_ID VARCHAR(20), AGE INT, PRIMARY KEY(EMP_ID));

insert into PRANIT_Employee
values (8,'PRANIT','MODAK','empranit@gmail.com',22)
insert into PRANIT_Employee
values (9,'MUKUND','KUMAR','muku.kumar@gmail.com',23)
insert into PRANIT_Employee
values (10,'PRABHAT','RANJAN','pra.ranjan@gmail.com',23)
insert into PRANIT_Employee
values (11,'SUKALPA','DEY','suk.dey@gmail.com',23)
insert into PRANIT_Employee
values (12,'SIMI','DEY','simi.modak@gmail.com',22)
select * from PRANIT_Employee
select FIRSTNAME,LASTNAME from PRANIT_Employee
select  * from PRANIT_Employee where LASTNAME='MODAK'
select * from PRANIT_Employee where FIRSTNAME like 'PR%' and LASTNAME = 'MODAK'

sp_rename PRANIT_tblEmployee, PRANIT_Employee

alter table PRANIT_Employee
add Address varchar(50)

alter table PRANIT_Employee
add Gender varchar(10)

update PRANIT_Employee
set Gender='MALE' where EMP_ID=8

alter table PRANIT_Employee
add constraint EMP_ID unique(EMP_ID)

alter table PRANIT_Employee
alter column Gender varchar(5)

create table Pranit_Population
(
country varchar(100),
[state] varchar(100),
city varchar(50),
[population (in millions)] int
)

INSERT INTO Pranit_Population VALUES('India', 'Delhi','East Delhi',9 )
 
INSERT INTO Pranit_Population VALUES('India', 'Delhi','South Delhi',8 )
 
INSERT INTO Pranit_Population VALUES('India', 'Delhi','North Delhi',5.5)
 
INSERT INTO Pranit_Population VALUES('India', 'Delhi','West Delhi',7.5)
 
INSERT INTO Pranit_Population VALUES('India', 'Karnataka','Bangalore',9.5)
 
INSERT INTO Pranit_Population VALUES('India', 'Karnataka','Belur',2.5)
 
INSERT INTO Pranit_Population VALUES('India', 'Karnataka','Manipal',1.5)
 
INSERT INTO Pranit_Population VALUES('India', 'Maharastra','Mumbai',30)
 
INSERT INTO Pranit_Population VALUES('India', 'Maharastra','Pune',20)
 
INSERT INTO Pranit_Population VALUES('India', 'Maharastra','Nagpur',11 )
 
INSERT INTO Pranit_Population VALUES('India', 'Maharastra','Nashik',6.5)

select sum([population (in millions)]) as [Total population] from Pranit_Population

select max([population (in millions)]) as [Max population] from Pranit_Population

select min([population (in millions)]) as [Min population] from Pranit_Population

select count([population (in millions)]) as [no of population] from Pranit_Population

select avg([population (in millions)]) as [avg population] from Pranit_Population

select state,sum([population (in millions)]) as [Total population] from Pranit_Population group by state

select state,sum([population (in millions)]) as [Total population] from Pranit_Population group by state having sum([population (in millions)]) > 30

select state ,sum([population (in millions)]) as [Total population] from Pranit_Population group by state order by state

select * from Pranit_Population where city in ('pune','mumbai')

select city from Pranit_Population where [population (in millions)] = (select MIN([population (in millions)]) from Pranit_Population)

create table Customer_Pranit
(
CustID int Primary Key,
CustFName varchar(50),
CustLName varchar(50),
ORD_ID int)

create table Orders_Pranit
(
O_ID int Primary Key,
O_Name varchar(50))

INSERT INTO Customer_Pranit VALUES(1,'Pranit', 'Modak',11)
 
INSERT INTO Customer_Pranit VALUES(2,'Prabhat', 'Ranjan',12)
 
INSERT INTO Customer_Pranit VALUES(3,'Sukalpa', 'Dey',13)
 
INSERT INTO Customer_Pranit VALUES(4,'Simi', 'Debnath',14)
 
INSERT INTO Customer_Pranit VALUES(5,'Mukund', 'Kumar',15)

INSERT INTO Orders_Pranit VALUES(11,'Eggs')
 
INSERT INTO Orders_Pranit VALUES(22,'Prabhat')
 
INSERT INTO Orders_Pranit VALUES(23,'Sukalpa')
 
INSERT INTO Orders_Pranit VALUES(14,'Oranges')
 
INSERT INTO Orders_Pranit VALUES(25,'Mukund')

select * from Customer_Pranit
right join Orders_Pranit on Customer_Pranit.ORD_ID= Orders_Pranit.O_ID

alter function MySquare_Pranit(@v int)
returns int
begin
declare @result int;
set @result = @v *@v+5;
return @result;
end

select dbo.MySquare_Pranit(2)

create table Pranit_ID_tbl
(
studentid int IDENTITY(1,1) NOT NULL,
firstname nvarchar(50) not null,
lastname nvarchar(50) not null,
email nvarchar(100) null
)

insert into Pranit_ID_tbl
values ('PRANIT','MODAK','empranit@gmail.com')
insert into Pranit_ID_tbl
values ('MUKUND','KUMAR','muku.kumar@gmail.com')
insert into Pranit_ID_tbl
values ('PRABHAT','RANJAN','pra.ranjan@gmail.com')
insert into Pranit_ID_tbl
values ('SUKALPA','DEY','suk.dey@gmail.com')
insert into Pranit_ID_tbl
values ('SIMI','MODAK','simi.modak@gmail.com')

select * from Pranit_ID_tbl

create procedure Pranit_GetStudentName(@sID int, @email varchar(50))
as
begin
select firstname+' '+lastname+' '+email from Pranit_ID_tbl where studentid=@sID and email=@email
end

exec Pranit_GetStudentName 3,'empranit@gmail.com'

alter procedure Pranit_GetStudentName(@sID int, @o varchar(200) out)
as
begin
select @o = firstname+' '+lastname from Pranit_ID_tbl where studentid=@sID
end

declare @result1 varchar(200)

exec Pranit_GetStudentName 3,@result1 output

select @result1 as Name

alter procedure Pranit_moverow(@sID int)
as
begin
insert into PRANIT_Employee(EMP_ID,FIRSTNAME,LASTNAME,EMAIL_ID) select * from Pranit_ID_tbl where Pranit_ID_tbl.studentid=@sID
delete from Pranit_ID_tbl where Pranit_ID_tbl.studentid=@sID
end

exec Pranit_moverow 8

select * from Pranit_ID_tbl
select * from PRANIT_Employee

alter TRIGGER Pranit_trgInsteadOfDelete ON [dbo].[PRANIT_Employee] 
INSTEAD OF DELETE
AS
	declare @emp_id int;
	declare @emp_fname varchar(100);
	declare @emp_lname varchar(100);
	declare @emp_em varchar(100);

	BEGIN
	        select @emp_id=d.EMP_ID,@emp_fname=d.FIRSTNAME ,@emp_lname=d.LASTNAME,@emp_em=d.EMAIL_ID from deleted d;
			delete from PRANIT_Employee where EMP_ID=@emp_id;
			insert into Pranit_ID_tbl
			values(@emp_fname,@emp_lname,@emp_em)
			PRINT 'Record Deleted -- Instead Of Delete Trigger.'
	END

delete from PRANIT_Employee where PRANIT_Employee.EMP_ID=5


create table Pranit_Emp ( Emp_ID int primary key, Emp_Name varchar(50), Manager_ID int )

insert into Pranit_Emp 
select 1,'Mike',3
union all
select 2,'David',3
union all
select 3,'Roger',null
union all
select 4,'Marry',2
union all
select 5,'Joseph',2
union all
select 6,'Ben',2

select e1.Emp_Name,e2.Emp_Name from Pranit_Emp as e1 inner join Pranit_Emp as e2 on e1.Manager_ID=e2.Emp_ID

select e1.Emp_Name,e2.Emp_Name from Pranit_Emp as e1 full join Pranit_Emp as e2 on e1.Manager_ID=e2.Emp_ID

create table Pranit_dept
(
deptcode int primary key,
deptname varchar(50)
)



insert into Pranit_dept values(@deptcode,@deptname)

declare @errorcode int

set @errorcode=@@ERROR

if(@errorcode>0)
begin
print 'error'
print @errorcode
end
else
print 'added successfully'

declare @deptcode int
declare @deptname varchar(50)

set @deptcode=12
set @deptname='During Sales'

begin try
insert into Pranit_dept values(@deptcode,@deptname)
end try

begin catch
print 'An error occurred while inserting'
print error_number()
end catch
 create view [Pranit ka view] as
 select studentid,firstname,lastname from Pranit_ID_tbl where studentid>3 and studentid<7

 select * from [Pranit ka view]