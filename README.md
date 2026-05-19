# SQL Interview Questions & Answers – Complete SQL Practice Guide

## 📌 Project Overview

This repository contains a collection of **Top SQL Interview Questions and Answers** designed for beginners, intermediate learners, and data analysts preparing for SQL interviews.

The project includes:

* SQL Table Creation
* Insert Statements
* SQL Queries
* Window Functions
* Joins
* CTEs
* Aggregate Functions
* Ranking Functions
* Duplicate Handling
* Salary-Based Problems
* Real-Time Interview Scenarios

Perfect for:

* Data Analysts
* SQL Developers
* BI Developers
* Freshers Preparing for Interviews

---

# 🛠 Database Setup

## Create Employee Table

```sql
CREATE TABLE emp1(
    emp_id INT,
    emp_name VARCHAR(20),
    department_id INT,
    salary INT,
    manager_id INT,
    emp_age INT
);
```

---

## Insert Sample Data

```sql
INSERT INTO emp1 VALUES (101, 'Ankit', 100,10000, 4, 39);
INSERT INTO emp1 VALUES (102, 'Mohit', 100, 15000, 5, 48);
INSERT INTO emp1 VALUES (103, 'Vikas', 100, 10000,4,37);
INSERT INTO emp1 VALUES (104, 'Rohit', 100, 5000, 2, 16);
INSERT INTO emp1 VALUES (105, 'Mudit', 200, 12000, 6,55);
INSERT INTO emp1 VALUES (106, 'Agam', 200, 12000,2, 14);
INSERT INTO emp1 VALUES (107, 'Sanjay', 200, 9000, 2,13);
INSERT INTO emp1 VALUES (108, 'Ashish', 200,5000,2,12);
INSERT INTO emp1 VALUES (109, 'Mukesh',300,6000,6,51);
INSERT INTO emp1 VALUES (110, 'Rakesh',300,7000,6,50);
```

---

# 📚 Top SQL Interview Questions & Answers

---

# 1️⃣ Find Duplicate Records

```sql
SELECT emp_id, COUNT(1)
FROM emp1
GROUP BY emp_id
HAVING COUNT(1) > 1;
```

### ✅ Explanation

Used to identify duplicate employee IDs in the table.

---

# 2️⃣ Delete Duplicate Records

```sql
WITH CTE AS (
    SELECT *,
           ROW_NUMBER() OVER(PARTITION BY emp_id ORDER BY emp_id) AS rnk
    FROM emp1
)
DELETE FROM CTE
WHERE rnk > 1;
```

### ✅ Explanation

Removes duplicate rows while keeping one original record.

---

# 3️⃣ UNION vs UNION ALL

```sql
SELECT manager_id FROM emp
UNION
SELECT manager_id FROM emp1;
```

```sql
SELECT manager_id FROM emp
UNION ALL
SELECT manager_id FROM emp1;
```

### ✅ Difference

| UNION              | UNION ALL        |
| ------------------ | ---------------- |
| Removes duplicates | Keeps duplicates |
| Slower             | Faster           |

---

# 4️⃣ RANK vs DENSE_RANK vs ROW_NUMBER

```sql
SELECT emp_id,
       emp_name,
       department_id,
       salary,
       RANK() OVER(PARTITION BY department_id ORDER BY salary DESC) AS Rank_No,
       DENSE_RANK() OVER(PARTITION BY department_id ORDER BY salary DESC) AS Dense_Rank_No,
       ROW_NUMBER() OVER(PARTITION BY department_id ORDER BY salary DESC) AS Row_No
FROM emp1;
```

### ✅ Explanation

* `RANK()` skips numbers for duplicates
* `DENSE_RANK()` does not skip numbers
* `ROW_NUMBER()` always gives unique sequence

---

# 5️⃣ Department Wise Highest Salary

```sql
SELECT *
FROM (
    SELECT emp_id,
           emp_name,
           department_id,
           salary,
           RANK() OVER(PARTITION BY department_id ORDER BY salary DESC) AS rnk
    FROM emp1
) a
WHERE rnk = 1;
```

---

# 6️⃣ Employees Not Present in Department Table

```sql
SELECT emp.*
FROM emp1 emp
LEFT JOIN dept d
ON emp.department_id = d.dep_id
WHERE d.dep_name IS NULL;
```

---

# 7️⃣ Second Highest Salary in Each Department

```sql
SELECT *
FROM (
    SELECT *,
           DENSE_RANK() OVER(PARTITION BY department_id ORDER BY salary DESC) AS rnk
    FROM emp1
) a
WHERE rnk = 2;
```

---

# 8️⃣ Find All Transactions Done by Shilpa

```sql
SELECT *
FROM orders
WHERE UPPER(customer_name) = 'SHILPA';
```

---

# 9️⃣ Employees Earning More Than Their Managers

```sql
SELECT e.emp_id,
       e.emp_name,
       m.emp_name AS manager_name,
       e.salary,
       m.salary AS manager_salary
FROM emp1 e
JOIN emp1 m
ON e.manager_id = m.emp_id
WHERE e.salary > m.salary;
```

---

# 🔟 Update Query to Swap Gender

