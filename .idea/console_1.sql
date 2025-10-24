use scottnew;

select * from depts; -- 1

select ename, job, HIREDATE from emps where dept_id = 10; -- 2

select ename, job, SAL from emps; -- 3

SELECT * FROM emps WHERE dept_id <> 10; -- 4

select * from emps where COMM > SAL; -- 5

select * from emps where HIREDATE = '03.12.1981'; -- 6

select ename, Sal where SAL < 1250 AND SAL > 1600; -- 7

select * from emps where JOB <> 'MANAGER' OR JOB <> 'President'; -- 8

select * from emps where ENAME LIKE '__A%'; -- 9

select ID, ENAME, JOB from emps where COMM IS NOT NULL AND COMM <> 0; -- 10

SELECT ID, ENAME, JOB, COMM FROM emps WHERE COMM IS NOT NULL ORDER BY COMM DESC; -- 11

SELECT ID, ENAME, JOB, dept_id, HIREDATE FROM emps WHERE JOB NOT IN ('Manager', 'President') ORDER BY dept_id ASC, hiredate DESC; -- 12

SELECT ENAME FROM emps WHERE LENGTH(ENAME) > 6; -- 13

SELECT CONCAT(ENAME, ' - ', JOB) AS Mitarbeiter_Info FROM emps WHERE dept_id = 30; -- 14

-- NVL behandelt COMM also die Provision, wenn sie null ist als 0. | SELECT SAL+COMM from emps AND SELECT SAL+NVL(COMM,0) from emps; -- 15

select ename, SAL as Monthly, SAL/22 as Daily, SAL/176 as Hourly from emps; -- 16

SELECT SUM(SAL + IFNULL(COMM, 0)) AS Monats_Gesamtbetrag FROM emps; -- 17

select AVG(SAL + IFNULL(Comm, 250)) from emps; -- 18

-- Erster Zettel fertig 😎😎😎

select COUNT(*) as Gesamt, COUNT(SAL) as MitGehalt, COUNT(COMM IS NOT NULL AND COMM<>0) as MitProvision from emps where dept_id=30; -- 19

select COUNT(DISTINCT JOB) as AnzahlBerufe from emps; -- 20

-- Weil COUNT alles zusammenzählt und die Werte als INT auswertet und ohne COUNT als STRING behandelt. -- 21

SELECT
    SUM(SAL)              AS Summe_SAL,
    COUNT(SAL)            AS Anzahl_SAL,
    AVG(SAL)              AS Durchschnitt_SAL,
    SUM(IFNULL(COMM,0))   AS Summe_COMM,
    COUNT(COMM)           AS Anzahl_COMM,
    AVG(IFNULL(COMM,0))   AS Durchschnitt_COMM
FROM emps
WHERE dept_id = 30; -- 22

select COUNT(DISTINCT JOB) from emps where JOB <> 'President' AND JOB <> 'MANAGER'; -- 23

select count(*)/count(distinct dept_id) from emps; -- 24

select * from emps where JOB = 'Manager' OR JOB = 'President'; -- 25

select ename, job, comm from emps where IFNULL(COMM,0) > SAL * 0.25; -- 26

SELECT MIN(SAL + IFNULL(COMM,0)) AS Geringstes_Gehalt FROM emps; -- 27

select MIN(HIREDATE) from emps; -- 28

select dept_id, JOB, count(*) as AnzahlPersonen from emps Group by dept_id, JOB Order by dept_id, JOB; -- 29

select dept_id, Max(SAL + IFNULL(Comm,0)) as MaxEinkommen from emps group by dept_id;
SELECT MIN(MaxEinkommen) AS geringstesHöchsteinkommen FROM (SELECT dept_id, MAX(SAL + IFNULL(COMM,0)) AS MaxEinkommen FROM emps GROUP BY dept_id) AS t; -- 30

-- = 0 prüft, ob wirklich eine Null (0) drinsteht.
-- IS NULL prüft, ob gar kein Wert eingetragen wurde. -- 31

-- COUNT(*) = alle Zeilen, COUNT(MGR) = nur nicht-NULL, COUNT(DISTINCT MGR) = verschiedene Chefs (ohne NULL). -- 32

-- COUNT() → Anzahl SUM() → Summe AVG() → Durchschnitt MIN() → Minimum MAX() → Maximum -- 33

select MIN(SAL + IFNULL(COMM, 0)), MAX(SAL + IFNULL(COMM, 0)), AVG(SAL + IFNULL(COMM, 0)), COUNT(SAL + IFNULL(COMM, 0)) from emps where dept_id = 30; -- 34

select MIN(SAL), MAX(SAL), AVG(SAL) from emps group by dept_id; -- 35

-- Zweiter Zettel fertig 😎😎😎

select min(SAL), max(Sal), AVG(sal) from emps where JOB<>'MANAGER' OR JOB <> 'PRESIDENT' group by dept_id; -- 36

select AVG(SAL) from emps where COMM <> 0 OR COMM <> NULL group by JOB; -- 37

select SUM(SAL +  IFNULL(COMM, 100))*14 from emps group by JOB; -- 38

-- In SQL werden geschachtelte Funktionen bei GROUP BY von innen nach außen über Subqueries ausgewertet. -- 39

select JOB, SAL from emps where SAL > 1500 group by dept_id ORDER BY AVG(SAL); -- 40

select deptno from emps where JOB <> 'CLERK' group by deptno; -- 41

-- WHERE filtert Zeilen vor der Gruppierung, HAVING filtert Gruppen nach der Aggregation. -- 42

