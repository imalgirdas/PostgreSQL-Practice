-- 00_setup.sql
-- Sample database for "150 PostgreSQL Practice Problems"
-- Run once:  psql -U postgres -d postgres -c "CREATE DATABASE sql_practice;"
--            psql -U postgres -d sql_practice -f 00_setup.sql

DROP TABLE IF EXISTS payments, order_items, orders, products, customers, employees, departments CASCADE;

CREATE TABLE departments (
    dept_id     INT PRIMARY KEY,
    dept_name   TEXT NOT NULL,
    location    TEXT NOT NULL
);

CREATE TABLE employees (
    emp_id      INT PRIMARY KEY,
    first_name  TEXT NOT NULL,
    last_name   TEXT NOT NULL,
    email       TEXT NOT NULL,
    dept_id     INT REFERENCES departments(dept_id),
    manager_id  INT REFERENCES employees(emp_id),
    job_title   TEXT NOT NULL,
    salary      NUMERIC(8,2) NOT NULL,
    hire_date   DATE NOT NULL,
    city        TEXT NOT NULL
);

CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    first_name  TEXT NOT NULL,
    last_name   TEXT NOT NULL,
    email       TEXT NOT NULL,
    phone       TEXT,
    city        TEXT NOT NULL,
    country     TEXT NOT NULL,
    signup_date DATE NOT NULL
);

CREATE TABLE products (
    product_id   INT PRIMARY KEY,
    product_name TEXT NOT NULL,
    category     TEXT NOT NULL,
    price        NUMERIC(8,2) NOT NULL,
    stock        INT NOT NULL
);

CREATE TABLE orders (
    order_id     INT PRIMARY KEY,
    customer_id  INT NOT NULL REFERENCES customers(customer_id),
    order_date   DATE NOT NULL,
    shipped_date DATE,
    status       TEXT NOT NULL,
    ship_city    TEXT NOT NULL
);

CREATE TABLE order_items (
    order_item_id INT PRIMARY KEY,
    order_id      INT NOT NULL REFERENCES orders(order_id) ON DELETE CASCADE,
    product_id    INT NOT NULL REFERENCES products(product_id),
    quantity      INT NOT NULL,
    unit_price    NUMERIC(8,2) NOT NULL
);

CREATE TABLE payments (
    payment_id   INT PRIMARY KEY,
    order_id     INT NOT NULL REFERENCES orders(order_id) ON DELETE CASCADE,
    payment_date DATE NOT NULL,
    amount       NUMERIC(10,2) NOT NULL,
    method       TEXT NOT NULL
);

INSERT INTO departments VALUES
    (1, 'Sales', 'Vilnius'),
    (2, 'Finance', 'Kaunas'),
    (3, 'IT', 'Vilnius'),
    (4, 'Marketing', 'Klaipėda'),
    (5, 'HR', 'Kaunas'),
    (6, 'Legal', 'Vilnius');

