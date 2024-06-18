create database bhuv;
use bhuv;

CREATE TABLE employees (
    employee_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100),
    phone_number VARCHAR(20),
    hire_date DATE,
    job_id VARCHAR(30),
    salary DECIMAL(10, 2),
    department_id INT
   
    
);

INSERT INTO employees (employee_id, first_name, last_name, email, phone_number, hire_date, job_id, salary, department_id) VALUES
(1, 'John', 'Doe', 'john.doe@example.com', '123-456-7890', '2021-01-15', 'IT_PROG', 6000.00, 10),
(2, 'Jane', 'Smith', 'jane.smith@example.com', '234-567-8901', '2020-03-22', 'IT_PROG', 7000.00, 10),
(3, 'Robert', 'Brown', 'robert.brown@example.com', '345-678-9012', '2019-05-30', 'HR_REP', 5000.00, 20),
(4, 'Emily', 'Davis', 'emily.davis@example.com', '456-789-0123', '2018-08-15', 'HR_REP', 5500.00, 20),
(5, 'Michael', 'Wilson', 'michael.wilson@example.com', '567-890-1234', '2022-11-11', 'FIN_MGR', 9000.00, 30),
(6, 'William', 'Garcia', 'william.garcia@example.com', '678-901-2345', '2021-02-10', 'IT_PROG', 6200.00, 10),
(7, 'Linda', 'Martinez', 'linda.martinez@example.com', '789-012-3456', '2019-07-20', 'HR_REP', 5300.00, 20),
(8, 'Elizabeth', 'Rodriguez', 'elizabeth.rodriguez@example.com', '890-123-4567', '2020-11-05', 'FIN_MGR', 9100.00, 30),
(9, 'James', 'Hernandez', 'james.hernandez@example.com', '901-234-5678', '2017-04-17', 'FIN_ANALYST', 6700.00, 30),
(10, 'Patricia', 'Lopez', 'patricia.lopez@example.com', '012-345-6789', '2022-10-01', 'IT_PROG', 6300.00, 10),
(11, 'Charles', 'Gonzalez', 'charles.gonzalez@example.com', '123-456-7899', '2021-12-15', 'HR_REP', 5400.00, 20),
(12, 'Mary', 'Perez', 'mary.perez@example.com', '234-567-8902', '2018-06-13', 'FIN_MGR', 9200.00, 30),
(13, 'David', 'Hall', 'david.hall@example.com', '345-678-9013', '2020-09-19', 'IT_PROG', 6400.00, 10),
(14, 'Barbara', 'Young', 'barbara.young@example.com', '456-789-0124', '2019-11-21', 'FIN_ANALYST', 6800.00, 30),
(15, 'Richard', 'King', 'richard.king@example.com', '567-890-1235', '2017-05-25', 'HR_REP', 5500.00, 20);


CREATE TABLE departments (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(100),
    manager_id INT,
    location_id INT
    
   
);

INSERT INTO departments (department_id, department_name, manager_id, location_id) VALUES
(10, 'IT', 1, 1000),
(20, 'HR', 3, 2000),
(30, 'Finance', 5, 3000);

CREATE TABLE locations (
    location_id INT PRIMARY KEY,
    street_address VARCHAR(100),
    postal_code VARCHAR(20),
    city VARCHAR(50),
    state_province VARCHAR(50),
    country_id VARCHAR(10)
);

INSERT INTO locations (location_id, street_address, postal_code, city, state_province, country_id) VALUES
(1000, '123 IT Street', '12345', 'Tech City', 'Tech State', 'US'),
(2000, '456 HR Avenue', '67890', 'Admin City', 'Admin State', 'US'),
(3000, '789 Finance Blvd', '54321', 'Finance City', 'Finance State', 'US');

CREATE TABLE countries (
    country_id VARCHAR(10) PRIMARY KEY,
    country_name VARCHAR(50),
    region_id INT
);

INSERT INTO countries (country_id, country_name, region_id) VALUES
('US', 'United States', 1),
('CA', 'Canada', 1),
('UK', 'United Kingdom', 2);

CREATE TABLE regions (
    region_id INT PRIMARY KEY,
    region_name VARCHAR(50)
);

