
-- * INTERMEDIATE *

-- 1. How many total orders were placed?

SELECT COUNT(order_id) AS TotalOrders
FROM dbo.orders_medium;
GO

-- 2. Which cities have the most customers?

SELECT TOP 1 WITH TIES city, COUNT(customer_id) AS CountCustomer
FROM dbo.customers_medium
GROUP BY city
ORDER BY CountCustomer DESC;
GO

-- 3. Which cuisine types are most common?

SELECT cuisine, COUNT(restaurant_id) AS CountCuisine
FROM dbo.restaurants
GROUP BY cuisine
ORDER BY CountCuisine DESC
GO

-- 4. What are the top restaurants by rating?

SELECT TOP 10 restaurant_id, rating
FROM dbo.restaurants
ORDER BY rating DESC
GO



-- * ANALYTICAL *

-- 1. What is the average delivery time?

SELECT AVG(DATEDIFF(MINUTE, order_time, delivery_time)) AS AvgDeliveryTime
FROM dbo.orders_medium
WHERE status != 'Cancelled'
GO

-- 2. Which restaurants generate the most revenue?

SELECT TOP 10 restaurant_id, SUM(i.quantity*i.price) AS TotalRevenue
FROM dbo.orders_medium AS o
	JOIN dbo.[order_items (2)] AS i
	ON o.order_id = i.order_id
WHERE status != 'Cancelled'
GROUP BY restaurant_id
ORDER BY TotalRevenue DESC
GO

-- 3. What are the most ordered menu items?

SELECT TOP 10 item_id, SUM(quantity) AS SumItem
FROM dbo.[order_items (2)]
GROUP BY item_id
ORDER BY SumItem DESC
GO

-- 4. Which cities generate the highest revenue?

-- This query calculates city revenue based on restaurants located in each city.

SELECT TOP 10 city, SUM(i.price*i.quantity) AS TotalRev
FROM dbo.restaurants AS r
	JOIN dbo.orders_medium AS o
	ON r.restaurant_id = o.restaurant_id
	JOIN dbo.[order_items (2)] AS i
	ON o.order_id = i.order_id
WHERE status != 'Cancelled'
GROUP BY city
ORDER BY TotalRev DESC
GO



-- * ADVANCED *

-- 1. What is the average order value per restaurant?

SELECT restaurant_id, AVG(s.SumOrder) AS AvgOrderRes
FROM (	
	SELECT restaurant_id, i.order_id, SUM(i.quantity*i.price) AS SumOrder
	FROM dbo.orders_medium AS o
		JOIN dbo.[order_items (2)] AS i
		ON o.order_id = i.order_id
	WHERE o.status != 'Cancelled'
	GROUP BY i.order_id, restaurant_id
	) AS s
GROUP BY restaurant_id
GO

-- 2. Which customers order most frequently?

SELECT TOP 10 customer_id, COUNT(order_id) AS CountOrder
FROM dbo.orders_medium
WHERE status != 'Cancelled'
GROUP BY customer_id
ORDER BY CountOrder DESC 
GO

-- 3. Which cuisine type generates the most revenue?

SELECT TOP 1 WITH TIES cuisine, SUM(quantity*price) AS TotalRev
FROM dbo.restaurants AS r
	JOIN dbo.orders_medium AS o
	ON r.restaurant_id = o.restaurant_id
	JOIN dbo.[order_items (2)] AS i
	ON o.order_id = i.order_id
WHERE o.status != 'Cancelled'
GROUP BY cuisine
ORDER BY TotalRev DESC
GO

-- 4. Which restaurant receives the most orders?

-- Cancelled orders are included because "receives the most orders" refers to all placed orders.

SELECT TOP 1 WITH TIES restaurant_id, COUNT(order_id) AS CountOrder
FROM dbo.orders_medium
GROUP BY restaurant_id
ORDER BY CountOrder DESC
GO

-- 5. What is the average spending per customer?

SELECT AVG(s.SumOrder) AS AvgPerCustomer
FROM (
		SELECT customer_id, SUM(quantity*price) AS SumOrder
	FROM dbo.orders_medium AS o
		JOIN dbo.[order_items (2)] AS i
		ON o.order_id = i.order_id
	WHERE o.status != 'Cancelled'
	GROUP BY customer_id
	) AS s
GO