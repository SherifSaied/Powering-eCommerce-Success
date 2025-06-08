CREATE VIEW Dim_Customer_Flat AS
SELECT 
    c.ID AS Customer_ID,
    CONCAT(c.First_Name, ' ', c.Last_Name) AS Full_Name,
    c.Email,
    c.Phone,
    c.Registration_Date AS Signup_Date,
    c.Address,

    -- Aggregated session data
    COUNT(s.Session_Start) AS Total_Sessions,
    SUM(DATEDIFF(MINUTE, s.Session_Start, s.Session_End)) AS Total_Session_Duration_Minutes,
    AVG(DATEDIFF(MINUTE, s.Session_Start, s.Session_End)) AS Avg_Session_Duration_Minutes,
	    MIN(s.Session_Start) AS First_Session_Date,
		MAX(s.Session_End) AS Last_Session_Date,

	 -- Segment calculation
    CASE
    WHEN DATEDIFF(DAY, MAX(s.Session_End), GETDATE()) < 15 THEN '<15'
        WHEN DATEDIFF(DAY, MAX(s.Session_End), GETDATE()) < 30 THEN '<30'
         WHEN DATEDIFF(DAY, MAX(s.Session_End), GETDATE()) < 60 THEN '<60'
        ELSE '>60'
    END AS Customer_Segment ,

    -- Segment calculation
    CASE
    WHEN DATEDIFF(DAY, MAX(s.Session_End), GETDATE()) < 30 THEN '<30'
        WHEN DATEDIFF(DAY, MAX(s.Session_End), GETDATE()) < 60 THEN '<60'
        ELSE '>60'
    END AS Customer_Segment2 

FROM 
    Customers c
LEFT JOIN 
    Customer_Sessions s ON c.ID = s.Customer_ID
GROUP BY 
    c.ID, c.First_Name, c.Last_Name, c.Email, c.Phone, c.Registration_Date, c.Address;
    
