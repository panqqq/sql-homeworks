-- Write a query to display: 
-- 1. the first name, last name, salary, and job grade for all employees.
SELECT first_name, last_name, salary, job_title
FROM employees
         LEFT JOIN jobs USING (job_id);

-- 2. the first and last name, department, city, and state province for each employee.
SELECT e.first_name, e.last_name, d.department_name, l.city, l.state_province
FROM ((employees e
LEFT JOIN departments d USING (department_id))
LEFT JOIN locations l USING (location_id));

-- 3. the first name, last name, department number and department name, for all employees for departments 80 or 40.
SELECT e.first_name, e.last_name, e.department_id, d.department_name
FROM employees e
LEFT JOIN departments d ON e.department_id = d.department_id
WHERE e.department_id = 80 OR e.department_id = 40;

-- 4. those employees who contain a letter z to their first name and also display their last name, department, city, and state province.
SELECT e.first_name, e.last_name, d.department_name, l.city, l.state_province
FROM ((employees e
LEFT JOIN departments d USING (department_id))
LEFT JOIN locations l USING (location_id))
WHERE e.first_name LIKE '%z%';

-- 5. the first and last name and salary for those employees who earn less than the employee earn whose number is 182.
SELECT first_name, last_name, salary
FROM employees
WHERE salary < (SELECT salary FROM employees WHERE employee_id = 182);
-- 6. the first name of all employees including the first name of their manager.
SELECT e.first_name, m.first_name AS "Manager First Name"
FROM employees e, employees m
WHERE e.manager_id = m.employee_id;

-- 7. the first name of all employees and the first name of their manager including those who does not working under any manager.
SELECT e.first_name, m.first_name AS "Manager"
FROM employees e
LEFT JOIN employees m ON e.manager_id = m.employee_id;

-- 8. the details of employees who manage a department.
SELECT DISTINCT d.manager_id, d.department_name, e.first_name, e.last_name, l.city, l.state_province
FROM ((departments d
LEFT JOIN employees e ON d.manager_id = e.employee_id)
LEFT JOIN locations l ON d.location_id = l.location_id)
WHERE d.manager_id IS NOT NULL;

-- 9. the first name, last name, and department number for those employees who works in the same department as the employee who holds the last name as Taylor.
SELECT first_name, last_name, department_id
FROM employees
WHERE department_id = ANY (SELECT department_id FROM employees WHERE last_name = 'Taylor');

--10. the department name and number of employees in each of the department.
SELECT d.department_name, count(e.department_id) as "number of employees"
FROM departments d
LEFT JOIN employees e ON e.department_id = d.department_id
GROUP BY d.department_name
ORDER BY count(e.department_id) DESC;

--11. the name of the department, average salary and number of employees working in that department who got commission.
SELECT d.department_name, CAST(avg(e.salary) AS DECIMAL(10,2)) as "average salary", count(e.commission_pct) as "employees who got commission"
FROM employees e
LEFT JOIN departments d ON e.department_id = d.department_id
GROUP BY d.department_name
ORDER BY avg(e.salary) DESC, count(e.commission_pct) DESC;

--12. job title and average salary of employees.
SELECT j.job_title, avg(e.salary) AS "average salary"
FROM employees e
LEFT JOIN jobs j ON e.job_id = j.job_id
GROUP BY j.job_title;
--13. the country name, city, and number of those departments where at least 2 employees are working.
SELECT c.country_name, l.city, count(d.department_id) as "Number of Departments"
FROM (((departments d
LEFT JOIN employees e ON d.department_id = e.department_id)
LEFT JOIN locations l ON d.location_id = l.location_id)
LEFT JOIN countries c ON c.country_id = l.country_id)
GROUP BY c.country_name, l.city
HAVING count(d.department_id) >= 2;

--14. the employee ID, job name, number of days worked in for all those jobs in department 80.
SELECT e.employee_id, e.first_name || ' ' || e.last_name, j.job_title, trunc(jh.end_date - jh.start_date) as daysWorked
FROM ((employees e
LEFT JOIN jobs j ON e.job_id = j.job_id)
LEFT JOIN job_history jh ON j.job_id = jh.job_id)
WHERE e.department_id = 80
ORDER BY e.first_name || e.last_name;

