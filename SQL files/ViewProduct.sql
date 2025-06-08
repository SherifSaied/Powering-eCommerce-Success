CREATE VIEW Dim_Product_Flat AS
SELECT 
    p.id As product_id, 
	p.Category_ID,
	p.supplier_id,
	c.name AS ceregory_name, 
    p.name AS product_name,
	p.price,
	p.stock_quantity

FROM 
    products p
JOIN 
    categories c ON p.Category_ID = c.id;

