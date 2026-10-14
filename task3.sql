
USE ProductDB;

CREATE TABLE Seller (
    Seller_ID VARCHAR(10) PRIMARY KEY,
    Seller_Name VARCHAR(50) NOT NULL,
    Email VARCHAR(100) NOT NULL UNIQUE,
    Phone VARCHAR(15) UNIQUE,
    Address VARCHAR(150)
);

CREATE TABLE Inventory (
    Inventory_ID INT PRIMARY KEY,
    Product_ID INT NOT NULL,
    Seller_ID VARCHAR(10) NOT NULL,
    Stock_Quantity INT NOT NULL CHECK (Stock_Quantity >= 0),
    Stock_Status VARCHAR(20) NOT NULL,
    Last_Updated DATE,

    FOREIGN KEY (Product_ID)
        REFERENCES Product(Product_ID),

    FOREIGN KEY (Seller_ID)
        REFERENCES Seller(Seller_ID),

    UNIQUE (Product_ID, Seller_ID),

    CHECK (Stock_Status IN (
        'Available',
        'Low Stock',
        'Out of Stock'
    ))
);

INSERT INTO Seller
(Seller_ID, Seller_Name, Email, Phone, Address)
VALUES
('S101', 'ABC Traders', 'abc@gmail.com', '9876543210', 'Chennai'),
('S102', 'Global Suppliers', 'global@gmail.com', '9876543211', 'Madurai'),
('S103', 'Smart Distributors', 'smart@gmail.com', '9876543212', 'Coimbatore'),
('S104', 'Tech World', 'tech@gmail.com', '9876543213', 'Trichy');

SELECT * FROM Seller;

INSERT INTO Seller
VALUES (
    'S105',
    'Fresh Supplies',
    'fresh@gmail.com',
    '9876543214',
    'Salem'
);

INSERT INTO Inventory
VALUES (
    11, 102, 'S101', 10,
    'Available', '2026-10-13'
);

SELECT
    S.Seller_Name,
    P.Product_ID,
    P.Product_Name,
    I.Stock_Quantity
FROM Seller S
JOIN Inventory I
    ON S.Seller_ID = I.Seller_ID
JOIN Product P
    ON I.Product_ID = P.Product_ID
ORDER BY S.Seller_Name;

SELECT
    S.Seller_Name,
    COUNT(DISTINCT I.Product_ID) AS Total_Products
FROM Seller S
LEFT JOIN Inventory I
    ON S.Seller_ID = I.Seller_ID
GROUP BY S.Seller_ID, S.Seller_Name;

UPDATE Seller
SET Phone = '9123456780',
    Address = 'Chennai'
WHERE Seller_ID = 'S101';

SELECT Product_ID, Stock_Quantity, Stock_Status
FROM Inventory
WHERE Stock_Quantity > 0;

SELECT Product_ID, Seller_ID, Stock_Quantity
FROM Inventory
WHERE Stock_Quantity = 0;

SELECT Product_ID, Seller_ID, Stock_Quantity
FROM Inventory
WHERE Stock_Quantity < 10;

UPDATE Inventory
SET Stock_Quantity = Stock_Quantity + 20,
    Stock_Status = 'Available',
    Last_Updated = '2026-10-13'
WHERE Inventory_ID = 4;

DELETE FROM Inventory
WHERE Inventory_ID = 10;

SELECT
    S.Seller_Name,
    COUNT(DISTINCT I.Product_ID) AS Total_Products,
    COALESCE(
        SUM(I.Stock_Quantity), 0
    ) AS Available_Stock
FROM Seller S
LEFT JOIN Inventory I
    ON S.Seller_ID = I.Seller_ID
GROUP BY S.Seller_ID, S.Seller_Name;

SELECT
    P.Product_Name,
    S.Seller_Name,
    I.Stock_Quantity,
    I.Stock_Status
FROM Inventory I
JOIN Product P
    ON I.Product_ID = P.Product_ID
JOIN Seller S
    ON I.Seller_ID = S.Seller_ID;

SELECT COUNT(DISTINCT Product_ID)
    AS Total_Products_Available
FROM Inventory
WHERE Stock_Quantity > 0;


SELECT
    P.Product_ID,
    P.Product_Name
FROM Product P
JOIN Inventory I
    ON P.Product_ID = I.Product_ID
GROUP BY P.Product_ID, P.Product_Name
HAVING SUM(I.Stock_Quantity) = 0;

SELECT
    P.Product_Name,
    I.Stock_Quantity,
    S.Seller_Name
FROM Inventory I
JOIN Product P
    ON I.Product_ID = P.Product_ID
JOIN Seller S
    ON I.Seller_ID = S.Seller_ID
WHERE I.Stock_Quantity = (
    SELECT MAX(Stock_Quantity)
    FROM Inventory
);

SELECT AVG(Stock_Quantity)
    AS Average_Inventory_Quantity
FROM Inventory;

SELECT
    P.Product_ID,
    P.Product_Name,
    SUM(I.Stock_Quantity) AS Total_Stock
FROM Product P
JOIN Inventory I
    ON P.Product_ID = I.Product_ID
GROUP BY P.Product_ID, P.Product_Name;














