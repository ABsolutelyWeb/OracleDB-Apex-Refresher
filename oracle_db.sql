-- Querying Oracle Database from the Apex interface.


-- 1. Select all employees who have a manager id of 7566.

SELECT *
FROM emp
WHERE mgr = 7566;


-- 2. Show all of the types of jobs available.

SELECT DISTINCT job
FROM emp
ORDER BY job ASC;


-- 3. Reveal all department names and locations.

SELECT dname, loc
FROM dept
ORDER BY dname ASC;


-- 4. Reveal how many employees of each job type exist and the total sum of their salaries.

SELECT job, COUNT(*), SUM(sal) AS "Total Salary"
FROM emp
GROUP BY job
ORDER BY "Total Salary" DESC;


-- 5. Find the average salary for each job position.

SELECT job, ROUND(AVG(sal), 2) AS "Average Salary"
FROM emp
GROUP BY job
ORDER BY "Average Salary" DESC;


-- 6. Who is the president of this organization?

SELECT *
FROM emp
WHERE job = 'PRESIDENT';


-- 7. Find the details of the manager named "Blake."

SELECT *
FROM emp
WHERE ename = 'BLAKE' AND job = 'MANAGER';


-- 8. Find everyone who isn't a clerk and has a salary less than 3000.

SELECT *
FROM emp
WHERE sal < 3000 AND job != 'CLERK';


-- 9. Find everyone whose commission is greater than their salary.

SELECT *
FROM emp
WHERE comm > sal;


-- 10. Find all employees whose names start with "A."

SELECT *
FROM emp
WHERE ename LIKE 'A%';


-- 11. Find the top 5 highest earning employees.

SELECT *
FROM emp
ORDER BY sal DESC
FETCH FIRST 5 ROWS ONLY;


-- 12. Find the top 10% of all lowest earning employees based on salary.

SELECT *
FROM emp
ORDER BY sal ASC
FETCH FIRST 10 PERCENT ROWS ONLY;


-- 13. Find all employees who aren't managers and have a salary greater than 2500
--	   and work in dept 20.

SELECT *
FROM emp
WHERE job != 'MANAGER' AND sal > 2500 AND deptno = 20;


-- 14. 