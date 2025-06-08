	SELECT 
    p1.name AS First_Product,
    p2.name AS Second_Product,
    COUNT(*) AS Products_Together
FROM 
    order_details AS od1
JOIN 
    order_details AS od2 
    ON od1.order_id = od2.order_id 
    AND od1.product_id < od2.product_id
JOIN 
    products AS p1 ON od1.product_id = p1.id
JOIN 
    products AS p2 ON od2.product_id = p2.id
GROUP BY 
    p1.name, p2.name
ORDER BY 
Products_Together DESC;