CREATE VIEW vw_Suppliers AS
SELECT
    s.ID AS Supplier_ID,
    s.Name AS Supplier_Name,
    s.Contact_Person,
    s.Email,
    s.Phone,
    s.Address
FROM
    Suppliers s