--15. the name ( first name and last name ) for those employees who gets more salary than the employee whose ID is 163.
SELECT first_name || ' ' || last_name AS "name"
FROM employees
WHERE salary > (SELECT salary FROM employees WHERE employee_id = 163);

--16. the employee id, employee name (first name and last name ) for all employees who earn more than the average salary.
SELECT employee_id, first_name || ' ' || last_name AS "name"
FROM employees
WHERE salary > (SELECT avg(salary) FROM employees);

--17. the employee name ( first name and last name ), employee id and salary of all employees who report to Payam.
SELECT first_name || ' ' || last_name AS "name", employee_id, salary
FROM employees
WHERE manager_id > (SELECT manager_id FROM employees WHERE first_name = 'Payam');

--18. the department number, name ( first name and last name ), job and department name for all employees in the Finance department.
SELECT e.department_id, e.first_name || ' ' || e.last_name AS "name", j.job_title, d.department_name
FROM ((departments d
LEFT JOIN employees e ON d.department_id = e.department_id)
LEFT JOIN jobs j ON e.job_id = j.job_id)
WHERE d.department_name = 'Finance';

--19. all the information of an employee whose id is any of the number 134, 159 and 183.
SELECT *
FROM ((((((employees e
LEFT JOIN jobs j ON e.job_id = j.job_id)
LEFT JOIN job_history jh ON jh.employee_id = e.employee_id)
LEFT JOIN departments d ON d.department_id = e.department_id)
LEFT JOIN locations l ON d.location_id = l.location_id)
LEFT JOIN countries c ON l.country_id = c.country_id)
LEFT JOIN regions r ON c.region_id = r.region_id)
WHERE e.employee_id = 134 OR e.employee_id = 159 OR e.employee_id = 183;

--20. all the information of the employees whose salary is within the range of smallest salary and 2500.
SELECT *
FROM ((((((employees e
LEFT JOIN jobs j ON e.job_id = j.job_id)
LEFT JOIN job_history jh ON jh.employee_id = e.employee_id)
LEFT JOIN departments d ON d.department_id = e.department_id)
LEFT JOIN locations l ON d.location_id = l.location_id)
LEFT JOIN countries c ON l.country_id = c.country_id)
LEFT JOIN regions r ON c.region_id = r.region_id)
WHERE e.salary BETWEEN (SELECT min(salary) FROM employees) AND 2500;

--21. all the information of the employees who does not work in those departments where some employees works whose id within the range 100 and 200.
SELECT *
FROM employees e
WHERE e.department_id IN (SELECT s.department_id FROM employees s WHERE s.employee_id NOT BETWEEN 100 AND 200);

--22. all the information for those employees whose id is any id who earn the second highest salary.
SELECT *
FROM ((((((employees e
LEFT JOIN jobs j ON e.job_id = j.job_id)
LEFT JOIN job_history jh ON jh.job_id = j.job_id)
LEFT JOIN departments d ON d.department_id = e.department_id)
LEFT JOIN locations l ON d.location_id = l.location_id)
LEFT JOIN countries c ON l.country_id = c.country_id)
LEFT JOIN regions r ON c.region_id = r.region_id)
WHERE e.employee_id = (SELECT employee_id FROM employees ORDER BY salary DESC OFFSET 1 ROWS FETCH FIRST 1 ROWS ONLY);

--23. the employee name( first name and last name ) and hiredate for all employees in the same department as Clara. Exclude Clara.
SELECT e.first_name || ' ' || e.last_name AS "name", e.hire_date
FROM employees e
WHERE e.department_id = (SELECT department_id FROM employees WHERE first_name = 'Clara')
AND first_name != 'Clara';

--24. the employee number and name( first name and last name ) for all employees who work in a department with any employee whose name contains a T.
SELECT e.employee_id, e.first_name || ' ' || e.last_name AS "name"
FROM employees e
WHERE e.department_id IN (SELECT department_id FROM employees WHERE first_name LIKE '%T%' OR last_name LIKE '%T%');

--25. full name(first and last name), job title, starting and ending date of last jobs for those employees with worked without a commission percentage.
SELECT e.first_name || ' ' || e.last_name as "full name", j.job_title, jh.start_date, jh.end_date
FROM ((jobs j
LEFT JOIN employees e ON j.job_id = e.job_id)
LEFT JOIN job_history jh ON e.employee_id = jh.employee_id)
WHERE e.commission_pct IS NULL
ORDER BY e.first_name || ' ' || e.last_name;

