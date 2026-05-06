create database employees_project;
use employees_project;

create table departments(dept_id int primary key,
						dept_name varchar(50) not null);
create table employees(emp_id int primary key,
					   emp_name varchar(50) not null,
					   dept_id int,
					   experience int,
					   foreign key (dept_id) references departments(dept_id))

create table salaries (
					   emp_id int ,
					   salary int,
					   foreign key (emp_id) references employees(emp_id));

create table performance(emp_id int,
						 rating int,
						 foreign key (emp_id) references employees(emp_id));

insert into departments values(1,'Sales'),
							  (2,'HR'),
							  (3,'IT'),
							  (4,'Finance'),
							  (5,'Marketing'),
							  (6,'Analysis');
							             --experience
insert into employees values(101,'Sai',3,4),
							(102,'Ravi',2,2),
							(103,'Srinu',4,1),
							(104,'Raju',5,4),
							(105,'Sneha',3,6),
							(106,'Ramya',4,5),
							(107,'Supriya',2,1),
							(108,'Vamsi',6,2),
							(109,'Raja Rao',5,4),
							(110,'urimila',6,4),
							(111,'Virat',2,3),
							(112,'Arjun',1,1),
						    (113,'Raja',6,1),
							(114,'Sujatha',4,2),
							(115,'Thulasi',3,3),
							(116,'Igris',2,2),
							(117,'Spider',5,2),
							(118,'kumar',5,2),
							(119,'kiran',4,3),
							(120,'Shekar',6,5);

INSERT INTO salaries VALUES
(101, 60000),
(102, 35000),
(103, 30000),
(104, 45000),
(105, 80000),
(106, 75000),
(107, 28000),
(108, 40000),
(109, 50000),
(110, 52000),
(111, 42000),
(112, 25000),
(113, 27000),
(114, 38000),
(115, 47000),
(116, 36000),
(117, 39000),
(118, 41000),
(119, 55000),
(120, 70000);

INSERT INTO performance VALUES
(101, 4),
(102, 3),
(103, 2),
(104, 4),
(105, 5),
(106, 5),
(107, 2),
(108, 3),
(109, 4),
(110, 4),
(111, 3),
(112, 2),
(113, 2),
(114, 3),
(115, 4),
(116, 3),
(117, 3),
(118, 3),
(119, 4),
(120, 5);

--try to find the how many employees are there in the departrment_wise so i haved used the joins concept and group by concept then it will given the data what we have to required.
select d.dept_name as departments,count(emp_id) as count_employees from departments d right join employees e on d.dept_id=e.dept_id group by dept_name;
--Average salary per department in these we can't simply add two tables we have to take refernces from two tables so i used the inner join for comparing two tables and returing the all values from that table
select avg(salary) as avg_salary ,d.dept_name as departments
			from departments d join employees e on e.dept_id = d.dept_id
			join salaries s on s.emp_id=e.emp_id
			group by d.dept_name;

--Highest salary in company
select e.emp_name as employees,s.salary as max_salary from employees e join salaries s on e.emp_id=s.emp_id where s.salary=(select max(salary) from salaries);

--Highest paid Employee per department
select max(salary) as max_salary,d.dept_name as departments from employees e join salaries s on e.emp_id=s.emp_id
join departments d on d.dept_id=e.dept_id group by d.dept_name;

--Eligibility for promotion
select e.emp_name as employee,p.rating as rating ,e.experience as employee_experience,
case 
	when p.rating>=4 ANd e.experience>=3 then 'Eligibility for promotion'
	else'The Employee Is Not Eligible For Promotion'
END As promotion
from employees e join performance p on e.emp_id=p.emp_id;

--Top 2 Employees per Department
select * from
(select e.emp_name as employee,e.dept_id,s.salary , rank()over (partition by e.dept_id order by s.salary desc) as rnk
from employees e join salaries s on e.emp_id=s.emp_id)sai
where rnk<=2

SELECT 
e.emp_id,
e.emp_name,
d.dept_name,
e.experience,
s.salary,
p.rating
FROM employees e
JOIN departments d ON e.dept_id = d.dept_id
JOIN salaries s ON e.emp_id = s.emp_id
JOIN performance p ON e.emp_id = p.emp_id;