INSERT INTO employees VALUES
    (1, 'Rūta', 'Kazlauskienė', 'ruta.kazlauskiene@company.lt', NULL, NULL, 'CEO', 9500, '2015-03-01', 'Vilnius'),
    (2, 'Tomas', 'Petrauskas', 'tomas.petrauskas@company.lt', 1, 1, 'Sales Director', 6800, '2016-06-15', 'Vilnius'),
    (3, 'Ieva', 'Jankauskaitė', 'ieva.jankauskaite@company.lt', 2, 1, 'Finance Director', 7200, '2017-01-10', 'Kaunas'),
    (4, 'Mantas', 'Stankevičius', 'mantas.stankevicius@company.lt', 3, 1, 'IT Director', 7800, '2016-09-01', 'Vilnius'),
    (5, 'Greta', 'Vasiliauskaitė', 'greta.vasiliauskaite@company.lt', 4, 1, 'Marketing Director', 6500, '2018-04-23', 'Klaipėda'),
    (6, 'Lukas', 'Žukauskas', 'lukas.zukauskas@company.lt', 5, 1, 'HR Director', 6000, '2019-02-11', 'Kaunas'),
    (7, 'Jonas', 'Butkus', 'jonas.butkus@company.lt', 1, 2, 'Sales Manager', 4800, '2018-08-01', 'Vilnius'),
    (8, 'Agnė', 'Paulauskaitė', 'agne.paulauskaite@company.lt', 1, 7, 'Sales Representative', 3200, '2021-05-17', 'Kaunas'),
    (9, 'Paulius', 'Urbonas', 'paulius.urbonas@company.lt', 1, 7, 'Sales Representative', 3200, '2022-03-01', 'Vilnius'),
    (10, 'Emilija', 'Kavaliauskaitė', 'emilija.kavaliauskaite@company.lt', 1, 7, 'Sales Representative', 3400, '2020-11-02', 'Klaipėda'),
    (11, 'Domas', 'Kazlauskas', 'domas.kazlauskas@company.lt', 2, 3, 'Senior Accountant', 4600, '2019-07-15', 'Kaunas'),
    (12, 'Laura', 'Navickaitė', 'laura.navickaite@company.lt', 2, 11, 'Accountant', 3500, '2022-09-05', 'Kaunas'),
    (13, 'Rokas', 'Ramanauskas', 'rokas.ramanauskas@company.lt', 2, 11, 'Payroll Specialist', 3600, '2021-01-18', 'Kaunas'),
    (14, 'Austėja', 'Mockutė', 'austeja.mockute@company.lt', 3, 4, 'Data Analyst', 4200, '2021-10-04', 'Vilnius'),
    (15, 'Matas', 'Šimkus', 'matas.simkus@company.lt', 3, 4, 'Software Engineer', 5600, '2020-02-17', 'Vilnius'),
    (16, 'Gabija', 'Balčiūnaitė', 'gabija.balciunaite@company.lt', 3, 15, 'Software Engineer', 5200, '2022-06-20', 'Kaunas'),
    (17, 'Karolis', 'Jonaitis', 'karolis.jonaitis@company.lt', 3, 15, 'Junior Developer', 3000, '2024-01-08', 'Vilnius'),
    (18, 'Ugnė', 'Lukoševičiūtė', 'ugne.lukoseviciute@company.lt', 4, 5, 'Content Specialist', 3300, '2023-03-13', 'Klaipėda'),
    (19, 'Deividas', 'Bružas', 'deividas.bruzas@company.lt', 4, 5, 'SEO Specialist', 3700, '2022-11-21', 'Vilnius'),
    (20, 'Viktorija', 'Žemaitytė', 'viktorija.zemaityte@company.lt', 5, 6, 'HR Specialist', 3400, '2023-08-28', 'Kaunas');

INSERT INTO customers VALUES
    (1, 'Andrius', 'Kairys', 'andrius.kairys@gmail.com', '+370 612 34567', 'Vilnius', 'Lithuania', '2023-02-14'),
    (2, 'Simona', 'Kriaučiūnė', 'simona.k@yahoo.com', '+370 698 11223', 'Kaunas', 'Lithuania', '2023-03-02'),
    (3, 'Marek', 'Nowak', 'marek.nowak@wp.pl', '+48 501 222 333', 'Warsaw', 'Poland', '2023-04-19'),
    (4, 'Anna', 'Ozola', 'anna.ozola@inbox.lv', NULL, 'Riga', 'Latvia', '2023-05-07'),
    (5, 'Kristjan', 'Tamm', 'kristjan.tamm@gmail.com', '+372 5123 4567', 'Tallinn', 'Estonia', '2023-06-21'),
    (6, 'Eglė', 'Kurtinaitienė', 'egle.kurt@gmail.com', '+370 655 99887', 'Klaipėda', 'Lithuania', '2023-08-30'),
    (7, 'Jan', 'Kowalski', 'jan.kowalski@onet.pl', NULL, 'Krakow', 'Poland', '2023-10-11'),
    (8, 'Liga', 'Berzina', 'liga.berzina@gmail.com', '+371 2612 3456', 'Riga', 'Latvia', '2024-01-15'),
    (9, 'Darius', 'Kuprys', 'darius.kuprys@outlook.com', '+370 611 44556', 'Šiauliai', 'Lithuania', '2024-02-03'),
    (10, 'Kaisa', 'Saar', 'kaisa.saar@outlook.com', NULL, 'Tartu', 'Estonia', '2024-03-18'),
    (11, 'Vaida', 'Kalvaitienė', 'vaida.kalv@gmail.com', '+370 677 12121', 'Vilnius', 'Lithuania', '2024-05-09'),
    (12, 'Piotr', 'Zielinski', 'piotr.z@gmail.com', '+48 600 111 222', 'Gdansk', 'Poland', '2024-07-22'),
    (13, 'Ruta', 'Kalnina', 'ruta.kalnina@inbox.lv', NULL, 'Riga', 'Latvia', '2024-09-05'),
    (14, 'Kęstutis', 'Valys', 'kestutis.valys@gmail.com', '+370 699 30303', 'Panevėžys', 'Lithuania', '2025-01-12'),
    (15, 'Mari', 'Kask', 'mari.kask@gmail.com', '+372 5333 2211', 'Tallinn', 'Estonia', '2025-06-30'),
    (16, 'Andrius', 'Kairys', 'Andrius.Kairys@Gmail.com', '+370 612 34567', 'Vilnius', 'Lithuania', '2025-08-02');