INSERT INTO regions (region_id, region_name) VALUES
(1, 'North America'),
(2, 'Europe');

select * from employees;
select first_name, last_name, salary from employees;

select * from employees where salary >= 5000;

select * from locations where country_id = 'US';
select * from employees where hire_date > '2020-02-02';

select * from employees where first_name like 'J%';
select * from employees where email like '@example.com%';
SELECT * FROM employees ORDER BY last_name ASC;
SELECT * FROM employees ORDER BY salary DESC;

SELECT COUNT(*) FROM employees;
SELECT AVG(salary) FROM employees;
SELECT SUM(salary) FROM employees;

SELECT job_id, AVG(salary) AS average_salary FROM employees GROUP BY job_id;
select department_id, Count(*) as employee_count from employees Group by department_id;

SELECT department_id, COUNT(*) AS employee_count FROM employees GROUP BY department_id HAVING COUNT(*) > 1;
SELECT job_id, AVG(salary) AS average_salary FROM employees GROUP BY job_id HAVING AVG(salary) > 6000;
SELECT * FROM employees WHERE salary > (SELECT AVG(salary) FROM employees);
SELECT * FROM departments WHERE department_id IN (SELECT department_id FROM employees GROUP BY department_id HAVING COUNT(*) > 1);
SELECT first_name, last_name FROM employees WHERE department_id = 10
UNION
SELECT first_name, last_name FROM employees WHERE job_id = 'IT_PROG';

select department_id, count(*) as total_employees from employees
group by department_id
order by department_id;


select job_id, avg(salary) as average_salary from employees
group by job_id
order by avearge_salary desc;

select department_id, sum(salary) as total_salary from employees
group by department_id 
having sum(salary) > 10000;

SELECT YEAR(hire_date) AS hire_year, COUNT(*) AS total_employees
FROM employees
GROUP BY YEAR(hire_date)
ORDER BY hire_year;

SELECT YEAR(hire_date) AS hire_year, COUNT(*) AS total_employees
FROM employees
GROUP BY YEAR(hire_date)
ORDER BY hire_year;

SELECT first_name, last_name, salary, department_id
FROM employees e
WHERE salary > (
    SELECT AVG(salary)
    FROM employees
    WHERE department_id = e.department_id
);
SELECT d.department_name
FROM departments d
WHERE manager_id NOT IN (
    SELECT employee_id
    FROM employees
    WHERE department_id = d.department_id
);
SELECT l.city, COUNT(e.employee_id) AS total_employees
FROM employees e
JOIN departments d ON e.department_id = d.department_id
JOIN locations l ON d.location_id = l.location_id
GROUP BY l.city
HAVING COUNT(e.employee_id) > 5;
SELECT first_name, last_name, salary
FROM employees
WHERE salary > (SELECT AVG(salary) FROM employees);


SELECT d.department_name, COUNT(e.employee_id) AS total_employees
FROM departments d
JOIN employees e ON d.department_id = e.department_id
JOIN locations l ON d.location_id = l.location_id
WHERE l.city = 'Tech City'
GROUP BY d.department_name;


SELECT j.job_title
FROM jobs j
JOIN employees e ON j.job_id = e.job_id
GROUP BY j.job_title
HAVING AVG(e.salary) > (SELECT AVG(salary) FROM employees);


SELECT r.region_name, COUNT(c.country_id) AS total_countries
FROM regions r
JOIN countries c ON r.region_id = c.region_id
GROUP BY r.region_name
HAVING COUNT(c.country_id) > 2;


SELECT e.first_name, e.last_name, l.city
FROM employees e
JOIN departments d ON e.department_id = d.department_id
JOIN locations l ON d.location_id = l.location_id
WHERE l.city IN (
    SELECT city
    FROM locations
    JOIN departments ON locations.location_id = departments.location_id
    WHERE departments.department_id = e.department_id
);

SELECT first_name, last_name, salary, department_id
FROM employees e
WHERE salary = (
    SELECT MAX(salary)
    FROM employees
    WHERE department_id = e.department_id
);


SELECT department_id, AVG(salary) AS average_salary
FROM employees
GROUP BY department_id
HAVING AVG(salary) > (SELECT AVG(salary) FROM employees);

