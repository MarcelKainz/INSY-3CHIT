use scottnew;

select * from depts; -- 1

select ename, job, HIREDATE from emps where dept_id = 10; -- 2

select ename, job, SAL from emps; -- 3

SELECT * FROM emps WHERE dept_id != 10; -- 4

select * from emps where COMM > SAL; -- 5

select * from emps where HIREDATE = '03.12.1981'; -- 6

select ename, Sal where SAL < 1250 AND SAL > 1600; -- 7

select * from emps where JOB != MANAGER OR JOB != President; -- 8

select * from emps where ENAME LIKE '__A%'; -- 9

select ID, ENAME, JOB from emps where COMM IS NOT NULL AND COMM != 0; -- 10

SELECT ID, ENAME, JOB, COMM FROM emps WHERE COMM IS NOT NULL ORDER BY COMM DESC; -- 11

SELECT ID, ENAME, JOB, dept_id, HIREDATE FROM emps WHERE JOB NOT IN ('Manager', 'President') ORDER BY dept_id ASC, hire_date DESC; -- 12

SELECT ENAME FROM emps WHERE LENGTH(ENAME) > 6; -- 13

SELECT CONCAT(ENAME, ' - ', JOB) AS Mitarbeiter_Info FROM emps WHERE dept_id = 30; -- 14

-- NVL behandelt COMM also die Provision, wenn sie null ist als 0. | SELECT SAL+COMM from emps && SELECT SAL+NVL(COMM,0) from emps; -- 15

select ename, SAL as Monthly, SAL/22 as Daily, SAL/176 as Hourly from emps; -- 16

SELECT SUM(SAL + IFNULL(COMM, 0)) AS Monats_Gesamtbetrag FROM emps; -- 17

select AVG(SAL + IFNULL(Comm, 250)) from emps; -- 18

-- Erster Zettel fertig 😎😎😎

select COUNT(*) as Gesamt, COUNT(SAL) as MitGehalt, COUNT(COMM IS NOT NULL AND COMM<>0) as MitProvision from emps where dept_id=30 -- 19