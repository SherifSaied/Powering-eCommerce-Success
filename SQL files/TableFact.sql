-- 1. إنشاء جدول جديد (Table) بناءً على هيكل الـ VIEW
CREATE TABLE Fact_Sales_Table (
    Order_ID INT,
    Customer_ID INT,
    Order_Date DATE,
    Order_Status VARCHAR(50),

    Product_ID INT,
    Quantity INT,
    Unit_Price DECIMAL(18,2),

    payment_method VARCHAR(50),
    payment_date DATE,
    payment_status VARCHAR(50)
);

-- 2. نسخ البيانات من الـ VIEW للجدول الجديد
INSERT INTO Fact_Sales_Table
SELECT
    od.Order_ID,
    o.Customer_ID,
    o.Order_Date,
    o.Status AS Order_Status,
    od.Product_ID,
    od.Quantity,
    od.Unit_Price,
    p.payment_method,
    p.payment_date,
    p.status As payment_status
FROM order_details od
LEFT JOIN Orders o ON od.order_id = o.ID
LEFT JOIN Payments p ON o.ID = p.Order_ID;


--لو الكود ده مشتغلش حطوه  في صفحه لوحده او جربوا تعملوه مع  شات جي بي تي مفروض انه بيسمح المتكرر 
WITH RankedOrders AS (
    SELECT *,
        ROW_NUMBER() OVER (
            PARTITION BY Order_ID, Product_ID, Customer_ID, Order_Date, payment_method, payment_date
            ORDER BY (SELECT NULL) -- أو payment_date DESC لو حابب تحتفظ بأحدث صف
        ) AS rn
    FROM Fact_Sales_Table
)
DELETE FROM RankedOrders
WHERE rn > 1;
