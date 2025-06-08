CREATE VIEW vw_Discounts AS
SELECT
    d.ID AS Discounts_id,
	d.code,
    d.Product_ID,
    d.percentage,
	d.is_active ,
    d.Start_Date,
    d.End_Date,
    DATEDIFF(DAY, d.Start_Date, d.End_Date) AS DiscountDurationDays,
    CASE
        WHEN d.Product_ID IS NULL THEN 'General'
        ELSE 'Per Product'
    END AS Discount_Level
FROM
    Discounts d