--26. the employee number, name( first name and last name ), and salary for all employees who earn more than the average salary and who work in a department with any employee with a J in their name.
SELECT e.employee_id, e.first_name || ' ' || e.last_name as "full name", salary
FROM employees e
LEFT JOIN departments d ON e.department_id = d.department_id
WHERE e.salary > (SELECT avg(salary) FROM employees) AND e.department_id = ANY (SELECT department_id FROM employees WHERE first_name LIKE '%J%');

--27. the employee number, name( first name and last name ) and job title for all employees whose salary is smaller than any salary of those employees whose job title is MK_MAN.
SELECT e.employee_id, e.first_name || ' ' || e.last_name AS "name", j.job_title
FROM employees e
LEFT JOIN jobs j ON e.job_id = j.job_id
WHERE salary < ANY (SELECT salary FROM employees WHERE e.job_id = 'MK_MAN');

--28. the employee number, name( first name and last name ) and job title for all employees whose salary is smaller than any salary of those employees whose job title is MK_MAN. Exclude Job title MK_MAN.
SELECT e.employee_id, e.first_name || ' ' || e.last_name AS "name", j.job_title
FROM employees e
LEFT JOIN jobs j ON e.job_id = j.job_id
WHERE salary < ANY (SELECT salary FROM employees WHERE e.job_id = 'MK_MAN')
AND e.job_id != 'MK_MAN';

--29. all the information of those employees who did not have any job in the past.
SELECT *
FROM employees e
LEFT JOIN job_history jh using (employee_id)
WHERE jh.job_id IS NULL;

--30. the employee number, name( first name and last name ) and job title for all employees whose salary is more than any average salary of any department.
SELECT e.employee_id, e.first_name || ' ' || e.last_name AS "name", j.job_title
FROM employees e
LEFT JOIN jobs j USING (job_id)
WHERE e.salary > (SELECT avg(salary) FROM employees); --WHERE department_id IS NOT NULL (in case only whose have department)

--31. the employee id, name ( first name and last name ) and the job id column with a modified title SALESMAN for those employees whose job title is ST_MAN and DEVELOPER for whose job title is IT_PROG.
SELECT e.employee_id, e.first_name || ' ' || e.last_name AS "name",
CASE e.job_id
WHEN 'ST_MAN' THEN 'SALESMAN'
WHEN 'IT_PROG' THEN 'DEVELOPER'
END AS "JOB TITLE"
FROM employees e
WHERE e.job_id IN ('ST_MAN', 'IT_PROG');

--32. the employee id, name ( first name and last name ), salary and the SalaryStatus column with a title HIGH and LOW respectively for those employees whose salary is more than and less than the average salary of all employees.
SELECT e.employee_id, e.first_name || ' ' || e.last_name AS "name", e.salary,
CASE
WHEN e.salary > (SELECT avg(salary) FROM employees) THEN 'HIGH'
WHEN e.salary < (SELECT avg(salary) FROM employees) THEN 'LOW'
END AS SalaryStatus
FROM employees e;

--33. the employee id, name ( first name and last name ), SalaryDrawn, AvgCompare (salary - the average salary of all employees)
    -- and the SalaryStatus column with a title HIGH and LOW respectively for those employees whose salary is more than and less than
    -- the average salary of all employees.
SELECT e.employee_id, e.first_name || ' ' || e.last_name AS "name", e.salary SalaryDrawn,
CAST((e.salary - (SELECT avg(salary) FROM employees)) AS DECIMAL(10)) AvgCompare,
CASE
WHEN e.salary > (SELECT avg(salary) FROM employees) THEN 'HIGH'
WHEN e.salary < (SELECT avg(salary) FROM employees) THEN 'LOW'
END AS SalaryStatus
FROM employees e;

--34. all the employees who earn more than the average and who work in any of the IT departments.
SELECT *
FROM employees e
LEFT JOIN departments d ON e.department_id = d.department_id
WHERE d.department_name LIKE '%IT%' AND e.salary > (SELECT avg(salary) FROM employees);

