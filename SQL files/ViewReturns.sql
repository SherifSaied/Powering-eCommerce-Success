CREATE VIEW vw_Returns AS
SELECT
    r.ID AS Return_ID,
    r.Order_ID,
    r.Return_Date,
    r.Reason,
    r.status
FROM
    returns r