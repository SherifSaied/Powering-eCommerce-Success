--الملف ده مش هيشتغل غير لم تعمل التابول فاكت الاول هتلاقيه في ملف برضو وده اخر حاجه خالص 
CREATE VIEW Fact_Sales AS
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
    p.status AS payment_status
FROM 
    order_details od
LEFT JOIN 
    Orders o ON od.Order_ID = o.ID
LEFT JOIN 
    Payments p ON o.ID = p.Order_ID;
