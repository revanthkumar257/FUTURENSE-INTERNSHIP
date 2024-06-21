CREATE DATABASE ShopEase;
USE ShopEase;

-- Users table
CREATE TABLE Users (
    UserID INT PRIMARY KEY AUTO_INCREMENT,
    UserName VARCHAR(50) NOT NULL,
    Email VARCHAR(100) NOT NULL UNIQUE,
    PasswordHash VARCHAR(255) NOT NULL,
    CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Products table
CREATE TABLE Products (
    ProductID INT PRIMARY KEY AUTO_INCREMENT,
    ProductName VARCHAR(100) NOT NULL,
    CategoryID INT,
    Price DECIMAL(10, 2) NOT NULL,
    Stock INT NOT NULL,
    CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (CategoryID) REFERENCES Categories(CategoryID)
);

-- Categories table
CREATE TABLE Categories (
    CategoryID INT PRIMARY KEY AUTO_INCREMENT,
    CategoryName VARCHAR(50) NOT NULL
);

-- Orders table
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY AUTO_INCREMENT,
    UserID INT,
    OrderDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    TotalAmount DECIMAL(10, 2),
    FOREIGN KEY (UserID) REFERENCES Users(UserID)
);

-- OrderItems table
CREATE TABLE OrderItems (
    OrderItemID INT PRIMARY KEY AUTO_INCREMENT,
    OrderID INT,
    ProductID INT,
    Quantity INT NOT NULL,
    Price DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

-- Payments table
CREATE TABLE Payments (
    PaymentID INT PRIMARY KEY AUTO_INCREMENT,
    OrderID INT,
    PaymentDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    Amount DECIMAL(10, 2) NOT NULL,
    PaymentMethod VARCHAR(50) NOT NULL,
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);

-- Reviews table
CREATE TABLE Reviews (
    ReviewID INT PRIMARY KEY AUTO_INCREMENT,
    ProductID INT,
    UserID INT,
    Rating INT NOT NULL CHECK (Rating BETWEEN 1 AND 5),
    Comment TEXT,
    ReviewDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID),
    FOREIGN KEY (UserID) REFERENCES Users(UserID)
);

-- Addresses table
CREATE TABLE Addresses (
    AddressID INT PRIMARY KEY AUTO_INCREMENT,
    UserID INT,
    AddressLine1 VARCHAR(255) NOT NULL,
    AddressLine2 VARCHAR(255),
    City VARCHAR(100) NOT NULL,
    State VARCHAR(100) NOT NULL,
    PostalCode VARCHAR(20) NOT NULL,
    Country VARCHAR(100) NOT NULL,
    FOREIGN KEY (UserID) REFERENCES Users(UserID)
);

-- Add a new product
DELIMITER //
CREATE PROCEDURE AddNewProduct(
    IN p_ProductName VARCHAR(100),
    IN p_CategoryID INT,
    IN p_Price DECIMAL(10, 2),
    IN p_Stock INT
)
BEGIN
    INSERT INTO Products (ProductName, CategoryID, Price, Stock)
    VALUES (p_ProductName, p_CategoryID, p_Price, p_Stock);
END //
DELIMITER ;

-- Place an order
DELIMITER //
CREATE PROCEDURE PlaceOrder(
    IN p_UserID INT,
    IN p_TotalAmount DECIMAL(10, 2),
    IN p_OrderItems JSON
)
BEGIN
    DECLARE lastOrderID INT;
    
    INSERT INTO Orders (UserID, TotalAmount)
    VALUES (p_UserID, p_TotalAmount);
    
    SET lastOrderID = LAST_INSERT_ID();
    
    CALL AddOrderItems(lastOrderID, p_OrderItems);
    
    CALL UpdateStock(p_OrderItems);
END //
DELIMITER ;

