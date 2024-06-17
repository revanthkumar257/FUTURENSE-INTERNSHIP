-- Create database and use it
CREATE DATABASE krish;
USE krish;

-- Create Mobile_detail table
CREATE TABLE Mobile_detail (
    mobile_number INT,
    mobile_id INT,
    mobile_name VARCHAR(59),
    manufacturing_year INT
);

-- Show tables and columns from Mobile_detail
SHOW TABLES;
SHOW COLUMNS FROM Mobile_detail;

-- Create supplie table
CREATE TABLE supplie (
    s_id INT,
    s_name VARCHAR(50),
    sprice INT,
    stock INT,
    location VARCHAR(30) CHECK (location IN ('Mumbai', 'Delhi', 'Chennai'))
);

-- Show tables and columns from supplie
SHOW TABLES;
SHOW COLUMNS FROM supplie;

-- Create customer_details table
CREATE TABLE customer_details (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100),
    customer_email VARCHAR(100),
    phone VARCHAR(10)
);

-- Create order_details table
CREATE TABLE order_details (
    order_id INT,
    customer_id INT,
    payment_id INT,
    amount INT,
    INDEX (order_id), -- Ensure order_id is indexed
    FOREIGN KEY (customer_id) REFERENCES customer_details(customer_id)
    
);

-- Create payment_details table with a foreign key constraint
CREATE TABLE payment_details (
    payment_id INT PRIMARY KEY,
    order_id INT,
    amount INT,
    mode VARCHAR(30) CHECK (mode IN ('upi', 'credit', 'debit')),
    status VARCHAR(30),
    FOREIGN KEY (order_id) REFERENCES order_details(order_id)
);

-- Insert values into supplie table
INSERT INTO supplie (s_id, s_name, sprice, stock, location) VALUES
(1, 'HP Laptop', 50000, 15, 'Mumbai'),
(2, 'Realme Mobile', 20000, 30, 'Delhi'),
(3, 'Boat earpods', 3000, 50, 'Delhi'),
(4, 'Lenovo Laptop', 40000, 15, 'Mumbai'),
(5, 'Charger', 1000, 0, 'Mumbai'),
(6, 'Mac Book', 78000, 6, 'Delhi'),
(7, 'JBL speaker', 6000, 2, 'Delhi');

-- Insert values into customer_details table
INSERT INTO customer_details (customer_id, customer_name, customer_email, phone) VALUES
(101, 'Ravi', 'ravi@example.com', '1234567890'),
(102, 'Rahul', 'rahul@example.com', '1234567891'),
(103, 'Simran', 'simran@example.com', '1234567892'),
(104, 'Purvesh', 'purvesh@example.com', '1234567893'),
(105, 'Sanjana', 'sanjana@example.com', '1234567894');

-- Insert values into order_details table
INSERT INTO order_details (order_id, customer_id, payment_id, amount) VALUES
(10001, 102, 3, 2700),
(10002, 104, 2, 18000),
(10003, 105, 5, 900),
(10004, 101, 1, 46000);

-- Insert values into payment_details table
INSERT INTO payment_details (payment_id, order_id, amount, mode, status) VALUES
(1, 10001, 2700, 'upi', 'completed'),
(2, 10002, 18000, 'credit', 'completed'),
(3, 10003, 900, 'debit', 'in process');

-- Modify location column in supplie table
ALTER TABLE supplie 
MODIFY COLUMN location VARCHAR(30) CHECK (location IN ('Mumbai', 'Delhi', 'Chennai'));

-- Show columns from supplie
SHOW COLUMNS FROM supplie;

-- Modify customer_id column in customer_details table
ALTER TABLE customer_details MODIFY COLUMN customer_id INT NOT NULL;

-- Show columns from customer_details
SHOW COLUMNS FROM customer_details;

-- Make a new table employee with specified column id, name, position and salary.
create table Employee 
(
emp_id int,
emp_name varchar(50),
emp_position varchar(30),
emp_salary int
);

-- )insert query adds a new row to the employees table with specific values for id, name, position, and salary.
insert into Employee (emp_id,emp_name,emp_position,emp_salary) values (1,'bunny','engineer' , 100000);
show columns from Employee;
select * from Employee;

