Create database western_country_finance_data;
use western_country_finance_data;

CREATE TABLE western_country_financial_data (
    Segment VARCHAR(255),
    Country VARCHAR(255),
    Product VARCHAR(255),
    Discount_Band VARCHAR(255),
    Units_Sold INT,
    Manufacturing_Price INT,
    Sale_Price INT,
    Gross_Sales INT,
    Discounts INT,
    Sales INT,
    COGS INT,
    Profit INT,
    Dates DATE,
    Month_Number INT,
    Month_Name VARCHAR(255),
    Years YEAR
);

SELECT * FROM western_country_financial_data;

-- Total Sales Across All Regions
select sum(Sales) as Total_Sales from western_country_financial_data;

-- Total Profit by Country
select Country, sum(Profit) as Total_Profit 
from western_country_financial_data
group by Country 
order by Total_Profit DESC;

-- Number of Units Sold by Segment
select Segment, sum(Units_Sold) as Total_Units_Sold
from western_country_financial_data
group by Segment
order by Total_Units_Sold desc;

-- Top 5 Products by Gross Sales
SELECT Product, SUM(Gross_Sales) AS Total_Gross_Sales
FROM western_country_financial_data
GROUP BY Product
ORDER BY Total_Gross_Sales DESC
LIMIT 5;

-- Average Discount Given by Country
SELECT Country, AVG(Discounts) AS Avg_Discount
FROM western_country_financial_data
GROUP BY Country
ORDER BY Avg_Discount DESC;

-- Monthly Sales and Profit Trends
SELECT Month_Name, SUM(Sales) AS Total_Sales, SUM(Profit) AS Total_Profit
FROM western_country_financial_data
GROUP BY Month_Number, Month_Name
ORDER BY Month_Number ASC;

-- Most Profitable Segment for Each Year
SELECT Years, Segment, SUM(Profit) AS Total_Profit
FROM western_country_financial_data
GROUP BY Years, Segment
ORDER BY Years, Total_Profit DESC;

-- Profit Margins by Country
SELECT 
    Country, 
    SUM(Profit) AS Total_Profit, 
    SUM(Sales) AS Total_Sales,
    (SUM(Profit) / SUM(Sales)) * 100 AS Profit_Margin_Percentage
FROM western_country_financial_data
GROUP BY Country
ORDER BY Profit_Margin_Percentage DESC;

-- Products with Profit-to-COGS Ratio
SELECT 
    Product, 
    SUM(Profit) / SUM(COGS) AS Profit_to_COGS_Ratio
FROM western_country_financial_data
GROUP BY Product
ORDER BY Profit_to_COGS_Ratio DESC;

-- Quarterly Performance Analysis
SELECT 
    QUARTER(Dates) AS Quarter, 
    SUM(Sales) AS Total_Sales, 
    SUM(Profit) AS Total_Profit
FROM western_country_financial_data
GROUP BY QUARTER(Dates)
ORDER BY Quarter;

-- Year-over-Year Growth in Sales and Profit
SELECT 
    Years, 
    SUM(Sales) AS Total_Sales, 
    SUM(Profit) AS Total_Profit,
    (SUM(Sales) - LAG(SUM(Sales), 1) OVER (ORDER BY Years)) AS Sales_Growth,
    (SUM(Profit) - LAG(SUM(Profit), 1) OVER (ORDER BY Years)) AS Profit_Growth
FROM western_country_financial_data
GROUP BY Years
ORDER BY Years;

-- Countries with Below-Average Sales
WITH Country_Sales AS (
    SELECT Country, SUM(Sales) AS Total_Sales
    FROM western_country_financial_data
    GROUP BY Country
)
SELECT Country, Total_Sales
FROM Country_Sales
WHERE Total_Sales < (SELECT AVG(Total_Sales) FROM Country_Sales);

-- Top Discount Bands Driving Sales
SELECT Discount_Band, SUM(Sales) AS Total_Sales
FROM western_country_financial_data
GROUP BY Discount_Band
ORDER BY Total_Sales DESC;

-- Product Performance by Region
SELECT Country, Product, SUM(Sales) AS Total_Sales, SUM(Profit) AS Total_Profit
FROM western_country_financial_data
GROUP BY Country, Product
ORDER BY Country, Total_Profit DESC;
