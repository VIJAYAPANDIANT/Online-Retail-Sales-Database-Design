# 🛒 Online Retail Sales Database Design

![SQL](https://img.shields.io/badge/SQL-MySQL-4479A1?style=for-the-badge&logo=mysql&logoColor=white)
![Database](https://img.shields.io/badge/Database-Relational-blue?style=for-the-badge&logo=databricks&logoColor=white)
![Normalization](https://img.shields.io/badge/Normalization-3NF-success?style=for-the-badge)
![License](https://img.shields.io/badge/License-MIT-green?style=for-the-badge)

## 📌 Project Overview

This project implements a **Normalized 3rd Normal Form (3NF)** relational database for an online retail platform. It is engineered to handle core e-commerce functionalities such as managing customers, products, orders, and payments with high integrity and minimal redundancy.

---

## 🗺️ Database Architecture & Documentation

The database is built on a highly interconnected schema that ensures seamless data flow between core modules.

> [!TIP]
> **Project Resources:**
> - 🔗 **[View Database Schema Diagram](https://drive.google.com/file/d/1GTRryWbzC-ndP1cEQBXxmjFuSXKXLK8Q/view?usp=sharing)**
> - 📂 **[View Project Documentation](https://drive.google.com/file/d/1IDZ16cHi-L6vEmd5wcg24QTdLVhyAO9P/view?usp=sharing)**

---

## 📂 File Structure

| File | Description |
| :--- | :--- |
| **`schema.sql`** | Defines the database structure, tables, and relationships. |
| **`data.sql`** | Populates the tables with comprehensive sample data. |
| **`queries.sql`** | Contains analytical SQL queries and Views for reporting. |
| **`full_setup.sql`** | A unified script combining schema, data, and queries. |
| **`setup_and_test.bat`** | Windows Batch script for one-click database setup. |
| **`run_retail_db.ps1`** | PowerShell script for automated setup and testing. |

---

## 🗄️ Database Schema Reference

The database consists of 5 core tables designed for efficiency and scalability.

### 1. Customers
Stores user profiles and contact information.
- `customer_id` (PK): Unique identifier.
- `email` (Unique): Ensures no duplicate accounts.

### 2. Products
Manages inventory and pricing details.
- `product_id` (PK): Unique identifier.
- `stock_quantity`: Real-time inventory tracking.

### 3. Orders
Tracks customer purchases and shipment status.
- `order_id` (PK): Unique identifier.
- `status`: Tracks lifecycle (`Pending`, `Shipped`, `Delivered`, `Cancelled`).

### 4. Order_Items
The junction table linking orders and products (Many-to-Many).
- `quantity`: Items per order.
- `unit_price`: Captures price at the time of purchase.

### 5. Payments
Handles transaction records for every order.
- `payment_method`: Supports `Credit Card`, `PayPal`, `Bank Transfer`.

---

## 🚀 Setup and Installation

### Option 1: Automated Setup (Recommended)

**For Windows Users:**
1. Right-click **`run_retail_db.ps1`** and select "Run with PowerShell".
2. Or simply run the **`setup_and_test.bat`** file.
3. Follow the prompts to enter your MySQL credentials.

### Option 2: Manual Setup

1. **Login to MySQL:**
   ```bash
   mysql -u root -p
   ```
2. **Execute the Setup Script:**
   ```sql
   SOURCE full_setup.sql;
   ```

---

## 📊 Analytical Insights

The project includes pre-configured **SQL Views** to provide instant business intelligence:

- **`ProductSales`**: Summarizes revenue and units sold per product.
- **`CustomerSpending`**: Identifies top customers by total expenditure.

```sql
-- Example: View top selling products
SELECT * FROM ProductSales ORDER BY total_revenue DESC;
```

---

## 📜 License & Author

Design and Implementation by **VIJAYAPANDIAN.T**.
This project is licensed under the **MIT License**. Feel free to use it for educational or commercial purposes.
