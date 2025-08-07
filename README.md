# 🍕 SQL Pizza Shop Database Project

A hands-on SQL project simulating the backend operations of a pizza delivery shop! This project focuses on creating and querying a relational database consisting of pizzas, their categories, order details, and more—perfect for showcasing SQL fundamentals in a real-world business context.

---

## 🧾 Project Overview

This project demonstrates how SQL can be used to manage and analyze data in a pizza business environment using core SQL concepts like:

* `SELECT`, `WHERE`, `GROUP BY`, `ORDER BY`
* `JOINs` (INNER, LEFT, RIGHT)
* Aggregation functions (`COUNT`, `SUM`, `AVG`)
* Filtering and sorting for insights

---

## 🗂️ Database Tables

The following relational tables were used:

* **🍕 pizzas** – pizza\_id, name, type\_id, price
* **📦 pizza\_types** – type\_id, type\_name (e.g., Classic, Veggie, Meat)
* **📁 pizza\_categories** – category\_id, category\_name (e.g., Thin Crust, Deep Dish)
* **🧾 orders** – order\_id, order\_date, total\_price
* **🧺 order\_details** – detail\_id, order\_id, pizza\_id, quantity

---

## 🔍 Key SQL Tasks Performed

* Retrieved best-selling pizza types and top revenue-generating items
* Analyzed sales trends using `GROUP BY` and date filtering
* Joined multiple tables to generate a consolidated view of orders
* Filtered data to answer key business questions such as:

  * Which pizza category sells the most?
  * What is the average revenue per order?
  * What are peak sales periods?

---

## 🎯 Objectives

* Practice and demonstrate SQL skills in a structured use case
* Understand relationships in a normalized database
* Extract actionable insights for business decisions

---

## 🛠️ Tech Stack

* MySQL

---

## 📎 Sample Queries

```sql
-- Top 5 Best-Selling Pizzas
SELECT p.name, SUM(od.quantity) AS total_sold
FROM order_details od
JOIN pizzas p ON od.pizza_id = p.pizza_id
GROUP BY p.name
ORDER BY total_sold DESC
LIMIT 5;
```

---


## 📁 Files Included

* `create_tables.sql` – SQL script to create the schema
* `insert_data.sql` – Sample data for the tables
* `queries.sql` – Main analysis queries
* `README.md` – This file

---

