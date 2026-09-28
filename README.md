# Restaurant Orders SQL Analysis

This project explores a restaurant orders dataset using SQL Server.

The project focuses on answering a series of business-related questions about orders, customers, restaurants, revenue, delivery performance, and customer spending.

## Dataset

The dataset used in this project was obtained from Kaggle:

[SQL Practice Dataset #2 – Medium Queries](https://www.kaggle.com/datasets/nudratabbas/sql-practice-dataset-2-medium-queries/data)

## Questions Explored

The analysis includes questions such as:

* How many total orders were placed?
* Which cities have the most customers?
* What is the average delivery time?
* Which restaurants generate the most revenue?
* What are the most ordered menu items?
* Which cities generate the most revenue?
* Which cuisine types generate the most revenue?
* Which restaurants receive the most orders?
* What is the average order value per restaurant?
* What is the average spending per customer?

## SQL Concepts Used

The project uses several SQL concepts, including:

* SELECT and filtering
* ORDER BY
* GROUP BY
* Aggregate functions such as SUM, COUNT, and AVG
* INNER JOIN
* Multi-table JOINs
* Subqueries
* DATEDIFF
* TOP and WITH TIES

## Notes

For some questions, an analytical assumption was required.

For example, city revenue was calculated based on the city where the restaurant is located.

Cancelled orders were also included when identifying which restaurant received the most orders, because the question refers to all placed orders regardless of final order status.

## File

`restaurant_orders_analysis.sql` contains all analytical questions and their corresponding SQL queries.
