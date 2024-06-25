CREATE DATABASE IF NOT EXISTS sarukulu;
USE sarukulu;

DROP TABLE IF EXISTS payment;
DROP TABLE IF EXISTS order_details;
DROP TABLE IF EXISTS product_details;
DROP TABLE IF EXISTS customer_details;
DROP TABLE IF EXISTS employe;

-- Create tables
CREATE TABLE product_details (
    pid INT PRIMARY KEY,
    pname VARCHAR(50),
    price INT,
    stock INT,
    location VARCHAR(30) CHECK(location IN ('Mumbai', 'Delhi'))
);

CREATE TABLE customer_details (
    cid INT PRIMARY KEY,
    cname VARCHAR(30),
    age INT,
    addr VARCHAR(50)
);

CREATE TABLE order_details (
    oid INT PRIMARY KEY,
    cid INT,
    pid INT,
    amt INT,
    order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (cid) REFERENCES customer_details(cid),
    FOREIGN KEY (pid) REFERENCES product_details(pid)
);

CREATE TABLE payment (
    pay_id INT PRIMARY KEY,
    oid INT,
    amount INT,
    mode VARCHAR(30) CHECK(mode IN ('upi', 'credit', 'debit')),
    status VARCHAR(30),
    payment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (oid) REFERENCES order_details(oid)
);

CREATE TABLE employe (
    eid INT PRIMARY KEY,
    ename VARCHAR(40) NOT NULL,
    phone_no VARCHAR(10) NOT NULL,
    department VARCHAR(40) NOT NULL,
    manager_id INT
);

INSERT INTO product_details VALUES (1, 'Dell Laptop', 55000, 10, 'Mumbai');
INSERT INTO product_details VALUES (2, 'Samsung Mobile', 25000, 20, 'Delhi');
INSERT INTO product_details VALUES (3, 'Sony Headphones', 5000, 40, 'Delhi');
INSERT INTO product_details VALUES (4, 'Asus Laptop', 45000, 12, 'Mumbai');
INSERT INTO product_details VALUES (5, 'Phone Charger', 1200, 0, 'Mumbai');
INSERT INTO product_details VALUES (6, 'iPad', 60000, 8, 'Delhi');
INSERT INTO product_details VALUES (7, 'Bose Speaker', 8000, 5, 'Delhi');

INSERT INTO customer_details VALUES (101, 'Ankit', 35, 'Mumbai');
INSERT INTO customer_details VALUES (102, 'Megha', 28, 'Delhi');
INSERT INTO customer_details VALUES (103, 'Priya', 30, 'Mumbai');
INSERT INTO customer_details VALUES (104, 'Amit', 26, 'Delhi');
INSERT INTO customer_details VALUES (105, 'Rohan', 24, 'Mumbai');

INSERT INTO order_details VALUES (10001, 102, 3, 4500, '2024-05-01 10:00:00');
INSERT INTO order_details VALUES (10002, 104, 2, 23000, '2024-05-02 14:00:00');
INSERT INTO order_details VALUES (10003, 105, 5, 1000, '2024-05-03 12:00:00');
INSERT INTO order_details VALUES (10004, 101, 1, 52000, '2024-05-04 16:00:00');

INSERT INTO payment VALUES (1, 10001, 4500, 'upi', 'completed', '2024-05-01 10:05:00');
INSERT INTO payment VALUES (2, 10002, 23000, 'credit', 'completed', '2024-05-02 14:10:00');
INSERT INTO payment VALUES (3, 10003, 1000, 'debit', 'in process', '2024-05-03 12:15:00');
INSERT INTO payment VALUES (4, 10004, 52000, 'credit', 'completed', '2024-05-04 16:20:00');


INSERT INTO employe VALUES (401, 'Aarav', '9988776655', 'Analysis', 404);
INSERT INTO employe VALUES (402, 'Nikhil', '8877665544', 'Delivery', 406);
INSERT INTO employe VALUES (403, 'Ravi', '7766554433', 'Delivery', 402);
INSERT INTO employe VALUES (404, 'Sneha', '6655443322', 'Sales', 402);
INSERT INTO employe VALUES (405, 'Kiran', '5544332211', 'HR', 404);
INSERT INTO employe VALUES (406, 'Anjali', '4433221100', 'Tech', NULL);


DELIMITER //

CREATE TRIGGER update_stock_after_order
AFTER INSERT ON order_details
FOR EACH ROW
BEGIN
    DECLARE current_stock INT;

    SELECT stock INTO current_stock
    FROM product_details
    WHERE pid = NEW.pid;

    UPDATE product_details
    SET stock = current_stock - NEW.amt
    WHERE pid = NEW.pid;
END //

DELIMITER ;

CREATE VIEW order_payment_summary AS
SELECT o.oid, o.cid, c.cname, o.pid, p.pname, o.amt AS order_amount, py.amount AS payment_amount, py.mode, py.status
FROM order_details o
JOIN customer_details c ON o.cid = c.cid
JOIN product_details p ON o.pid = p.pid
LEFT JOIN payment py ON o.oid = py.oid;


COMMIT;
ROLLBACK;



-- Query to select all data from order_details where order_date is within the last 30 days
SELECT *
FROM order_details
WHERE order_date >= CURDATE() - INTERVAL 30 DAY;

-- Query to select customer with the highest total order amount
SELECT cname 
FROM customer_details 
WHERE cid = (
    SELECT cid 
    FROM order_details 
    GROUP BY cid 
    ORDER BY SUM(amt) DESC 
    LIMIT 1
);

-- Query to find customers who have ordered products from the same location as 'Megha'
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

-- Query to find customers who have ordered products with prices higher than the average price of their orders
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


