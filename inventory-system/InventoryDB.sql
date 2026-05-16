# InventoryDB.sql

-- CREATE DATABASE
CREATE DATABASE IF NOT EXISTS InventoryDB;

USE InventoryDB;

-- DROP OLD TABLES (SAFE RESET)
DROP TABLE IF EXISTS sales;
DROP TABLE IF EXISTS product;
DROP TABLE IF EXISTS categories;
DROP TABLE IF EXISTS users;

-- =============================
-- USERS TABLE
-- =============================
CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(100) NOT NULL,
    role ENUM('Admin', 'Staff') DEFAULT 'Staff'
);

-- =============================
-- CATEGORIES TABLE
-- =============================
CREATE TABLE categories (
    Category_id INT AUTO_INCREMENT PRIMARY KEY,
    CategoryName VARCHAR(100) NOT NULL UNIQUE
);

-- =============================
-- PRODUCT TABLE
-- =============================
CREATE TABLE product (
    Product_id INT AUTO_INCREMENT PRIMARY KEY,
    ProductName VARCHAR(100) NOT NULL,
    Category_id INT,
    Price DECIMAL(10,2) NOT NULL,
    Stock INT NOT NULL,

    FOREIGN KEY (Category_id)
    REFERENCES categories(Category_id)
    ON DELETE SET NULL
    ON UPDATE CASCADE
);

-- =============================
-- SALES TABLE
-- =============================
CREATE TABLE sales (
    Sale_id INT AUTO_INCREMENT PRIMARY KEY,
    Product_id INT,
    Quantity_Sold INT,
    Sale_Date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (Product_id)
    REFERENCES product(Product_id)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

-- =============================
-- INSERT ADMIN USER
-- =============================
INSERT INTO users (username, password, role)
VALUES ('admin', '1234', 'Admin');
INSERT IGNORE INTO users (username, password, role)
VALUES ('admin', '1234', 'Admin');
SELECT * FROM users;



-- =============================
-- INSERT SAMPLE CATEGORIES
-- =============================
INSERT IGNORE INTO product
(ProductName, Category_id, Price, Stock)
VALUES
('iPhone 15', 1, 79999.00, 10),
('HP Laptop', 2, 60000.00, 5),
('Nike Shoes', 3, 8999.00, 15),
('Sony Headphones', 4, 29999.00, 8);


-- =============================
-- INSERT SAMPLE PRODUCTS
-- =============================
INSERT INTO product
(ProductName, Category_id, Price, Stock)
VALUES
('iPhone 15', 1, 79999.00, 10),
('HP Laptop', 2, 60000.00, 5),
('Nike Shoes', 3, 8999.00, 15),
('Sony Headphones', 4, 29999.00, 8);

-- =============================
-- VIEW DATA
-- =============================
SELECT * FROM users;
SELECT * FROM categories;
SELECT * FROM product;
SELECT * FROM sales;

