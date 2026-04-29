# SQL Case Studies – Customer, Product & Order Analytics

This repository contains a collection of SQL queries designed to solve real-world business problems using an e-commerce database. The focus is on **data analysis, transformations, aggregations, and conditional logic using SQL**.

---

## 📊 Overview

The project demonstrates how to extract meaningful insights from relational databases using:

* `CASE` statements for conditional categorization
* `JOIN` operations across multiple tables
* Aggregations like `SUM`, `COUNT`
* Subqueries for complex filtering
* Data formatting and transformation

---

## 🗂️ Database Tables Used

* `ONLINE_CUSTOMER`
* `PRODUCT`
* `PRODUCT_CLASS`
* `ORDER_ITEMS`
* `ORDER_HEADER`
* `ADDRESS`
* `SHIPPER`
* `CARTON`

---

## 🧠 Problem Statements Covered

### 🔹 Customer Analysis

* Categorize customers based on creation year
* Format customer names with titles and uppercase formatting

### 🔹 Product Insights

* Identify unsold products
* Calculate inventory value
* Apply dynamic pricing discounts

### 🔹 Inventory & Classification

* Analyze product classes with high inventory value
* Count product types per class

### 🔹 Order & Customer Behavior

* Find customers who cancelled all their orders
* Analyze shipping activity by shipper (DHL)
* Compute total quantity and value of orders

### 🔹 Inventory Status Logic

* Assign inventory status based on:

  * Product category
  * Sales volume
  * Available stock

### 🔹 Advanced Queries

* Find the largest order that fits in a specific carton
* Identify products sold together (market basket analysis)
* Filter orders based on conditions (even IDs, pincode rules, etc.)

---

## ⚙️ Key SQL Concepts Used

| Concept          | Usage                        |
| ---------------- | ---------------------------- |
| CASE Statements  | Conditional categorization   |
| JOINs            | Combining multiple tables    |
| GROUP BY         | Aggregation logic            |
| HAVING           | Filtering aggregated results |
| Subqueries       | Nested filtering conditions  |
| String Functions | Formatting names             |
| Date Functions   | Extracting year              |

---

## 📌 Sample Highlight

Example: Customer categorization logic

```sql
CASE
  WHEN YEAR(customer_creation_date) < 2005 THEN 'Category A'
  WHEN YEAR(customer_creation_date) BETWEEN 2005 AND 2010 THEN 'Category B'
  ELSE 'Category C'
END
```

---

## 🚀 How to Use

1. Clone the repository:

   ```bash
   git clone https://github.com/your-username/sql-case-studies.git
   ```

2. Open your SQL environment (MySQL / PostgreSQL / SQL Server)

3. Run queries against the provided schema

---

## 🎯 Learning Outcomes

By working through this project, you will:

* Strengthen SQL query writing skills
* Understand real-world data analysis scenarios
* Learn how to structure complex queries
* Improve problem-solving using SQL

---

## 📬 Contributions

Feel free to fork this repository and improve the queries or add new case studies.

---

## ⭐ If you find this helpful

Give this repo a star ⭐ and share it with others learning SQL!

---