INSERT INTO products VALUES
    (1, 'Laptop Pro 14', 'Electronics', 1299.00, 8),
    (2, 'Phone Pro 15', 'Electronics', 999.00, 12),
    (3, 'Monitor 27', 'Electronics', 289.00, 20),
    (4, 'Wireless Mouse', 'Accessories', 29.90, 150),
    (5, 'Mechanical Keyboard', 'Accessories', 89.00, 60),
    (6, 'USB-C Hub', 'Accessories', 45.50, 0),
    (7, 'Headphones X2', 'Electronics', 159.00, 35),
    (8, 'Office Chair', 'Furniture', 249.00, 15),
    (9, 'Standing Desk', 'Furniture', 499.00, 6),
    (10, 'Desk Lamp', 'Furniture', 39.90, 40),
    (11, 'Notebook A5', 'Stationery', 4.50, 500),
    (12, 'Gel Pen Set', 'Stationery', 7.90, 300),
    (13, 'Webcam HD 1080', 'Electronics', 79.00, 25),
    (14, 'Printer Paper A4', 'Stationery', 6.20, 0);

INSERT INTO orders VALUES
    (1, 1, '2024-02-10', '2024-02-12', 'Delivered', 'Vilnius'),
    (2, 1, '2024-02-19', '2024-02-25', 'Delivered', 'Vilnius'),
    (3, 3, '2024-02-21', '2024-02-27', 'Shipped', 'Warsaw'),
    (4, 9, '2024-02-22', '2024-02-23', 'Delivered', 'Šiauliai'),
    (5, 3, '2024-03-02', NULL, 'Cancelled', 'Warsaw'),
    (6, 6, '2024-03-03', '2024-03-06', 'Shipped', 'Klaipėda'),
    (7, 5, '2024-03-06', '2024-03-07', 'Delivered', 'Tallinn'),
    (8, 9, '2024-03-14', NULL, 'Cancelled', 'Šiauliai'),
    (9, 3, '2024-03-17', '2024-03-21', 'Delivered', 'Warsaw'),
    (10, 4, '2024-03-31', NULL, 'Cancelled', 'Riga'),
    (11, 4, '2024-04-04', '2024-04-06', 'Delivered', 'Riga'),
    (12, 2, '2024-04-08', '2024-04-10', 'Delivered', 'Kaunas'),
    (13, 3, '2024-05-02', '2024-05-07', 'Delivered', 'Warsaw'),
    (14, 8, '2024-05-08', '2024-05-12', 'Shipped', 'Riga'),
    (15, 5, '2024-05-18', '2024-05-20', 'Delivered', 'Tallinn'),
    (16, 7, '2024-05-29', '2024-06-03', 'Delivered', 'Krakow'),
    (17, 1, '2024-06-05', NULL, 'Cancelled', 'Vilnius'),
    (18, 3, '2024-07-06', '2024-07-07', 'Delivered', 'Warsaw'),
    (19, 5, '2024-08-09', '2024-08-10', 'Delivered', 'Tallinn'),
    (20, 6, '2024-08-16', '2024-08-21', 'Delivered', 'Klaipėda'),
    (21, 4, '2024-08-18', '2024-08-20', 'Delivered', 'Riga'),
    (22, 2, '2024-09-05', '2024-09-07', 'Delivered', 'Kaunas'),
    (23, 1, '2024-10-25', '2024-10-28', 'Delivered', 'Vilnius'),
    (24, 1, '2024-11-13', '2024-11-17', 'Delivered', 'Vilnius'),
    (25, 12, '2024-11-29', '2024-12-05', 'Delivered', 'Gdansk'),
    (26, 8, '2025-01-11', '2025-01-13', 'Delivered', 'Riga'),
    (27, 4, '2025-02-10', '2025-02-16', 'Returned', 'Riga'),
    (28, 6, '2025-02-12', '2025-02-18', 'Delivered', 'Klaipėda'),
    (29, 6, '2025-03-06', '2025-03-07', 'Delivered', 'Klaipėda'),
    (30, 2, '2025-03-07', NULL, 'Cancelled', 'Kaunas'),
    (31, 2, '2025-03-12', '2025-03-15', 'Delivered', 'Kaunas'),
    (32, 8, '2025-03-22', '2025-03-27', 'Shipped', 'Riga'),
    (33, 2, '2025-06-05', '2025-06-09', 'Delivered', 'Kaunas'),
    (34, 1, '2025-07-04', '2025-07-05', 'Delivered', 'Vilnius'),
    (35, 1, '2025-07-09', '2025-07-10', 'Delivered', 'Vilnius'),
    (36, 12, '2025-07-20', '2025-07-23', 'Delivered', 'Gdansk'),
    (37, 5, '2025-07-26', '2025-07-31', 'Shipped', 'Tallinn'),
    (38, 5, '2025-07-29', '2025-08-02', 'Delivered', 'Tallinn'),
    (39, 1, '2025-08-04', '2025-08-05', 'Delivered', 'Vilnius'),
    (40, 9, '2025-08-09', '2025-08-13', 'Delivered', 'Šiauliai'),
    (41, 5, '2025-08-15', '2025-08-18', 'Delivered', 'Tallinn'),
    (42, 3, '2025-08-21', '2025-08-27', 'Delivered', 'Warsaw'),
    (43, 14, '2025-08-21', '2025-08-23', 'Delivered', 'Panevėžys'),
    (44, 9, '2025-08-24', '2025-08-30', 'Shipped', 'Šiauliai'),
    (45, 3, '2025-10-06', '2025-10-12', 'Delivered', 'Warsaw'),
    (46, 7, '2025-10-09', '2025-10-10', 'Shipped', 'Krakow'),
    (47, 1, '2025-10-30', '2025-11-03', 'Returned', 'Vilnius'),
    (48, 2, '2025-12-01', '2025-12-04', 'Delivered', 'Kaunas');

