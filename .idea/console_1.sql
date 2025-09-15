use scottnew;

select * from depts; -- 1

select ename, job, HIREDATE from emps where dept_id = 10; -- 2

select ename, job, SAL from emps;

SELECT * FROM emps WHERE dept_id != 10;

select * from emps where COMM > SAL;