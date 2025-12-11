
#PatriciaChukwu project 

SELECT 
    dept_no
FROM
    departments;
SELECT 
    *
FROM
    departments;

# Select all people from the “employees” table whose first name is “Elvis”

SELECT 
    *
FROM
    employees
WHERE
    first_name = 'elvis';
    
# Retrieve a list with all female employees whose first name is Kellie.
SELECT 
    *
FROM
    employees
WHERE
    first_name = 'Kellie' AND gender = 'f';
# Retrieve a list with all employees whose first name is either Kellie or Aruna.
SELECT 
    *
FROM
    employees
WHERE
    first_name = 'kellie'
        OR first_name = 'elvis';
        
#Retrieve a list with all female employees whose first name is either Kellie or Aruna
SELECT 
    *
FROM
    employees
WHERE gender='F' And
    (first_name = 'kellie' OR first_name = 'Aruna');
    
# Use the IN operator to select all individuals from the “employees” table, whose first name is either “Denis”, or “Elvis”.
SELECT 
    *
FROM
    employees
WHERE
    first_name IN ('denis' , 'elvis');
    
#Extract all records from the ‘employees’ table, aside from those with employees named John, Mark, or Jacob.
SELECT 
    *
FROM
    employees
WHERE
    first_name NOT IN ('John' , 'Mark', 'Jacob');
    
/* Working with the “employees” table, use the LIKE operator to select the data about all individuals, whose first name starts with “Mark”; specify that the name can be succeeded by any sequence of characters.
Retrieve a list with all employees who have been hired in the year 2000. 
Retrieve a list with all employees whose employee number is written with 5 characters, and starts with “1000”.*/

select * from employees where first_name like ('Mark%');
select * from employees where hire_date like('%2000%');
select * from employees where emp_no like ('1000_');

/*Extract all individuals from the ‘employees’ table whose first name contains “Jack”. 
Once you have done that, extract another list containing the names of employees that do not contain “Jack”.*/
select*from employees where first_name like ('%jack%');
select*from employees where first_name not like ('%jack%');

use employees;
SELECT 
    *
FROM
    salaries
WHERE
    salary BETWEEN 66000 AND 70000;
#Retrieve a list with all individuals whose employee number is not between ‘10004’ and ‘10012’.
SELECT
    *
FROM
    employees
WHERE
    emp_no NOT BETWEEN '10004' AND '10012'
    ;
#Select the names of all departments with numbers between ‘d003’ and ‘d006’.
SELECT
    dept_name
FROM
    departments
WHERE
    dept_no BETWEEN 'd003' AND 'd006';

#Select the names of all departments whose department number value is not null.
select dept_name from departments where dept_no is not null;

#Retrieve a list with data about all female employees who were hired in the year 2000 or after

SELECT 
    *
FROM
    employees
WHERE
    hire_date >= '2000-01-01'
        AND gender = 'F';

#Extract a list with all employees’ salaries higher than $150,000 per annum.
SELECT 
    *
FROM
    salaries
WHERE
    salary > '150000';

SELECT 
    gender
FROM
    employees;
SELECT DISTINCT
    gender
FROM
    employees;
    
#Obtain a list with all different “hire dates” from the “employees” table.
select hire_date from employees;
select distinct hire_date from employees;

#Expand this list and click on “Limit to 1000 rows”. This way you will set the limit of output rows displayed back to the default of 1000.
#How many annual contracts with a value higher than or equal to $100,000 have been registered in the salaries table?
SELECT
    COUNT(*)
FROM
    salaries
WHERE
    salary >= 100000;
#How many managers do we have in the “employees” database? Use the star symbol (*) in your code to solve this exercise.
SELECT 
    COUNT(*)
FROM
    dept_manager;
#Select all data from the “employees” table, ordering it by “hire date” in descending order.
SELECT 
    *
FROM
    employees
ORDER BY hire_date DESC;

/*Write a query that obtains two columns. The first column must contain annual salaries higher than 80,000 dollars. 
#The second column, renamed to “emps_with_same_salary”, must show the number of employees contracted to that salary. 
#Lastly, sort the output by the first column.*/
SELECT 
    salary, COUNT(emp_no) AS emps_with_same_salary
FROM
    salaries
WHERE
    salary > 80000
GROUP BY salary
ORDER BY salary ASC;

SELECT 
    *, AVG(salary) as Average salary
FROM
    salaries
WHERE
    salary > 120000
GROUP BY emp_no
ORDER BY emp_no;

SELECT 
  emp_no, AVG(salary) as average_salary
FROM
    salaries
GROUP BY emp_no
HAVING AVG(salary) > 120000
ORDER BY emp_no DESC;

SELECT 
    emp_no
FROM
    dept_emp
WHERE
    from_date > '2000-01-01'
GROUP BY emp_no
HAVING COUNT(from_date) > 1
ORDER BY emp_no;

ALTER TABLE departments_dup
DROP COLUMN dept_manager;