INSERT INTO order_items VALUES
    (1, 1, 9, 1, 499.00),
    (2, 2, 6, 1, 45.50),
    (3, 2, 8, 1, 249.00),
    (4, 3, 2, 1, 999.00),
    (5, 3, 10, 1, 39.90),
    (6, 4, 7, 1, 159.00),
    (7, 5, 11, 1, 4.50),
    (8, 6, 6, 1, 45.50),
    (9, 7, 5, 1, 89.00),
    (10, 7, 11, 2, 4.50),
    (11, 8, 8, 1, 249.00),
    (12, 9, 5, 1, 89.00),
    (13, 10, 8, 1, 249.00),
    (14, 11, 9, 1, 499.00),
    (15, 11, 5, 5, 89.00),
    (16, 11, 7, 1, 159.00),
    (17, 12, 1, 1, 1299.00),
    (18, 12, 8, 1, 249.00),
    (19, 13, 10, 1, 39.90),
    (20, 14, 11, 1, 4.50),
    (21, 14, 9, 1, 499.00),
    (22, 14, 7, 1, 159.00),
    (23, 15, 4, 1, 29.90),
    (24, 16, 2, 1, 999.00),
    (25, 17, 3, 1, 289.00),
    (26, 17, 11, 1, 4.50),
    (27, 18, 8, 1, 249.00),
    (28, 19, 12, 1, 7.90),
    (29, 19, 5, 2, 89.00),
    (30, 20, 9, 1, 499.00),
    (31, 20, 5, 2, 89.00),
    (32, 20, 2, 1, 999.00),
    (33, 21, 9, 1, 499.00),
    (34, 21, 6, 2, 45.50),
    (35, 22, 8, 1, 249.00),
    (36, 23, 4, 5, 29.90),
    (37, 23, 10, 1, 39.90),
    (38, 24, 4, 1, 29.90),
    (39, 25, 11, 1, 4.50),
    (40, 26, 11, 1, 4.50),
    (41, 27, 3, 1, 289.00),
    (42, 28, 10, 5, 39.90),
    (43, 29, 12, 1, 7.90),
    (44, 29, 11, 2, 4.50),
    (45, 30, 4, 1, 29.90),
    (46, 31, 3, 1, 289.00),
    (47, 31, 1, 1, 1299.00),
    (48, 32, 9, 1, 499.00),
    (49, 33, 10, 2, 39.90),
    (50, 33, 1, 1, 1299.00),
    (51, 34, 6, 1, 45.50),
    (52, 34, 11, 1, 4.50),
    (53, 35, 9, 1, 499.00),
    (54, 35, 8, 1, 249.00),
    (55, 36, 9, 1, 499.00),
    (56, 36, 10, 1, 39.90),
    (57, 37, 12, 3, 7.90),
    (58, 37, 9, 1, 499.00),
    (59, 37, 5, 3, 89.00),
    (60, 38, 2, 1, 999.00),
    (61, 39, 3, 1, 289.00),
    (62, 39, 11, 1, 4.50),
    (63, 39, 6, 3, 45.50),
    (64, 40, 11, 2, 4.50),
    (65, 41, 6, 1, 45.50),
    (66, 42, 6, 1, 45.50),
    (67, 43, 2, 1, 999.00),
    (68, 43, 12, 1, 7.90),
    (69, 43, 5, 3, 89.00),
    (70, 44, 5, 1, 89.00),
    (71, 44, 7, 1, 159.00),
    (72, 44, 3, 1, 289.00),
    (73, 45, 2, 1, 999.00),
    (74, 46, 4, 1, 29.90),
    (75, 46, 2, 1, 999.00),
    (76, 47, 5, 1, 89.00),
    (77, 47, 10, 2, 39.90),
    (78, 47, 3, 1, 289.00),
    (79, 48, 9, 1, 499.00),
    (80, 48, 4, 1, 29.90);

