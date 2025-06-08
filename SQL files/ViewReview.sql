CREATE VIEW vw_Review_Comments AS
SELECT
    r.ID,
    r.Product_ID,
    r.Customer_ID,
    r.Rating,
    r.Comment,
    r.Review_Date
FROM
    reviews r;