```sql
UPDATE orders
SET customer_gender =
CASE
    WHEN customer_gender = 'Male' THEN 'Female'
    WHEN customer_gender = 'Female' THEN 'Male'
END;
```

---

# 1️⃣1️⃣ Second Highest Salary

```sql
SELECT MAX(salary)
FROM emp1
WHERE salary < (SELECT MAX(salary) FROM emp1);
```

---

# 1️⃣2️⃣ Nth Highest Salary

```sql
SELECT salary
FROM (
    SELECT salary,
           DENSE_RANK() OVER(ORDER BY salary DESC) AS rank_no
    FROM emp1
) ranked_salaries
WHERE rank_no = 3;
```

---

# 1️⃣3️⃣ Employees Salary Greater Than Average Salary

```sql
SELECT *
FROM emp1
WHERE salary > (SELECT AVG(salary) FROM emp1);
```

---

# 1️⃣4️⃣ Current Date & Time

```sql
SELECT CURRENT_TIMESTAMP;
```

---

# 1️⃣5️⃣ Retrieve Last 5 Records

```sql
SELECT *
FROM emp1
ORDER BY emp_id DESC
LIMIT 5;
```

---

# 1️⃣6️⃣ Top 5 Highest Salaries

```sql
SELECT *
FROM emp1
ORDER BY salary DESC
LIMIT 5;
```

---

# 1️⃣7️⃣ Total Salary of Employees

```sql
SELECT SUM(salary) AS total_salary
FROM emp1;
```

---

# 1️⃣8️⃣ Employees Name Starts With 'A'

```sql
SELECT *
FROM emp1
WHERE emp_name LIKE 'A%';
```

---

# 1️⃣9️⃣ Employees Without Manager

```sql
SELECT *
FROM emp1
WHERE manager_id IS NULL;
```

---

# 2️⃣0️⃣ Department With Highest Number of Employees

```sql
SELECT department_id,
       COUNT(*) AS total_employees
FROM emp1
GROUP BY department_id
ORDER BY total_employees DESC
LIMIT 1;
```

---

# 2️⃣1️⃣ Count Employees in Each Department

```sql
SELECT department_id,
       COUNT(*) AS employee_count
FROM emp1
GROUP BY department_id;
```

---

# 2️⃣2️⃣ Update Salary by 10%

```sql
UPDATE emp1
SET salary = salary * 1.10;
```

---

# 2️⃣3️⃣ Youngest Employee

```sql
SELECT *
FROM emp1
ORDER BY emp_age ASC
LIMIT 1;
```

---

# 2️⃣4️⃣ First and Last Record

```sql
(SELECT * FROM emp1 ORDER BY emp_id ASC LIMIT 1)
UNION ALL
(SELECT * FROM emp1 ORDER BY emp_id DESC LIMIT 1);
```

---

# 2️⃣5️⃣ Employees Reporting to Specific Manager

```sql
SELECT *
FROM emp1
WHERE manager_id = 2;
```

---

# 2️⃣6️⃣ Department Wise Total & Average Salary

```sql
SELECT department_id,
       SUM(salary) AS total_salary,
       AVG(salary) AS avg_salary
FROM emp1
GROUP BY department_id;
```

---

# 2️⃣7️⃣ Employees Without Subordinates

```sql
SELECT *
FROM emp1
WHERE emp_id NOT IN (
    SELECT manager_id
    FROM emp1
    WHERE manager_id IS NOT NULL
);
```

---

# 2️⃣8️⃣ Find Same Salary Employees

```sql
SELECT *
FROM emp1
WHERE salary IN (
    SELECT salary
    FROM emp1
    GROUP BY salary
    HAVING COUNT(*) > 1
);
```

---

# 2️⃣9️⃣ Top 3 Highest Paid Employees in Each Department

```sql
SELECT *
FROM (
    SELECT *,
           DENSE_RANK() OVER(PARTITION BY department_id ORDER BY salary DESC) AS rank_no
    FROM emp1
) ranked_employees
WHERE rank_no <= 3;
```

---

# 3️⃣0️⃣ Even and Odd Records

## Odd Records

```sql
SELECT *
FROM employeeinfo
WHERE empid % 2 <> 0;
```

## Even Records

```sql
SELECT *
FROM employeeinfo
WHERE empid % 2 = 0;
```

---

# 🎯 SQL Concepts Covered

* SQL Basics
* Aggregate Functions
* Window Functions
* CTE
* Self Join
* Subqueries
* Ranking Functions
* Data Cleaning
* Duplicate Handling
* Analytical SQL Queries

---

# 🚀 Tools Used

* SQL Server
* MySQL
* PostgreSQL
* SSMS

---

# 📈 Ideal For

* SQL Interview Preparation
* Data Analyst Portfolio
* GitHub SQL Projects
* SQL Practice
* BI Developer Learning

---

# ⭐ Support

If you found this project useful:

* ⭐ Star this repository
* 🍴 Fork the repository
* 🧠 Practice the queries
* 📢 Share with others

---

# 👨‍💻 Author

**Abhishek Kumar**

SQL | Power BI | Data Analytics | Business Intelligence