select Job, AVG(SAL) as AverageSalary from emps group by job having AVG(SAL) > 1500 order by Job; -- 43

-- Where filtert vor der Gruppierung (auf Zeilenebene)
-- Having filtert nach der Gruppierung (auf Aggregat-Ebene) -- 44

-- Where ist effizienter, weil unnötige Daten vor der Gruppierung ausgeschlossen werden
-- Having wird meist für Bedinungen auf Aggregatfunktionen verwendet. -- 45

select ename, sal from emps where SAL > (Select SAL from emps where ename = 'JONES'); -- 46

select e.EName as Employee, e.SAL as EMP_SALARY, m.Ename as Manager, m.SAL as ManagerSalary from emps e join emps m on e.ID = M.ID where e.SAL > m.SAL; -- 47

select ename, sal from emps where SAL < 0.3 * (SELECT SAL from emps where JOB = 'PRESIDENT'); -- 48

select d.deptno, d.dname from depts d left join emps e on D.deptno = e.dept_id where e.ID IS NULL; -- 49

select ename, job from emps where JOB = (SELECT JOB FROM emps WHERE ENAME= 'JONES'); -- 50

select ename, job, sal from emps where SAL = (SELECT MAX(SAL) from emps); -- 51

select ename from emps order by LENGHT(ename) DESC LIMIT 1; -- 52

select count(*) from emps e join depts d ON e.dept_id = d.deptno where d.LOC = 'NEW YORK'; -- 53

select e.ename, e.job from emps e join depts d on e.dept_id = d.deptno where d.LOC = 'NEW YORK'; -- 54

select e.ename, e.job from emps e join depts d on e.dept_id = d.deptno where d.LOC ='CHICAGO' and e.JOB = (SELECT JOB from emps where ename = 'ALLEN') order by e.ename; -- 55

select job, avg(SAL) as AVGSAL from emps group by JOB HAVING AVG(SAL) > (SELECT AVG(SAL) from emps where JOB = 'SALESMAN'); -- 56

select ename, job from emps where dept_id = 10 and JOB IN(SELECT DISTINCT JOB from emps where dept_id = 30); -- 57

-- Dritter Zettel fertig 😎😎😎

select ename, job from emps where dept_id = 10 and JOB NOT IN (SELECT DISTINCT JOB FROM EMPS where dept_id = 30); -- 58

select ename, job from emps where JOB IN (SELECT DISTINCT JOB from emps where dept_id = (SELECT DEPT_id from depts where dname = 'SALES')); -- 59

select e1.dept_id, e1.ename, e1.hiredate from emps e1 where e1.hiredate = (select max(e2.hiredate) from emps e2 where e1.dept_id = e2.dept_id) order by e1.dept_id; -- 60

select distinct d.deptno, d.dname from depts d join emps e on d.deptno = e.dept_id; -- 61

SELECT e.dept_id, e.ename, e.sal FROM emps e JOIN (SELECT dept_id, AVG(sal) AS avg_sal FROM emps GROUP BY dept_id) avg_table ON e.dept_id = avg_table.dept_id WHERE e.sal > avg_table.avg_sal; -- 62

SELECT d.dname, d.loc, COUNT(e.id) AS mitarbeiter FROM depts d JOIN emps e ON d.deptno = e.dept_id GROUP BY d.dname, d.loc HAVING COUNT(e.id) > 4; -- 63

select e.ename, e.sal, e.dept_id from emps e where abs(e.sal - (select avg(sal) from emps where dept_id = e.dept_id)) > 0.1 * (SELECT avg(sal) from emps where dept_id = e.dept_id); -- 64

select e.ename, e.job, d.dname, d.LOC from emps e join depts d on e.dept_id = d.deptno where d.LOC = 'Chicago'; -- 65

select e.job, e.dept_id, e.sal, e.ename from emps e where (e.job, e.sal) in (select job, max(sal) from emps group by job); -- 66

select e.ename, e.job, e.sal from emps e where e.sal > 1.1 * (select avg(sal) from emps where job = e.job); -- 67

select e1.ename as Person, e1.sal as Gehalt, e2.ename as VergleichPerson, e2.sal as Vergleichsgehalt, (e2.sal - e1.sal) / e1.sal * 100 as UnterschiedProzent from emps e1 join emps e2 on e2.sal >= 1.5 * e1.sal; -- 68

create view emp10 as select * from emps where dept_id = 10;
create view emp20 as select * from emps where dept_id = 20;
create view emp30 as select * from emps where dept_id = 30;

create view fil20 as select ename, ID, job from emps where dept_id = 20;
select * from fil20 where job = 'Clerk'; -- 70

create view Gehalt_Filiale as select dept_id, max(SAL) as maxgehalt, min(sal) as mingehalt, avg(sal) as avggehalt from emps group by dept_id; -- 71

create view VergleichGehalt as select e.ename, e.job, e.sal, e.dept_id, g.avggehalt, round(((e.sal - g.avggehalt)/h.avggehalt) * 100, 2) as AbweichungProzent from emps e join Gehalt_Filiale g on e.dept_id = g.dept_id order by AbweichungProzent; -- 72

create view Zahlung as select e.id, e.job, e.ename, e.sal, (e.sal * 12 + IFNULL(e.comm, 0)) as Jahreseinkommen, d.dname, d.LOC from emps e join depts d on e.dept_id = d.deptno; -- 73

select dname, sum(Jahreseinkommen) as Gesamtzahlung from Zahlung group by dname; -- 74

-- Letzter Zettl fertig 😎😎😎
-- Alle Übungen korrekt 😎😎😎
