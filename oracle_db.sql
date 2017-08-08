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


-- 14. Find the names of all employees who are not managers nor salesmen and have
--     a salary greater than or equal to 2000.

SELECT ename, job
FROM emp
WHERE job != 'MANAGER' AND job != 'SALESMAN' AND sal >= 2000;


-- 15. Find the names and hiring dates of the employees who work in Dallas
--	   (deptno = 20) or Chicago (deptno = 30). Display the names instead of
--	   of deptno. No joins!

SELECT ename, hiredate, deptno,
	CASE
		WHEN deptno = 20 THEN 'DALLAS'
		ELSE 'CHICAGO'
	END AS "cityname"
FROM emp
WHERE deptno IN (20, 30)
ORDER BY hiredate DESC;


-- 16. Find all employees who have a salary between 1000 and 2000.

SELECT *
FROM emp
WHERE sal BETWEEN 1000 AND 2000;


-- 17. Find all employees who have a hiredate between 01/01/1981 and 01/01/1982.

SELECT *
FROM emp
WHERE hiredate BETWEEN '01/01/1981' AND '01/01/1982';


-- 18. Find all employees who have a salary not between 800 and 1600.

SELECT *
FROM emp
WHERE sal NOT BETWEEN 800 AND 1600;


-- 19. Find all employees who don't make commission.

SELECT *
FROM emp
WHERE comm IS NULL OR comm = 0;


-- 20. Find all employees who don't make any commission and have a salary greater
--     than 1100, but less than 5000. Exclude employees that have salary 1500.

SELECT *
FROM emp
WHERE (comm IS NULL OR comm = 0) AND (sal > 1100 AND sal < 5000) AND sal != 1500;


-- 21. Find all employees who are salesmen and make either 300 in commission or
--     greater than 1000 in commission.

SELECT ename AS "Employee Name", comm AS "Commission"
FROM emp
WHERE job = 'SALESMAN' AND (comm = 300 OR comm > 1000);


-- 22. Print all entries as "My name is <ename> and I am a <job> and I make 
--                           $<salary> per month."

SELECT 'My name is ' || ename || ' and I am a ' || LOWER(job) || ' and I make $' || sal || ' per month.' AS "Message"
FROM emp;


-- 23. Print all dept. numbers along with salary both in ascending order.

SELECT deptno, sal
FROM emp
ORDER BY deptno, sal ASC;


-- 24. Print "<ename> IS THE NAME and their job is: <job>" 
-- 	   using SRF functions wherever applicable. Wrap everything in
--     CONCATS. Find a way to only capitalize the 1st letter in name.

SELECT CONCAT(CONCAT(CONCAT(INITCAP(LOWER(ename)), UPPER(' is the name ')), LOWER(' and their job is: ')), job)
FROM emp;


-- 25. Find the names of everyone whose name is less than 5 characters.
-- 	   Their name should only have the 1st letter capitalized and all names
-- 	   should be in alphabetical order from A-Z.

SELECT INITCAP(LOWER(ename)) AS "Name", LENGTH(ename) AS "Name Length"
FROM emp
WHERE LENGTH(ename) < 5
ORDER BY "Name";


-- 26. Assuming everyone is a male in the emp table, add a 'Mr. ' prefix to
--	   everyone's name using LPAD.

SELECT LPAD(ename, LENGTH(ename)+4, 'Mr. ')
FROM emp;


-- 27. Find everyone who was hired in 1982.

SELECT *
FROM emp
WHERE trunc(hiredate, 'YEAR') = '01/01/1982';


-- 28. Print out today's date in MM-DD-YYYY format.

SELECT TO_CHAR(CURRENT_DATE, 'MM-DD-YYYY') AS "TODAY"
FROM dual;


-- 29. Print today's date in 'ddth of month, yyy' format.

SELECT TO_CHAR(CURRENT_DATE, 'DDth "of" MONTH, YYYY')
FROM dual;


-- 30. Represent 23596.34 as $23,596.34

SELECT TO_CHAR(23596.34, '$99,999.99')
FROM dual;


-- 31. Print out the salaries of all employees formatted nicely with commas and 
--	   dollar signs.

SELECT ename AS "Employee Name", TO_CHAR(sal, '$99,999.00') AS "Salary"
FROM emp
ORDER BY "Salary" DESC;


-- 32. Print all details of all employees. If their MGR id is NULL, make it say
--	   '0' and if their commission is NULL, make it say '0.' Use ONLY CASE
--     statements.

SELECT empno, ename, job,
	CASE
		WHEN mgr IS NULL THEN 0
		ELSE mgr
	END AS "Manager ID",
	CASE
		WHEN comm IS NULL THEN 0
		ELSE comm
	END AS "Commission"
FROM emp;	


-- 33. Do the same thing you did in 32. except use NVL and say NONE or NO DATA for
--     mgr and comm if NULL.

SELECT empno, ename, job, NVL(TO_CHAR(mgr), 'NONE') AS "Manager", NVL(TO_CHAR(comm), 'NO DATA') AS "Commission"
FROM emp;


-- 34. Print 3 columns: ename, length of ename, and then if the length is ename is 
--	   5, print NULL. Otherwise, just print the length again.

SELECT ename, length(ename), NULLIF(length(ename), 5)
FROM emp;


-- 35. Following up with problem 34, wherever there is a NULL value, make it instead 
--	   say 'LENGTH IS 5.'

SELECT ename, length(ename) AS "Length", NVL(TO_CHAR(NULLIF(length(ename), 5)), 'LENGTH IS 5') AS "Length in Chars"
FROM emp;


-- 36. 