SELECT * FROM `Pizza DB`.Pizza_Sales;

# Total Revenue:
SELECT SUM(total_price) as Total_Revenue FROM `Pizza DB`.Pizza_Sales;

#Average Order Value
SELECT (SUM(total_price) / COUNT(DISTINCT order_id)) AS Avg_order_Value FROM pizza_sales

#Total Pizzas Sold
SELECT SUM(quantity) AS Total_pizza_sold FROM pizza_sales

#Total Orders
SELECT COUNT(DISTINCT order_id) AS Total_Orders FROM pizza_sales

#Average Pizzas Per Order
SELECT CAST(CAST(SUM(quantity) AS DECIMAL(10,2)) / 
CAST(COUNT(DISTINCT order_id) AS DECIMAL(10,2)) AS DECIMAL(10,2))
AS Avg_Pizzas_per_order
FROM pizza_sales


#Hourly Trend for Total Pizzas Sold
SELECT HOUR(order_time) as order_hours, SUM(quantity) as total_pizzas_sold
FROM pizza_sales
GROUP BY HOUR(order_time)
ORDER BY HOUR(order_time);


#Weekly Trend for Orders
SELECT 
    WEEK(STR_TO_DATE(order_date, '%d.%m.%Y'), 3) AS WeekNumber,
    YEAR(STR_TO_DATE(order_date, '%d.%m.%Y')) AS Year,
    COUNT(DISTINCT order_id) AS Total_orders
FROM 
    pizza_sales
GROUP BY 
    WeekNumber,
    Year
ORDER BY 
    Year, WeekNumber;


# % of Sales by Pizza Category
SELECT pizza_category, CAST(SUM(total_price) AS DECIMAL(10,2)) as total_revenue,
CAST(SUM(total_price) * 100 / (SELECT SUM(total_price) from pizza_sales where month(order_date)=1) AS DECIMAL(10,2)) AS PCT
FROM pizza_sales
where month(order_date)=1
GROUP BY pizza_category

#% of Sales by Pizza Size
SELECT pizza_size, CAST(SUM(total_price) AS DECIMAL(10,2)) as total_revenue,
CAST(SUM(total_price) * 100 / (SELECT SUM(total_price) from pizza_sales WHERE QUARTER(order_date) = 1) AS DECIMAL(10,2)) AS PCT
FROM pizza_sales
WHERE QUARTER(order_date) = 1
GROUP BY pizza_size
ORDER BY pizza_size

#Top 5 Pizzas by Revenue
SELECT pizza_name, SUM(total_price) AS Total_Revenue
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Revenue DESC
LIMIT 5;

#Bottom 5 Pizzas by Revenue
SELECT pizza_name, SUM(total_price) AS Total_Revenue
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Revenue ASC
LIMIT 5;

#Top 5 Pizzas by Quantity
SELECT pizza_name, SUM(quantity) AS Total_Quantity
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Quantity DESC
LIMIT 5;

#Bottom 5 Pizzas by Quantity
SELECT pizza_name, SUM(quantity) AS Total_Quantity
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Quantity ASC
LIMIT 5;

#Top 5 Pizzas by Total Orders
SELECT pizza_name, COUNT(DISTINCT order_id) AS Total_Orders
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Orders DESC
LIMIT 5;

#Borrom 5 Pizzas by Total Orders
SELECT pizza_name, COUNT(DISTINCT order_id) AS Total_Orders
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Orders ASC
LIMIT 5;




















