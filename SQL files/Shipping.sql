CREATE VIEW vw_Shipping AS
SELECT
    s.ID,
    s.Order_ID,
    s.Shipping_Date,
    s.status,
    s.Carrier,
    o.Order_Date,

    DATEDIFF(DAY, o.Order_Date, s.Shipping_Date) AS Shipping_Duration_Days

FROM 
    Shipping s
LEFT JOIN 
    Orders o ON s.Order_ID = o.ID;
