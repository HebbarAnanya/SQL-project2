--find the top 10 best value products based on discount percentage

SELECT DISTINCT name, mrp, discountPercent
FROM zepto
ORDER BY discountPercent DESC
LIMIT 10;

--what are products with highest mrp but out of stock?

SELECT DISTINCT name, mrp
FROM zepto
WHERE outOfStock = TRUE
AND mrp > 300
ORDER BY mrp DESC;

--calculate estimated revenue for each category

SELECT category, SUM(discountedSellingPrice * availableQuantity) AS totalRevenue
FROM zepto
GROUP BY category
ORDER BY totalRevenue;

--find all the products where mrp is greater than 500 and discount is less than 10%

SELECT DISTINCT name, mrp, discountPercent
FROM zepto
WHERE mrp > 500
AND discountPercent < 10
ORDER BY mrp, discountpercent DESC;

--identify the top 5 categories offering the highest average discount percentage

SELECT category, ROUND(AVG(discountPercent), 2) AS averageDiscount
FROM zepto
GROUP BY category
ORDER BY averageDiscount DESC
LIMIT 5;

--find the price per gram for products above 100gms and sort by best value

SELECT DISTINCT name, weightInGms, discountedSellingPrice,
       ROUND((discountedSellingPrice / weightInGms), 2) AS pricePerGram
FROM zepto
WHERE weightInGms >= 100
ORDER BY pricePerGram;

--group the products into categories like low, medium, and bulk

SELECT DISTINCT name, weightInGms,
       CASE 
           WHEN weightInGms < 1000 THEN 'Low'
           WHEN weightInGms < 5000 THEN 'Medium'
           ELSE 'Bulk'
       END AS weightCategory
FROM zepto;

--total inventory weight per category

SELECT category, SUM(weightInGms * availableQuantity) AS totalWeight
FROM zepto
GROUP BY category
ORDER BY totalWeight;

