-- copy data from csv file to zepto table
COPY zepto(category,name,mrp,discountPercent,availableQuantity,
            discountedSellingPrice,weightInGms,outOfStock,quantity)
FROM 'D:\SQL-project2\data_files\zepto_v2.csv' 
WITH (FORMAT csv, HEADER true, DELIMITER ',', QUOTE '"', ENCODING 'UTF8');

-- Data exploration queries

-- Count of rows
SELECT COUNT(*) FROM zepto;

-- Sample data
SELECT * FROM zepto 
LIMIT 10;

-- Check for null values
SELECT * 
FROM zepto
WHERE name IS NULL
OR
category IS NULL
OR
mrp IS NULL
OR
discountpercent IS NULL
OR
discountedsellingprice IS NULL
OR
weightingms IS NULL
OR
outofstock IS NULL
OR
availablequantity IS NULL
OR
quantity IS NULL;

-- different product categories
SELECT DISTINCT category
FROM zepto
ORDER BY category;

--products in stock vs out of stock 
SELECT outofstock, COUNT(sku_id)
FROM zepto
GROUP BY outofstock;

--products present multiple times
SELECT name, COUNT(sku_id) AS "Number of SKUs"
FROM zepto
GROUP BY name
HAVING COUNT(sku_id) > 1
ORDER BY COUNT(sku_id) DESC;

-- Data cleaning queries

--product with price is eqaul to zero
SELECT *
FROM zepto
WHERE mrp = 0
OR discountedSellingPrice = 0;

-- Deleting products with price equal to zero
DELETE FROM zepto
WHERE mrp = 0;

--convert paise to rupees
UPDATE zepto
SET mrp = mrp / 100.0,
    discountedSellingPrice = discountedSellingPrice / 100.0;

-- Verify the update
SELECT mrp, discountedSellingPrice
FROM zepto;


