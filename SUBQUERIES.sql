create database subqueries;
use subqueries;

select * from employee;
select * from sales;
select * from department;

--  BASIC LEVEL
-- 1. Retrieve the names of employees who earn more than the average salary of all employees.

select name
FROM employee
where salary >  (select Avg(salary) from Employee);

-- 2. Find the employees who belong to the department with the highest average salary.

SELECT name
FROM Employee
WHERE department_id = (SELECT department_id FROM Employee
GROUP BY department_id
ORDER BY AVG(salary) DESC
LIMIT 1);

-- 3. List all employees who have made at least one sale.

SELECT name
FROM Employee
WHERE emp_id IN (SELECT DISTINCT emp_id FROM Sales);

-- 4. Find the employee with the highest sale amount.

SELECT name
FROM Employee
WHERE emp_id = (SELECT emp_id FROM Sales
WHERE sale_amount = (SELECT MAX(sale_amount) FROM Sales));

-- 5. Retrieve the names of employees whose salaries are higher than Shubham’s salary.

select name 
from employee
where salary > (select salary from employee
where salary = 'shubham');

-- INTERMEDIATE LEVEL
-- 1. Find employees who work in the same department as Abhishek.

SELECT NAME 
FROM EMPLOYEE
WHERE department_id = (SELECT department_id FROM employee
WHERE name = 'Abhishek') and name <> 'Abhishek';

-- 2. List departments that have at least one employee earning more than ₹60,000.

SELECT department_name
FROM Department
WHERE department_id IN (SELECT DISTINCT department_id FROM Employee
WHERE salary > 60000);

-- 3. Find the department name of the employee who made the highest sale.

SELECT department_name
FROM Department
WHERE department_id = (SELECT department_id FROM Employee
WHERE emp_id = (SELECT emp_id FROM Sales
WHERE sale_amount = (SELECT MAX(sale_amount)FROM Sales)));

-- 4. Retrieve employees who have made sales greater than the average sale amount.

SELECT DISTINCT name
FROM Employee
WHERE emp_id IN (SELECT emp_id FROM Sales
WHERE sale_amount > (SELECT AVG(sale_amount)FROM Sales));

-- 5. Find the total sales made by employees who earn more than the average salary.

SELECT SUM(sale_amount) AS total_sales
FROM Sales
WHERE emp_id IN (SELECT emp_id FROM Employee
WHERE salary > (SELECT AVG(salary)FROM Employee));

-- ADVANCE LEVEL
-- 1.Find employees who have not made any sales.

SELECT name
FROM Employee
WHERE emp_id NOT IN (SELECT emp_id FROM Sales);

-- 2. List departments where the average salary is above ₹55,000.

SELECT department_name
FROM Department
WHERE department_id IN (SELECT department_id FROM Employee
GROUP BY department_id
HAVING AVG(salary) > 55000);

-- 3. Retrieve department names where the total sales exceed ₹10,000.

SELECT department_name
FROM Department
WHERE department_id IN (SELECT department_id FROM Employee
WHERE emp_id IN ( SELECT emp_id FROM Sales
GROUP BY emp_id
HAVING SUM(sale_amount) > 10000));

-- 4. Find the employee who has made the second-highest sale.

SELECT name
FROM Employee
WHERE emp_id = (SELECT emp_id FROM Sales
WHERE sale_amount = (SELECT MAX(sale_amount)FROM Sales
WHERE sale_amount < (SELECT MAX(sale_amount) FROM Sales)));

-- 5. Retrieve the names of employees whose salary is greater than the highest sale amount recorded.

SELECT name
FROM Employee
WHERE salary > (SELECT MAX(sale_amount) FROM Sales);


