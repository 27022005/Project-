create database project;
use project;
create table employee(
		emp_no int4 not null primary key,
        emp_name varchar(10),
        job varchar (9),
        mgr varchar (4),
        Hiredate date,
        sal decimal(7,2),
        comm decimal(7,2),
        deptno int2);
        
select * from employee;
 insert into employee(emp_no, emp_name, job, mgr, Hiredate, sal, comm, deptno) 
				VALUES(7369, 'SMITH', 'CLERK', 7902, '1980-12-17', 800.00, NULL, 20),
						(7499, 'ALLEN', 'SALESMAN', 7698, '1981-02-20', 1600.00, 300.00, 30),
						(7521, 'WARD', 'SALESMAN', 7698, '1981-02-22', 1250.00, 500.00, 30),
						(7566, 'JONES', 'MANAGER', 7839, '1981-04-02', 2975.00, NULL, 20),
						(7654, 'MARTIN', 'SALESMAN', 7698, '1981-09-28', 1250.00, 1400.00, 30),
						(7698, 'BLAKE', 'MANAGER', 7839, '1981-05-01', 2850.00, NULL, 30),
						(7782, 'CLARK', 'MANAGER', 7839, '1981-06-09', 2450.00, NULL, 10),
						(7788, 'SCOTT', 'ANALYST', 7566, '1987-06-11', 3000.00, NULL, 20),
						(7839, 'KING', 'PRESIDENT', NULL, '1981-11-17', 5000.00, NULL, 10),
						(7844, 'TURNER', 'SALESMAN', 7698, '1981-08-09', 1500.00, 0.00, 30),
						(7876, 'ADAMS', 'CLERK', 7788, '1987-07-13', 1100.00, NULL, 20),
						(7900, 'JAMES', 'CLERK', 7698, '1981-03-12', 950.00, NULL, 30),
						(7902, 'FORD', 'ANALYST', 7566, '1981-03-12', 3000.00, NULL, 20),
						(7934, 'MILLER', 'CLERK', 7782, '1982-01-23', 1300.00, NULL, 10);       
        
create	table Dept(
	Deptno int2  not null primary key,
    Dname varchar(14),
    loc varchar(13));

insert into dept
		values(10,"Accounting","New york"),
				(20,"Research","dallas"),
                (30,"sales","chicago"),
                (40,"operations","boston");


create table  Student(
	R_No int not null primary key,
    s_name varchar(14),
    city varchar(20),
    state varchar(20));
    
create table emp_log(
		Emp_id int(5) not null primary key,
        log_date date,
        new_salary int(10),
        Action varchar(20));
        
# 1) Select unique job from EMP table.
select distinct job from employee;

# 2) List the details of the emps in asc order of the Dptnos and desc of Jobs?
select * from  employee
	order by deptno asc , job desc;
    
# 3) Display all the unique job groups in the descending order?
select distinct job from employee
	order by job desc;
   
 # 4)   List the emps who joined before 1981.
 select *from employee
	where Hiredate < "1981-01-01";
    
# 5) List the Empno, Ename, Sal, Daily sal of all emps in the asc order of Annsal.
select emp_no,emp_name,sal, (sal/30) as Daily_sal, (sal*12) as Annsalary
		from employee
	order by annsalary asc;
    
# 6) List the Empno, Ename, Sal, Exp of all emps working for Mgr 7369.
select  emp_no,emp_name,sal,timestampdiff(YEAR, Hiredate, CURDATE()) AS exp
	from employee
where mgr = 7369;

# 7) Display all the details of the emps who’s Comm. Is more than their Sal?
select * from employee
		where Comm > sal;
        
# 8) List the emps who are either ‘CLERK’ or ‘ANALYST’ in the Desc order.
select * from employee
where job in ("CLERK","ANALYST")
order by job desc;

# 9) List the emps Who Annual sal ranging from 22000 and 45000.
SELECT *, (Sal*12) AS AnnSal
FROM employee
WHERE (Sal*12) BETWEEN 22000 AND 45000;
    
# 10) List the Enames those are starting with ‘S’ and with five characters.
select * from employee
	where emp_name like 's____';
    
# 11) Lits the emps whose Empno not starting with digit78.
select * from employee 
		where (emp_no) not like '78%';
    
# 12) List all the Clerks of Deptno 20.
select * from employee
		where job = "Clerk" and Deptno = 20;
        
# 13) List the Emps who are senior to their own MGRS.
select * from employee as emp
join employee as mgr
on emp.mgr = mgr.emp_no
where emp.Hiredate < mgr.Hiredate;

# 14) List the Emps of Deptno 20 who’s Jobs are same as Deptno10.
select * from employee
		where deptno = 20
        and job in (select distinct job 
						from employee 
                        where deptno = 10);

# 15) List the Emps who’s Sal is same as FORD or SMITH in desc order of Sal.

select * from employee
			where sal in (select sal 
				from employee 
                where emp_name in  ("FORD", "SMITH"))
                order by sal desc;
                
# 16) List the emps whose jobs same as SMITH or ALLEN.
select * from employee
		where sal in (select sal
        from employee
        where emp_name in("smith","Allen"));
        
# 17) Any jobs of deptno 10 those that are not found in deptno 20.
select distinct job from employee
		where deptno = 10
        and job not  in (select distinct job from employee
        where deptno = 20);
        
# 18) Find the highest sal of EMP table.
select max(sal) from employee;
 
# 19) Find details of highest paid employee.
SELECT * FROM Employee
		WHERE (Sal + COALESCE(Comm,0)) = 
	(SELECT MAX(Sal + COALESCE(Comm,0)) FROM Employee);
    
# 20) Find the total sal given to the MGR
select sum(sal) as Total_salary 
from employee
where job = "MANAGER";

# 21) List the emps whose names contains ‘A’.
select * from employee
where emp_name like "%A%";

# 22) Find all the emps who earn the minimum Salary for each job wise in ascending order.
select * FROM Employee e
WHERE Sal = (
    SELECT MIN(Sal)
    FROM Employee 
    WHERE Job = e.Job)
ORDER BY Job ASC;

# 23) List the emps whose sal greater than Blake’s sal.
select * from employee
where sal> (select sal from employee
		where emp_name = "Blake");	
        
# 24) Create view v1 to select ename, job, dname, loc whose deptno are same.
create view v1 as 
select e.emp_name, e.job, d.Dname, d.loc
		from employee e
        join dept d
        on d.Deptno = e.Deptno;

select * from v1;	

# 25) Create a procedure with dno as input parameter to fetch ename and dname.
DELIMITER $$
create procedure get_data(
		in dno int)
begin
	select e.emp_name, d.Dname
    from employee e
    join dept d 
    on e.deptno = d.deptno
    where e.deptno = dno;
End$$
DELIMITER ;
call get_data(20);
    
# 26) Add column Pin with bigint data type in table student.
alter table Student
add pin bigint;
select*from student;

/*27) Modify the student table to change the sname length from 14 to 40.
Create trigger to insert data in emp_log table whenever any update of sal 
in EMP table. You can set action as ‘New Salary*/
alter table student
modify s_name varchar(40);	

delimiter $$
CREATE TRIGGER update_salary
AFTER UPDATE ON employee
FOR EACH ROW
BEGIN
    IF NEW.sal <> OLD.sal THEN
        INSERT INTO emp_log (Emp_id, log_date, new_salary, Action)
        VALUES (NEW.emp_no, NOW(), NEW.sal, 'New Salary');
    END IF;
END$$

DELIMITER ;

UPDATE employee SET sal = sal + 500 WHERE emp_no = 7369;
select * from employee;

