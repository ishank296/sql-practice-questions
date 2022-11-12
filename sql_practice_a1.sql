CREATE TABLE data_mart.emp(
 emp_id int NULL,
 emp_name varchar(50) NULL,
 salary int NULL,
 manager_id int NULL,
 emp_age int NULL,
 dep_id int NULL,
 dep_name varchar(20) NULL,
 gender varchar(10) NULL
) ;

insert into data_mart.emp values(1,'Ankit',14300,4,39,100,'Analytics','Female')
,(2,'Mohit',14000,5,48,200,'IT','Male')
,(3,'Vikas',12100,4,37,100,'Analytics','Female')
,(4,'Rohit',7260,2,16,100,'Analytics','Female')
,(5,'Mudit',15000,6,55,200,'IT','Male')
,(6,'Agam',15600,2,14,200,'IT','Male')
,(7,'Sanjay',12000,2,13,200,'IT','Male')
,(8,'Ashish',7200,2,12,200,'IT','Male')
,(9,'Mukesh',7000,6,51,300,'HR','Male')
,(10,'Rakesh',8000,6,50,300,'HR','Male')
,(11,'Akhil',4000,1,31,500,'Ops','Male');

-- Write an SQL to find the employee details with 3rd highest salary in each department
-- in case if there is less than 3 employees in a department then return employeed details
-- with lowest salary in that department

-- approach 1
with emp_ranks as (
select emp_id,dep_id,dense_rank() over ( partition by dep_id order by salary desc) as rnk
from data_mart.emp),
emps_top_3 as 
(
select * from emp_ranks where rnk <= 3
),
emp_with_rownum as (
select *,row_number() over (partition by dep_id order by rnk desc) as rownum
from emps_top_3
)
select e.emp_id,e.emp_name,e.salary,e.dep_id,e.dep_name
from data_mart.emp e inner join 
emp_with_rownum r on e.emp_id =r.emp_id and rownum=1;


--approach 2
with rnk_cte as (
select *,
dense_rank() over (partition by dep_id order by salary desc) as rnk,
count(1) over (partition by dep_id) as dep_cnt
from data_mart.emp
)
select emp_id,
       emp_name,
       salary,
       dep_id,
       dep_name
from rnk_cte where rnk = 3 or (dep_cnt < 3 and dep_cnt = rnk);