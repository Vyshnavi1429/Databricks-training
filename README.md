# Databricks-training
# 📘 SQL Practice - Day 1

## 🚀 Overview

On Day 1, I learned the basics of SQL using simple queries on tables like **Employee**, **Department**, and **Project**. This includes data retrieval, filtering, aggregation, grouping, and joins.

You can view my complete Day 1 SQL practice here:
https://www.db-fiddle.com/f/4TtDKqyFyiFfYd22omVtB3/6
This link contains my full schema, queries, and outputs created using DB Fiddle.

---

## 🧠 Topics Covered

### 🔹 1. Basic SELECT Queries

* Selecting all columns and specific columns
* Using `SELECT *` and column-based selection

---

### 🔹 2. Filtering Data

* Using `WHERE` clause
* Conditions like:

  * `age > 30`
  * `department_id = 1`
* Pattern matching using:

  * `LIKE 'J%'` (starts with)
  * `LIKE '%a%'` (contains)
  * `LIKE '_o%'` (second character)

---

### 🔹 3. Working with Dates

* Extracting year and month using:

  * `YEAR(hire_date)`
  * `MONTH(hire_date)`
* Filtering based on:

  * specific year (2020)
  * before/after a date
  * between date ranges

---

### 🔹 4. Aggregate Functions

* `SUM()` → total salary
* `AVG()` → average salary
* `MIN()` / `MAX()` → lowest/highest salary
* `COUNT()` → number of employees

---

### 🔹 5. GROUP BY & HAVING

* Grouping data by:

  * department
  * year
* Filtering grouped data using `HAVING`

  * e.g., departments with more than 2 employees

---

### 🔹 6. Sorting Data

* Using `ORDER BY`

  * Ascending (`ASC`)
  * Descending (`DESC`)
* Sorting by multiple columns

---

### 🔹 7. Joins

* `INNER JOIN` → matching records
* `LEFT JOIN` → include unmatched records
* Combining:

  * Employee + Department
  * Employee + Project

---

### 🔹 8. Real-world Queries

* Employees per department
* Salary analysis (avg, total, max)
* Hiring trends (year-wise)
* Department insights

---

## 💡 Key Learnings

* Importance of correct **date format (`YYYY-MM-DD`)**
* Difference between `WHERE` and `HAVING`
* How `GROUP BY` changes query behavior
* When to use `JOIN` vs `NATURAL JOIN`
* Writing clean and optimized SQL queries

---

## 🛠️ Tools Used

* DB Fiddle (online SQL practice)

---

## 🎯 Conclusion

Day 1 helped me build a strong foundation in SQL basics, including querying, filtering, grouping, and joining data. These concepts are essential for real-world database operations and interviews.


---

✍️ *More practice and advanced SQL concepts coming in upcoming days...*

