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


-- 8. 