-- ==========================================
-- Online Retail Database - Full Setup Script
-- ==========================================

-- 1. CLEANUP & INIT
-- ------------------------------------------
DROP DATABASE IF EXISTS OnlineRetailDB;

CREATE DATABASE OnlineRetailDB;

USE OnlineRetailDB;

-- 2. SCHEMA CREATION
-- ------------------------------------------
-- Customers Table
CREATE TABLE Customers (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(20),
    address VARCHAR(255),
    city VARCHAR(50),
    state VARCHAR(50),
    zip_code VARCHAR(20),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Products Table
CREATE TABLE Products (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    description TEXT,
    price DECIMAL(10, 2) NOT NULL,
    stock_quantity INT NOT NULL DEFAULT 0,
    category VARCHAR(50),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Orders Table
CREATE TABLE Orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT NOT NULL,
    order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    status ENUM(
        'Pending',
        'Shipped',
        'Delivered',
        'Cancelled'
    ) DEFAULT 'Pending',
    total_amount DECIMAL(10, 2),
    FOREIGN KEY (customer_id) REFERENCES Customers (customer_id) ON DELETE CASCADE
);

-- Order_Items Table
CREATE TABLE Order_Items (
    order_item_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL CHECK (quantity > 0),
    unit_price DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES Orders (order_id) ON DELETE CASCADE,
    FOREIGN KEY (product_id) REFERENCES Products (product_id) ON DELETE CASCADE
);

-- Payments Table
CREATE TABLE Payments (
    payment_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT NOT NULL,
    payment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    amount DECIMAL(10, 2) NOT NULL,
    payment_method ENUM(
        'Credit Card',
        'PayPal',
        'Bank Transfer'
    ) NOT NULL,
    status ENUM('Success', 'Failed') DEFAULT 'Success',
    FOREIGN KEY (order_id) REFERENCES Orders (order_id) ON DELETE CASCADE
);

-- 3. DATA POPULATION
-- ------------------------------------------
-- Insert Customers
INSERT INTO
    Customers (
        first_name,
        last_name,
        email,
        phone,
        address,
        city,
        state,
        zip_code
    )
VALUES (
        'John',
        'Doe',
        'john.doe@example.com',
        '123-456-7890',
        '123 Elm St',
        'Springfield',
        'IL',
        '62704'
    ),
    (
        'Jane',
        'Smith',
        'jane.smith@example.com',
        '987-654-3210',
        '456 Oak Ave',
        'New York',
        'NY',
        '10001'
    ),
    (
        'Michael',
        'Johnson',
        'michael.j@example.com',
        '555-123-4567',
        '789 Pine Rd',
        'Los Angeles',
        'CA',
        '90001'
    );

-- Insert Products
INSERT INTO
    Products (
        name,
        description,
        price,
        stock_quantity,
        category
    )
VALUES (
        'Laptop',
        'High-performance laptop',
        1200.00,
        50,
        'Electronics'
    ),
    (
        'Smartphone',
        'Latest model smartphone',
        800.00,
        100,
        'Electronics'
    ),
    (
        'Desk Chair',
        'Ergonomic office chair',
        150.00,
        30,
        'Furniture'
    ),
    (
        'Coffee Maker',
        'Programmable coffee maker',
        75.00,
        40,
        'Appliances'
    ),
    (
        'Headphones',
        'Noise-cancelling headphones',
        200.00,
        60,
        'Electronics'
    );

-- Insert Orders
INSERT INTO
    Orders (
        customer_id,
        status,
        total_amount
    )
VALUES (1, 'Delivered', 1275.00),
    (2, 'Shipped', 200.00),
    (1, 'Pending', 800.00);

-- Insert Order Items
INSERT INTO
    Order_Items (
        order_id,
        product_id,
        quantity,
        unit_price
    )
VALUES (1, 1, 1, 1200.00), -- Laptop
    (1, 4, 1, 75.00), -- Coffee Maker
    (2, 5, 1, 200.00), -- Headphones
    (3, 2, 1, 800.00);
-- Smartphone

-- Insert Payments
INSERT INTO
    Payments (
        order_id,
        amount,
        payment_method,
        status
    )
VALUES (
        1,
        1275.00,
        'Credit Card',
        'Success'
    ),
    (
        2,
        200.00,
        'PayPal',
        'Success'
    );

-- 4. QUERIES & VIEWS
-- ------------------------------------------
-- 1. JOIN Query
SELECT
    o.order_id,
    c.first_name,
    c.last_name,
    p.name AS product_name,
    oi.quantity,
    oi.unit_price,
    (oi.quantity * oi.unit_price) AS total_item_price,
    o.order_date
FROM
    Orders o
    JOIN Customers c ON o.customer_id = c.customer_id
    JOIN Order_Items oi ON o.order_id = oi.order_id
    JOIN Products p ON oi.product_id = p.product_id
ORDER BY o.order_date DESC;

-- 2. View: Product Sales
CREATE OR REPLACE VIEW ProductSales AS
SELECT
    p.product_id,
    p.name AS product_name,
    SUM(oi.quantity) AS total_units_sold,
    SUM(oi.quantity * oi.unit_price) AS total_revenue
FROM Products p
    JOIN Order_Items oi ON p.product_id = oi.product_id
GROUP BY
    p.product_id,
    p.name
ORDER BY total_revenue DESC;

-- 3. View: Customer Spending
CREATE OR REPLACE VIEW CustomerSpending AS
SELECT
    c.customer_id,
    CONCAT(
        c.first_name,
        ' ',
        c.last_name
    ) AS full_name,
    COUNT(DISTINCT o.order_id) AS total_orders,
    SUM(o.total_amount) AS total_spent
FROM Customers c
    JOIN Orders o ON c.customer_id = o.customer_id
WHERE
    o.status != 'Cancelled'
GROUP BY
    c.customer_id,
    full_name
ORDER BY total_spent DESC;

-- Show results from views
SELECT '--- Product Sales Report ---' AS Report_Title;

SELECT * FROM ProductSales;

SELECT '--- Customer Spending Report ---' AS Report_Title;

SELECT * FROM CustomerSpending;