--35. who earns more than Mr. Ozer.
    --MR or Mrs?
SELECT *
FROM employees e
WHERE salary > (SELECT salary FROM employees WHERE last_name = 'Ozer');

--36. which employees have a manager who works for a department based in the US.
SELECT e.*
FROM (((employees e
LEFT JOIN employees m ON e.manager_id = m.employee_id)
LEFT JOIN departments d ON m.department_id = d.department_id)
LEFT JOIN locations l ON d.location_id = l.location_id)
WHERE l.country_id = 'US';

--37. the names of all employees whose salary is greater than 50% of their department’s total salary bill.
SELECT e.first_name || ' ' || e.last_name AS "name"
FROM employees e
WHERE e.salary > (SELECT sum(salary)/2 FROM employees WHERE e.department_id = department_id);

--38. the employee id, name ( first name and last name ), salary, department name and city for all
--the employees who gets the salary as the salary earn by the employee which is maximum within the joining person January 1st, 2002 and December 31st, 2003.
SELECT e.employee_id, e.first_name || ' ' || e.last_name AS "name", e.salary, d.department_name, l.city
FROM ((employees e
LEFT JOIN departments d USING (department_id))
LEFT JOIN locations l USING (location_id))
WHERE e.salary = (SELECT max(salary) FROM employees WHERE hire_date BETWEEN TO_DATE('01-JAN-2002') AND '31-DEC-2003');

--39. the first and last name, salary, and department ID for all those employees who earn more than the average salary and arrange the list in descending order on salary.
SELECT e.first_name, e.last_name, e.salary, e.department_id
FROM employees e
WHERE e.salary > (SELECT avg(salary) FROM employees)
ORDER BY e.salary DESC;

--40. the first and last name, salary, and department ID for those employees who earn more than the maximum salary of a department which ID is 40.
SELECT e.first_name, e.last_name, e.salary, e.department_id
FROM employees e
WHERE e.salary > (SELECT max(salary) FROM employees WHERE department_id = 40);

--41. the department name and Id for all departments where they located, that Id is equal to the Id for the location where department number 30 is located.
SELECT d.department_name, d.location_id
FROM departments d
WHERE d.location_id = (SELECT location_id FROM departments WHERE department_id = 30);

--42. the first and last name, salary, and department ID for all those employees who work in that department where the employee works who hold the ID 201.
SELECT e.first_name, e.last_name, e.salary, e.department_id
FROM employees e
WHERE e.department_id = (SELECT department_id FROM employees WHERE employee_id = 201);

--43. the first and last name, salary, and department ID for those employees whose salary is equal to the salary of the employee who works in that department which ID is 40.
SELECT e.first_name, e.last_name, e.salary, e.department_id
FROM employees e
WHERE e.salary = (SELECT salary FROM employees WHERE department_id = 40);

--44. the first and last name, salary, and department ID for those employees who earn more than the minimum salary of a department which ID is 40.
SELECT e.first_name, e.last_name, e.salary, e.department_id
FROM employees e
WHERE e.salary > (SELECT min(salary) FROM employees WHERE department_id = 40);

--45. the first and last name, salary, and department ID for those employees who earn less than the minimum salary of a department which ID is 70.
SELECT e.first_name, e.last_name, e.salary, e.department_id
FROM employees e
WHERE e.salary < (SELECT min(salary) FROM employees WHERE department_id = 70);

--46. the first and last name, salary, and department ID for those employees who earn less than the average salary, and also work at the department where the employee Laura is working as a first name holder.
SELECT e.first_name, e.last_name, e.salary, e.department_id
FROM employees e
WHERE e.salary < (SELECT avg(salary) FROM employees)
AND e.department_id = (SELECT department_id FROM employees WHERE first_name = 'Laura');

--47. the full name (first and last name) of manager who is supervising 4 or more employees.
--48. the details of the current job for those employees who worked as a Sales Representative in the past.
--49. all the infromation about those employees who earn second lowest salary of all the employees.
SELECT *
FROM employees
WHERE salary = (SELECT salary FROM employees ORDER BY salary OFFSET 2 ROWS FETCH FIRST 1 ROWS ONLY);
--50. the department ID, full name (first and last name), salary for those employees who is highest salary drawar in a department.

