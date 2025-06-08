CREATE VIEW vw_Inventory_Movement AS
SELECT 
    im.id As InventoryMovement_id,
    im.product_id,
	p.Name As product_name,
    im.quantity,
    im.Movement_Type,
    im.Movement_Date

FROM inventory_movements im
JOIN Products p ON im.Product_ID = p.id;
