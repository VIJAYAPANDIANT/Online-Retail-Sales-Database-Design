USE OnlineRetailDB;

-- 1. JOIN Query: Retrieve full order details (Customer Name, Product Name, Quantity, Price)
SELECT 
    o.order_id,
    c.first_name,
    c.last_name,
    p.name AS product_name,
    oi.quantity,
    oi.unit_price,
    (oi.quantity * oi.unit_price) AS total_item_price,
    o.order_date
FROM Orders o
JOIN Customers c ON o.customer_id = c.customer_id
JOIN Order_Items oi ON o.order_id = oi.order_id
JOIN Products p ON oi.product_id = p.product_id
ORDER BY o.order_date DESC;

-- 2. View: Total Sales by Product
CREATE OR REPLACE VIEW ProductSales AS
SELECT 
    p.product_id,
    p.name AS product_name,
    SUM(oi.quantity) AS total_units_sold,
    SUM(oi.quantity * oi.unit_price) AS total_revenue
FROM Products p
JOIN Order_Items oi ON p.product_id = oi.product_id
GROUP BY p.product_id, p.name
ORDER BY total_revenue DESC;

-- 3. View: Customer Spending (Top Customers)
CREATE OR REPLACE VIEW CustomerSpending AS
SELECT 
    c.customer_id,
    CONCAT(c.first_name, ' ', c.last_name) AS full_name,
    COUNT(DISTINCT o.order_id) AS total_orders,
    SUM(o.total_amount) AS total_spent
FROM Customers c
JOIN Orders o ON c.customer_id = o.customer_id
WHERE o.status != 'Cancelled'
GROUP BY c.customer_id, full_name
ORDER BY total_spent DESC;

-- Example: Selecting from the views
-- SELECT * FROM ProductSales;
-- SELECT * FROM CustomerSpending;