INSERT INTO payments VALUES
    (1, 1, '2024-02-10', 499.00, 'PayPal'),
    (2, 2, '2024-02-21', 294.50, 'Card'),
    (3, 3, '2024-02-23', 1038.90, 'Card'),
    (4, 4, '2024-02-22', 159.00, 'Apple Pay'),
    (5, 6, '2024-03-05', 45.50, 'Card'),
    (6, 7, '2024-03-08', 98.00, 'Card'),
    (7, 9, '2024-03-17', 89.00, 'PayPal'),
    (8, 11, '2024-04-06', 1103.00, 'Card'),
    (9, 12, '2024-04-08', 1548.00, 'Card'),
    (10, 13, '2024-05-02', 39.90, 'Bank Transfer'),
    (11, 14, '2024-05-10', 662.50, 'Card'),
    (12, 15, '2024-05-18', 29.90, 'Card'),
    (13, 16, '2024-05-30', 999.00, 'PayPal'),
    (14, 18, '2024-07-08', 249.00, 'PayPal'),
    (15, 19, '2024-08-09', 185.90, 'Card'),
    (16, 20, '2024-08-17', 1676.00, 'PayPal'),
    (17, 21, '2024-08-18', 590.00, 'Apple Pay'),
    (18, 22, '2024-09-06', 249.00, 'Bank Transfer'),
    (19, 23, '2024-10-26', 189.40, 'Card'),
    (20, 24, '2024-11-13', 29.90, 'PayPal'),
    (21, 25, '2024-12-01', 4.50, 'Apple Pay'),
    (22, 26, '2025-01-13', 4.50, 'PayPal'),
    (23, 27, '2025-02-10', 289.00, 'Card'),
    (24, 28, '2025-02-13', 199.50, 'Card'),
    (25, 29, '2025-03-06', 16.90, 'PayPal'),
    (26, 31, '2025-03-13', 1588.00, 'PayPal'),
    (27, 32, '2025-03-22', 499.00, 'PayPal'),
    (28, 33, '2025-06-05', 1378.80, 'Card'),
    (29, 34, '2025-07-04', 50.00, 'PayPal'),
    (30, 35, '2025-07-09', 748.00, 'Apple Pay'),
    (31, 36, '2025-07-21', 538.90, 'PayPal'),
    (32, 37, '2025-07-26', 789.70, 'Apple Pay'),
    (33, 38, '2025-07-29', 999.00, 'PayPal'),
    (34, 39, '2025-08-06', 430.00, 'Card'),
    (35, 40, '2025-08-09', 9.00, 'Bank Transfer'),
    (36, 41, '2025-08-16', 45.50, 'Card'),
    (37, 42, '2025-08-22', 45.50, 'PayPal'),
    (38, 43, '2025-08-21', 1273.90, 'Card'),
    (39, 44, '2025-08-26', 537.00, 'Bank Transfer'),
    (40, 45, '2025-10-07', 999.00, 'Card'),
    (41, 46, '2025-10-09', 1028.90, 'PayPal'),
    (42, 47, '2025-10-30', 457.80, 'Card'),
    (43, 48, '2025-12-01', 528.90, 'Card');

-- Row counts
SELECT 'departments' AS table_name, COUNT(*) FROM departments
UNION ALL SELECT 'employees', COUNT(*) FROM employees
UNION ALL SELECT 'customers', COUNT(*) FROM customers
UNION ALL SELECT 'products', COUNT(*) FROM products
UNION ALL SELECT 'orders', COUNT(*) FROM orders
UNION ALL SELECT 'order_items', COUNT(*) FROM order_items
UNION ALL SELECT 'payments', COUNT(*) FROM payments;