ALTER TABLE departments_dup
CHANGE COLUMN dept_no dept_no CHAR(4) NULL;

/*Create and fill in the ‘dept_manager_dup’ table, using the following code:*/



DROP TABLE IF EXISTS dept_manager_dup;

CREATE TABLE dept_manager_dup (
    emp_no INT(11) NOT NULL,
    dept_no CHAR(4) NULL,
    from_date DATE NOT NULL,
    to_date DATE NULL
);


INSERT INTO dept_manager_dup
select * from dept_manager;

INSERT INTO dept_manager_dup (emp_no, from_date)
VALUES                (999904, '2017-01-01'),
                                (999905, '2017-01-01'),
                               (999906, '2017-01-01'),
                               (999907, '2017-01-01');

DELETE FROM dept_manager_dup 
WHERE
    dept_no = 'd001';

/*Extract a list containing information about all managers’ employee number, 
first and last name, department number, and hire date.*/
SELECT * FROM employees;
select * from dept_manager;

SELECT 
    e.emp_no, e.first_name, e.last_name, dm.dept_no, e.hire_date
FROM
    employees e
        JOIN
    dept_manager dm ON e.emp_no = dm.emp_no;

/*Join the 'employees' and the 'dept_manager' tables to return a subset of all the
employees whose last name is Markovitch. See if the output contains a manager with that name.  
Hint: Create an output containing information corresponding to the following fields:
 ‘emp_no’, ‘first_name’, ‘last_name’, ‘dept_no’, ‘from_date’. Order by 'dept_no' descending,
 and then by 'emp_no'.*/
 
 SELECT 
    *
FROM
    EMPLOYEES;
 SELECT 
    *
FROM
    DEPT_MANAGER;


SELECT 
    e.emp_no,
    e.first_name,
    e.last_name,
    dm.dept_no,
    dm.from_date
FROM
    employees e
        LEFT JOIN
    dept_manager dm ON e.emp_no = dm.emp_no
WHERE
    e.last_name = 'Markovitch'
ORDER BY dm.dept_no DESC , e.emp_no;

/*Use a LEFT JOIN to retrieve the employee number (emp_no), first name (first_name), and last 
names (last_name) of all individuals whose last name is 'Bamford'. Join the data from the 
employees table with the data from dept_manager to add two more columns: the number of the 
department these people are working in (dept_no) and the start date of their contracts 
(from_date). Sort your output by department number in descending order.*/

SELECT 
    e.emp_no,
    e.first_name,
    e.last_name,
    dm.dept_no,
    dm.from_date
FROM
    employees e
        LEFT JOIN
    dept_manager dm ON e.emp_no = dm.emp_no
WHERE
    e.last_name = 'Bamford'
ORDER BY dm.dept_no DESC , e.emp_no; 

SELECT 
    e.first_name, e.last_name, e.hire_date, t.title
FROM
    employees e
        JOIN
    titles t ON e.emp_no = t.emp_no
WHERE
    first_name = 'Margareta'
        AND last_name = 'Markovitch'
ORDER BY e.emp_no

;   
/*Use a CROSS JOIN to return a list with all possible combinations 
between managers from the dept_manager table and department number 9.*/

SELECT
    dm.*, d.*
FROM  
    departments d  
        CROSS JOIN  
    dept_manager dm  
WHERE  
    d.dept_no = 'd009'  
ORDER BY d.dept_no;

/*Return a list with the first 10 employees with all the departments they can be assigned to.
Hint: Don’t use LIMIT; use a WHERE clause.*/
SELECT
    e.*, d.*
FROM
    employees e
        CROSS JOIN
    departments d
WHERE
    e.emp_no < 10011
ORDER BY e.emp_no, d.dept_name;

/*Use a CROSS JOIN to return a list with all possible combinations 
between managers from the dept_manager table and department number 6 
(dept_no) from the departments table.*/

select dm.*, d.*
from dept_manager dm
cross join 
departments d 
where d.dept_no='d006'
order by d.dept_no;

/*average salary of all gender present*/
SELECT 
    e.gender, AVG(s.salary) AS average_salary
FROM
    employees e
        JOIN
    salaries s ON e.emp_no = s.emp_no
GROUP BY gender;

/*join 3 tables together*/
SELECT 
    e.first_name,
    e.last_name,
    e.hire_date,
    m.from_date,
    d.dept_name
FROM
    employees e
        JOIN
    dept_manager m ON e.emp_no = m.emp_no
        JOIN
    departments d ON m.dept_no = d.dept_no;
    
    
/*Select all managers’ first and last name, hire date, job title, start date, and department name.*/

select 
e.first_name,
e.last_name,
e.hire_date,
t.title,
dm.from_date as start_date,
d.dept_name
from 
employees e
join 
dept_manager dm on e.emp_no=dm.emp_no
join
departments d on d.dept_no=dm.dept_no
join 
titles t on t.emp_no=dm.emp_no
where t.title='Manager'
order by e.emp_no asc;



