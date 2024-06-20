CREATE DATABASE sarukulu;

USE sarukulu;

CREATE TABLE product_details (
    pid INT PRIMARY KEY,
    pname VARCHAR(50),
    price INT,
    stock INT,
    location VARCHAR(30) CHECK(location IN ('Mumbai', 'Delhi'))
);

INSERT INTO product_details VALUES (1, 'Dell Laptop', 55000, 10, 'Mumbai');
INSERT INTO product_details VALUES (2, 'Samsung Mobile', 25000, 20, 'Delhi');
INSERT INTO product_details VALUES (3, 'Sony Headphones', 5000, 40, 'Delhi');
INSERT INTO product_details VALUES (4, 'Asus Laptop', 45000, 12, 'Mumbai');
INSERT INTO product_details VALUES (5, 'Phone Charger', 1200, 0, 'Mumbai');
INSERT INTO product_details VALUES (6, 'iPad', 60000, 8, 'Delhi');
INSERT INTO product_details VALUES (7, 'Bose Speaker', 8000, 5, 'Delhi');

CREATE TABLE customer_details (
    cid INT PRIMARY KEY,
    cname VARCHAR(30),
    age INT,
    addr VARCHAR(50)
);

INSERT INTO customer_details VALUES (101, 'Ankit', 35, 'Mumbai');
INSERT INTO customer_details VALUES (102, 'Megha', 28, 'Delhi');
INSERT INTO customer_details VALUES (103, 'Priya', 30, 'Mumbai');
INSERT INTO customer_details VALUES (104, 'Amit', 26, 'Delhi');
INSERT INTO customer_details VALUES (105, 'Rohan', 24, 'Mumbai');

CREATE TABLE order_details (
    oid INT PRIMARY KEY,
    cid INT,
    pid INT,
    amt INT,
    FOREIGN KEY (cid) REFERENCES customer_details(cid),
    FOREIGN KEY (pid) REFERENCES product_details(pid)
);

INSERT INTO order_details VALUES (10001, 102, 3, 4500);
INSERT INTO order_details VALUES (10002, 104, 2, 23000);
INSERT INTO order_details VALUES (10003, 105, 5, 1000);
INSERT INTO order_details VALUES (10004, 101, 1, 52000);

CREATE TABLE payment (
    pay_id INT PRIMARY KEY,
    oid INT,
    amount INT,
    mode VARCHAR(30) CHECK(mode IN ('upi', 'credit', 'debit')),
    status VARCHAR(30),
    timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (oid) REFERENCES order_details(oid)
);

INSERT INTO payment VALUES (1, 10001, 4500, 'upi', 'completed', '2024-05-01 08:00:00');
INSERT INTO payment VALUES (2, 10002, 23000, 'credit', 'completed', '2024-05-01 08:10:00');
INSERT INTO payment VALUES (3, 10003, 1000, 'debit', 'in process', '2024-05-01 08:15:00');
INSERT INTO payment VALUES (4, 10004, 52000, 'credit', 'completed', '2024-05-01 08:20:00');

CREATE TABLE employe (
    eid INT PRIMARY KEY,
    ename VARCHAR(40) NOT NULL,
    phone_no VARCHAR(10) NOT NULL,
    department VARCHAR(40) NOT NULL,
    manager_id INT
);

INSERT INTO employe VALUES (401, 'Aarav', '9988776655', 'Analysis', 404);
INSERT INTO employe VALUES (402, 'Nikhil', '8877665544', 'Delivery', 406);
INSERT INTO employe VALUES (403, 'Ravi', '7766554433', 'Delivery', 402);
INSERT INTO employe VALUES (404, 'Sneha', '6655443322', 'Sales', 402);
INSERT INTO employe VALUES (405, 'Kiran', '5544332211', 'HR', 404);
INSERT INTO employe VALUES (406, 'Anjali', '4433221100', 'Tech', NULL);

SELECT cname 
FROM customer_details 
WHERE cid = (
    SELECT cid 
    FROM order_details 
    GROUP BY cid 
    ORDER BY SUM(amt) DESC 
    LIMIT 1
);

