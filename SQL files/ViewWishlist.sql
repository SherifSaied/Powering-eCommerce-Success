CREATE VIEW vw_Wishlist AS
SELECT
    w.product_id,
    COUNT(w.Product_ID) AS Wishlist_Count,
    MIN(w.added_date) AS First_Wishlist_Date,
    MAX(w.added_date) AS Last_Wishlist_Date
FROM
    Wishlists w
GROUP BY
    w.product_id;
