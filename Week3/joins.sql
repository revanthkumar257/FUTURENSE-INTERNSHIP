CREATE DATABASE sarukulu;

USE sarukulu;

CREATE TABLE product_details (
    pid INt,
    pname VARCHAR(50) ,
    price Int,
    stock INT,
    location VARCHAR(30) CHECK(location IN ('Mumbai','Delhi'))
);

INSERT INTO products VALUES (1, 'Dell Laptop', 55000, 10, 'Mumbai');
INSERT INTO products VALUES (2, 'Samsung Mobile', 25000, 20, 'Delhi');
INSERT INTO products VALUES (3, 'Sony Headphones', 5000, 40, 'Delhi');
INSERT INTO products VALUES (4, 'Asus Laptop', 45000, 12, 'Mumbai');
INSERT INTO products VALUES (5, 'Phone Charger', 1200, 0, 'Mumbai');
INSERT INTO products VALUES (6, 'iPad', 60000, 8, 'Delhi');
INSERT INTO products VALUES (7, 'Bose Speaker', 8000, 5, 'Delhi');

CREATE TABLE customer_details (
    cid INT ,
    cname VARCHAR(30) ,
    age INT,
    addr VARCHAR(50)
);

INSERT INTO customer VALUES (101, 'Ankit', 35, 'Mumbai');
INSERT INTO customer VALUES (102, 'Megha', 28, 'Delhi');
INSERT INTO customer VALUES (103, 'Priya', 30, 'Mumbai');
INSERT INTO customer VALUES (104, 'Amit', 26, 'Delhi');
INSERT INTO customer VALUES (105, 'Rohan', 24, 'Mumbai');

CREATE TABLE order_details (
    oid INT,
    cid INT,
    pid INT,
    amt INT,
    FOREIGN KEY (cid) REFERENCES customer(cid),
    FOREIGN KEY (pid) REFERENCES products(pid)
);

INSERT INTO order_details VALUES (10001, 102, 3, 4500);
INSERT INTO order_details VALUES (10002, 104, 2, 23000);
INSERT INTO order_details VALUES (10003, 105, 5, 1000);
INSERT INTO order_details VALUES (10004, 101, 1, 52000);

CREATE TABLE payment (
    pay_id INT,
    oid INT,
    amount INT,
    mode VARCHAR(30) CHECK(mode IN ('upi', 'credit', 'debit')),
    status VARCHAR(30)
     
);

INSERT INTO payment VALUES (1, 10001, 4500, 'upi', 'completed');
INSERT INTO payment VALUES (2, 10002, 23000, 'credit', 'completed');
INSERT INTO payment VALUES (3, 10003, 1000, 'debit', 'in process');
INSERT INTO payment VALUES (4, 10004, 52000, 'credit', 'completed');

CREATE TABLE employe (
    eid INT,
    ename VARCHAR(40) NOT NULL,
    phone_no varchar(10) not null,
    department VARCHAR(40) NOT NULL,
    manager_id INT
);

INSERT INTO employe VALUES (401, 'Aarav', 9988776655, 'Analysis', 404);
INSERT INTO employe VALUES (402, 'Nikhil', 8877665544, 'Delivery', 406);
INSERT INTO employe VALUES (403, 'Ravi', 7766554433, 'Delivery', 402);
INSERT INTO employe VALUES (404, 'Sneha', 6655443322, 'Sales', 402);
INSERT INTO employe VALUES (405, 'Kiran', 5544332211, 'HR', 404);
INSERT INTO employe VALUES (406, 'Anjali', 4433221100, 'Tech', NULL);

select * from employe;
select * from payment;
select * from payment where mode = 'upi';
select pay_id as payment_id ,mode as mode  from payment  where mode = ('credit') ;

SELECT c.cname, p.pname
FROM customer_details c
INNER JOIN order_details o ON c.cid = o.cid
INNER JOIN product_details p ON o.pid = p.pid;
SELECT customer.cid, cname, order_details.oid FROM order_details
INNER JOIN customer ON order_details.cid = customer.cid;

SELECT c.cname, p.pname
FROM customer_details c
LEFT OUTER JOIN order_details o ON c.cid = o.cid
LEFT OUTER JOIN product_details p ON o.pid = p.pid;


SELECT p.pname, c.cname
FROM product_details p
RIGHT OUTER JOIN order_details o ON p.pid = o.pid
RIGHT OUTER JOIN customer_details c ON o.cid = c.cid;

SELECT c.cname, p.pname
FROM customer_details c
LEFT JOIN order_details o ON c.cid = o.cid
LEFT JOIN product_details p ON o.pid = p.pid
UNION
SELECT c.cname, p.pname
FROM product_details p
LEFT JOIN order_details o ON p.pid = o.pid
LEFT JOIN customer_details c ON o.cid = c.cid;

SELECT e1.ename AS Employee, e2.ename AS Manager
FROM employe e1
LEFT JOIN employe e2 ON e1.manager_id = e2.eid;

SELECT c.cname, p.pname
FROM customer_details c
CROSS JOIN product_details p;

SELECT c.cname, SUM(o.amt) AS total_spent
FROM customer_details c
INNER JOIN order_details o ON c.cid = o.cid
GROUP BY c.cname;

SELECT c.cname
FROM customer_details c
INNER JOIN order_details o ON c.cid = o.cid
WHERE o.pid = (SELECT pid FROM product_details ORDER BY price DESC LIMIT 1);

SELECT o.oid, c.cname, p.pname
FROM order_details o
INNER JOIN customer_details c ON o.cid = c.cid
INNER JOIN product_details p ON o.pid = p.pid
WHERE c.addr = 'Mumbai' AND p.location = 'Delhi';

SELECT p.pay_id, p.amount, p.mode, c.cname, pr.pname
FROM payment p
INNER JOIN order_details o ON p.oid = o.oid
INNER JOIN customer_details c ON o.cid = c.cid
INNER JOIN product_details pr ON o.pid = pr.pid;

SELECT c.cname, o.amt
FROM customer_details c
INNER JOIN order_details o ON c.cid = o.cid
WHERE o.amt > 10000;
SELECT c.cname, o.amt
FROM customer_details c
INNER JOIN order_details o ON c.cid = o.cid
WHERE o.amt > 10000;

SELECT p.pname, o.oid, o.amt
FROM product_details p
LEFT JOIN order_details o ON p.pid = o.pid;
 
 SELECT c.cname, o.oid, o.amt
FROM customer_details c
RIGHT JOIN order_details o ON c.cid = o.cid;

SELECT c.cname, p.pname
FROM customer_details c
LEFT JOIN order_details o ON c.cid = o.cid
LEFT JOIN product_details p ON o.pid = p.pid
WHERE c.addr = 'Mumbai'
UNION
SELECT c.cname, p.pname
FROM product_details p
LEFT JOIN order_details o ON p.pid = o.pid
LEFT JOIN customer_details c ON o.cid = c.cid
WHERE c.addr = 'Mumbai';

SELECT e1.department, COUNT(e1.eid) AS num_employees, e2.ename AS manager_name
FROM employe e1
LEFT JOIN employe e2 ON e1.manager_id = e2.eid
GROUP BY e1.department, e2.ename;

SELECT e1.department, COUNT(e1.eid) AS num_employees, e2.ename AS manager_name
FROM employe e1
LEFT JOIN employe e2 ON e1.manager_id = e2.eid
GROUP BY e1.department, e2.ename;

SELECT c.cname, p.pname
FROM customer_details c
CROSS JOIN product_details p
WHERE p.stock > 0;