SELECT cname
FROM customer_details
WHERE cid IN (
    SELECT DISTINCT cid
    FROM order_details
    WHERE pid IN (
        SELECT pid
        FROM product_details
        WHERE location = (
            SELECT location
            FROM customer_details
            WHERE cname = 'Megha'
        )
    )
);

SELECT cname
FROM customer_details c
WHERE EXISTS (
    SELECT 1
    FROM order_details o
    JOIN product_details p ON o.pid = p.pid
    WHERE o.cid = c.cid
    AND p.price > (
        SELECT AVG(price)
        FROM product_details
        WHERE pid IN (
            SELECT pid
            FROM order_details
            WHERE cid = c.cid
        )
    )
);

SELECT c.cname, SUM(o.amt) AS total_amount_spent
FROM customer_details c
INNER JOIN order_details o ON c.cid = o.cid
INNER JOIN product_details p ON o.pid = p.pid
INNER JOIN (
    SELECT location, AVG(price) AS avg_price
    FROM product_details
    GROUP BY location
) avg_prices ON p.location = avg_prices.location
WHERE p.price > avg_prices.avg_price
GROUP BY c.cname;


SELECT c.cname, COALESCE(SUM(o.amt), 0) AS total_amount_spent
FROM customer_details c
LEFT JOIN order_details o ON c.cid = o.cid
GROUP BY c.cname;

SELECT c.cid,
       c.cname,
       c.age,
       c.addr,
       COALESCE(o.oid, 'No order') AS order_id,
       COALESCE(p.status, 'No order') AS order_status,
       CASE 
           WHEN o.oid IS NULL THEN 'Out of stock'
           ELSE ''
       END AS reason_for_no_order
FROM customer_details c
LEFT JOIN order_details o ON c.cid = o.cid
LEFT JOIN product_details p ON o.pid = p.pid
ORDER BY c.cid;

SELECT pname, price, RANK() OVER (ORDER BY price DESC) AS price_rank
FROM product_details;


SELECT pname, price, DENSE_RANK() OVER (ORDER BY price DESC) AS dense_price_rank
FROM product_details;

SELECT pname, price, ROW_NUMBER() OVER (ORDER BY price DESC) AS row_num
FROM product_details;

SELECT pname, price, CUME_DIST() OVER (ORDER BY price) AS cumulative_distribution
FROM product_details;

SELECT pname, price, LAG(price) OVER (ORDER BY price) AS previous_price
FROM product_details;

SELECT pname, price, LEAD(price) OVER (ORDER BY price) AS next_price
FROM product_details;
SELECT *
FROM order_details
WHERE order_date >= CURDATE() - INTERVAL 30 DAY;


SELECT DATE(order_date) AS order_day, SUM(amt) AS total_amount
FROM order_details
GROUP BY DATE(order_date);

SELECT MONTH(order_date) AS order_month, COUNT(*) AS num_orders
FROM order_details
WHERE YEAR(order_date) = YEAR(CURDATE())
GROUP BY MONTH(order_date);

SELECT YEAR(order_date) AS order_year, pid, SUM(amt) AS total_sales
FROM order_details
GROUP BY YEAR(order_date), pid;

SELECT c.cname, o.oid, o.order_date
FROM customer c
JOIN order_details o ON c.cid = o.cid
WHERE o.order_date = (
    SELECT MIN(order_date)
    FROM order_details
    WHERE YEAR(order_date) = YEAR(CURDATE())
    AND MONTH(order_date) = MONTH(CURDATE())
);

SELECT *FROM payment WHERE payment_date >= CURDATE() - INTERVAL 7 DAY;
SELECT DATE(order_date) AS order_day, COUNT(*) AS num_orders, SUM(amt) AS total_sales
FROM order_details
WHERE YEARWEEK(order_date, 1) = YEARWEEK(CURDATE(), 1)
GROUP BY DATE(order_date);

SELECT ename, hire_date
FROM employe
ORDER BY hire_date
LIMIT 1;
SELECT o.oid, o.order_date, p.status
FROM order_details o
LEFT JOIN payment p ON o.oid = p.oid
WHERE o.order_date BETWEEN '2024-01-01' AND '2024-06-01';

