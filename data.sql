USE OnlineRetailDB;

-- Insert Customers
INSERT INTO Customers (first_name, last_name, email, phone, address, city, state, zip_code) VALUES
('John', 'Doe', 'john.doe@example.com', '123-456-7890', '123 Elm St', 'Springfield', 'IL', '62704'),
('Jane', 'Smith', 'jane.smith@example.com', '987-654-3210', '456 Oak Ave', 'New York', 'NY', '10001'),
('Michael', 'Johnson', 'michael.j@example.com', '555-123-4567', '789 Pine Rd', 'Los Angeles', 'CA', '90001');

-- Insert Products
INSERT INTO Products (name, description, price, stock_quantity, category) VALUES
('Laptop', 'High-performance laptop', 1200.00, 50, 'Electronics'),
('Smartphone', 'Latest model smartphone', 800.00, 100, 'Electronics'),
('Desk Chair', 'Ergonomic office chair', 150.00, 30, 'Furniture'),
('Coffee Maker', 'Programmable coffee maker', 75.00, 40, 'Appliances'),
('Headphones', 'Noise-cancelling headphones', 200.00, 60, 'Electronics');

-- Insert Orders
INSERT INTO Orders (customer_id, status, total_amount) VALUES
(1, 'Delivered', 1275.00),
(2, 'Shipped', 200.00),
(1, 'Pending', 800.00);

-- Insert Order Items
-- Order 1: 1 Laptop + 1 Coffee Maker
INSERT INTO Order_Items (order_id, product_id, quantity, unit_price) VALUES
(1, 1, 1, 1200.00),
(1, 4, 1, 75.00);

-- Order 2: 1 Headphones
INSERT INTO Order_Items (order_id, product_id, quantity, unit_price) VALUES
(2, 5, 1, 200.00);

-- Order 3: 1 Smartphone
INSERT INTO Order_Items (order_id, product_id, quantity, unit_price) VALUES
(3, 2, 1, 800.00);

-- Insert Payments
INSERT INTO Payments (order_id, amount, payment_method, status) VALUES
(1, 1275.00, 'Credit Card', 'Success'),
(2, 200.00, 'PayPal', 'Success');