-- 2)update query updates the salary of the employee with id = 1.
UPDATE Employee
SET emp_salary = 200000
WHERE emp_id = 1;

SET SQL_SAFE_UPDATES = 0;

UPDATE Employee SET emp_salary = 200000 where emp_id=1;
-- 3)delete query deletes the row from employees where id = 1.
delete from employee where emp_id = 1;
-- 4)create a query that creates a table called students.
CREATE TABLE students (
    student_id INT PRIMARY KEY,
    student_name VARCHAR(100),
    course_id INT
    
);
-- 5)create another table courses and set up a foreign key constraint in the students table.
	-- The foreign key constraint ensures that the course_id in students must refer to a valid course_id in the courses table.
    CREATE TABLE courses (
    course_id INT PRIMARY KEY,
    course_name VARCHAR(100)
);
-- 6)Alter the students table to add the foreign key constraint.
ALTER TABLE students
ADD CONSTRAINT fk_course
FOREIGN KEY (course_id) REFERENCES courses(course_id);
-- 7)insert some data into the students table while respecting the constraints.
-- First insert data into courses table
INSERT INTO courses (course_id, course_name)
VALUES (1, 'Mathematics'),
       (2, 'Physics'),
       (3, 'Literature');

-- Then insert data into students table
INSERT INTO students (student_id, student_name, course_id)
VALUES (101, 'Alice', 1),
       (102, 'Bob', 2),
       (103, 'Charlie', 3);
-- 8)create a SELECT query that retrieves products based on numeric and date conditions.
-- Example: Retrieve products with price greater than 1000 and manufacturing year after 2010
SELECT *FROM products
WHERE price > 1000
AND manufacturing_year > 2010;
-- 9)update a record and set the last_updated column to the current datetime.
UPDATE products SET price = 1200, last_updated = NOW() WHERE product_id = 1;
-- 10)delete products with stock below a certain threshold.
DELETE FROM products
WHERE stock < 10;

-- Arithmetic Operators:
-- 1) Write a query to calculate the total revenue by adding the prices of all products in the products table.
SELECT SUM(price) AS total_revenue FROM products;


-- 2) Write a query to find the products whose price is divisible by 3 using the modulo operator (%).
SELECT * FROM products WHERE price % 3 = 0;

-- 3) Write a query to subtract the average price from the price of each product and display the result as 
   -- price_difference.
   SELECT price - (SELECT AVG(price) FROM products) AS price_difference FROM products;

   
-- Comparison Operators:
-- 1) Write a query to retrieve all products whose price is greater than or equal to 50000.
SELECT *FROM products WHERE price >= 50000;

-- 2) Write a query to find the customers whose age is not equal to 30.
SELECT *
FROM customer_details
WHERE age <> 30;

-- 3) Write a query to retrieve all orders where the order amount is less than or equal to 10000.
SELECT *
FROM order_details
WHERE amount <= 10000;

-- Bitwise Operators:
-- 1) Explain the bitwise AND (&) operator with an example.
SELECT 59 & 32 AS result;

-- 2) Explain the bitwise OR (|) operator with an example.
SELECT 6 | 7 AS result;

-- 3) Explain the bitwise XOR (^) operator with an example.
SELECT 1 ^ 2 AS result;

-- Logical Operators:
-- 1) Write a query to retrieve the products that are located in Mumbai and have a stock level greater than 10.
SELECT * FROM products WHERE location = 'Mumbai' AND stock > 10;

-- 2) Write a query to find the customers who are either from Mumbai or have placed an order with an amount greater
 --  than 20000.
 SELECT * FROM customer_details WHERE address = 'Mumbai' OR customer_id IN (SELECT DISTINCT customer_id FROM order_details WHERE amount > 20000);

-- 3) Write a query to retrieve the orders where the payment mode is not 'upi' and the status is 'completed'.
SELECT * FROM order_details WHERE payment_id NOT IN (SELECT payment_id FROM payment_details WHERE mode = 'upi')
  AND payment_id IN (SELECT payment_id FROM payment_details WHERE status = 'completed');