-- Update stock levels
DELIMITER //
CREATE PROCEDURE UpdateStock(
    IN p_OrderItems JSON
)
BEGIN
    DECLARE done INT DEFAULT 0;
    DECLARE productID INT;
    DECLARE quantity INT;
    DECLARE cur CURSOR FOR
        SELECT JSON_UNQUOTE(JSON_EXTRACT(value, '$.ProductID')),
               JSON_UNQUOTE(JSON_EXTRACT(value, '$.Quantity'))
        FROM JSON_TABLE(p_OrderItems, '$[*]' COLUMNS (value JSON PATH '$')) AS jt;

    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;

    OPEN cur;
    read_loop: LOOP
        FETCH cur INTO productID, quantity;
        IF done THEN
            LEAVE read_loop;
        END IF;
        UPDATE Products
        SET Stock = Stock - quantity
        WHERE ProductID = productID;
    END LOOP;

    CLOSE cur;
END //
DELIMITER ;

-- Calculate the total amount for an order
DELIMITER //
CREATE FUNCTION CalculateTotalOrderAmount(
    p_OrderID INT
)
RETURNS DECIMAL(10, 2)
DETERMINISTIC
BEGIN
    DECLARE total DECIMAL(10, 2);
    SELECT SUM(Price * Quantity) INTO total
    FROM OrderItems
    WHERE OrderID = p_OrderID;
    RETURN total;
END //
DELIMITER ;

-- Get the average rating for a product
DELIMITER //
CREATE FUNCTION GetProductRating(
    p_ProductID INT
)
RETURNS DECIMAL(3, 2)
DETERMINISTIC
BEGIN
    DECLARE avgRating DECIMAL(3, 2);
    SELECT AVG(Rating) INTO avgRating
    FROM Reviews
    WHERE ProductID = p_ProductID;
    RETURN avgRating;
END //
DELIMITER ;

-- Process orders using a cursor
DELIMITER //
CREATE PROCEDURE OrderProcessingCursor()
BEGIN
    DECLARE done INT DEFAULT 0;
    DECLARE orderID INT;
    DECLARE cur CURSOR FOR
        SELECT OrderID
        FROM Orders
        WHERE OrderDate < NOW() - INTERVAL 1 DAY AND Status = 'Pending';

    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;

    OPEN cur;
    read_loop: LOOP
        FETCH cur INTO orderID;
        IF done THEN
            LEAVE read_loop;
        END IF;
        
        -- Process the order
        CALL ProcessOrder(orderID);
    END LOOP;

    CLOSE cur;
END //
DELIMITER ;

DELIMITER //

CREATE PROCEDURE GetUserOrderHistory(IN userId INT)
BEGIN
    SELECT 
        o.OrderID,
        o.OrderDate,
        oi.ProductID,
        p.ProductName,
        oi.Quantity,
        oi.Price,
        (oi.Quantity * oi.Price) AS TotalPrice
    FROM Orders o
    JOIN OrderItems oi ON o.OrderID = oi.OrderID
    JOIN Products p ON oi.ProductID = p.ProductID
    WHERE o.UserID = userId
    ORDER BY o.OrderDate DESC;
END //

DELIMITER ;

DELIMITER //

CREATE FUNCTION GetAverageRating(productId INT) 
RETURNS DECIMAL(3, 2)
DETERMINISTIC
BEGIN
    DECLARE avgRating DECIMAL(3, 2);

    SELECT AVG(Rating) INTO avgRating
    FROM Reviews
    WHERE ProductID = productId;

    RETURN IFNULL(avgRating, 0.00);
END //

DELIMITER ;
DELIMITER //

CREATE PROCEDURE UpdateProductStock(IN productId INT, IN newStock INT)
BEGIN
    UPDATE Products
    SET Stock = newStock
    WHERE ProductID = productId;
END //

DELIMITER ;
DELIMITER //

CREATE PROCEDURE AddNewProduct(
    IN pName VARCHAR(100), 
    IN category INT, 
    IN pPrice DECIMAL(10, 2), 
    IN pStock INT)
BEGIN
    INSERT INTO Products (ProductName, CategoryID, Price, Stock)
    VALUES (pName, category, pPrice, pStock);
END //

DELIMITER ;
DELIMITER //

CREATE PROCEDURE GetRecentOrders(IN days INT)
BEGIN
    SELECT 
        o.OrderID,
        o.UserID,
        o.OrderDate,
        o.TotalAmount
    FROM Orders o
    WHERE o.OrderDate >= NOW() - INTERVAL days DAY
    ORDER BY o.OrderDate DESC;
END //

DELIMITER ;
