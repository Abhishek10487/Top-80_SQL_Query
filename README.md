````markdown
# 🚀 Top 82 SQL Interview Questions and Answers

# 📌 Project Overview

This repository contains **Top 82 SQL Interview Questions and Answers** frequently asked in:

- Data Analyst Interviews
- SQL Developer Interviews
- BI Developer Interviews
- Data Engineering Interviews

The project covers:

✅ SQL Basics  
✅ Aggregate Functions  
✅ Window Functions  
✅ CTE  
✅ Joins  
✅ Subqueries  
✅ Ranking Functions  
✅ Real-Time SQL Scenarios  
✅ Data Cleaning Queries  
✅ Analytical SQL Problems  

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
````

---

# 📥 Insert Sample Data

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

# 📚 SQL Interview Questions & Answers

---

# 1️⃣ Find Duplicate Records

```sql
SELECT emp_id, COUNT(1)
FROM emp1
GROUP BY emp_id
HAVING COUNT(1) > 1;
```

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

---

# 3️⃣ Difference Between UNION and UNION ALL

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

---

# 4️⃣ Difference Between RANK, DENSE_RANK, ROW_NUMBER

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

---

# 5️⃣ Department Wise Highest Salary

```sql
SELECT *
FROM (
    SELECT *,
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

# 8️⃣ Find Transactions Done by Shilpa

```sql
SELECT *
FROM orders
WHERE UPPER(customer_name) = 'SHILPA';
```

---

# 9️⃣ Employees Earning More Than Managers

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

# 1️⃣5️⃣ Find Duplicate Records

```sql
SELECT emp_id,
       emp_name,
       COUNT(*) AS total_count
FROM emp1
GROUP BY emp_id, emp_name
HAVING COUNT(*) > 1;
```

---

# 1️⃣6️⃣ Delete Duplicate Rows

```sql
WITH CTE AS (
    SELECT emp_id,
           ROW_NUMBER() OVER(PARTITION BY emp_id ORDER BY department_id) AS row_num
    FROM emp1
)
DELETE FROM CTE
WHERE row_num > 1;
```

---

# 1️⃣7️⃣ Common Records from Two Tables

```sql
SELECT *
FROM table1

INTERSECT

SELECT *
FROM table2;
```

---

# 1️⃣8️⃣ Retrieve Last 5 Records

```sql
SELECT *
FROM emp1
ORDER BY emp_id DESC
LIMIT 5;
```

---

# 1️⃣9️⃣ Top 5 Highest Salaries

```sql
SELECT *
FROM emp1
ORDER BY salary DESC
LIMIT 5;
```

---

# 2️⃣0️⃣ Total Salary of Employees

```sql
SELECT SUM(salary) AS total_salary
FROM emp1;
```

---

# 2️⃣1️⃣ Employees Joined in 2020

```sql
SELECT *
FROM employee
WHERE YEAR(join_date) = 2020;
```

---

# 2️⃣2️⃣ Employees Name Starts With 'A'

```sql
SELECT *
FROM emp1
WHERE emp_name LIKE 'A%';
```

---

# 2️⃣3️⃣ Employees Without Manager

```sql
SELECT *
FROM emp1
WHERE manager_id IS NULL;
```

---

# 2️⃣4️⃣ Department With Highest Employees

```sql
SELECT department_id,
       COUNT(*) AS total_employees
FROM emp1
GROUP BY department_id
ORDER BY total_employees DESC
LIMIT 1;
```

---

# 2️⃣5️⃣ Employee Count by Department

```sql
SELECT department_id,
       COUNT(*) AS employee_count
FROM emp1
GROUP BY department_id;
```

---

# 2️⃣6️⃣ Highest Salary in Each Department

```sql
SELECT department_id,
       emp_id,
       salary
FROM emp1 e
WHERE salary = (
    SELECT MAX(salary)
    FROM emp1
    WHERE department_id = e.department_id
);
```

---

# 2️⃣7️⃣ Increase Salary by 10%

```sql
UPDATE emp1
SET salary = salary * 1.10;
```

---

# 2️⃣8️⃣ Salary Between Range

```sql
SELECT *
FROM emp1
WHERE salary BETWEEN 5000 AND 10000;
```

---

# 2️⃣9️⃣ Youngest Employee

```sql
SELECT *
FROM emp1
ORDER BY emp_age ASC
LIMIT 1;
```

---

# 3️⃣0️⃣ First and Last Record

```sql
(SELECT * FROM emp1 ORDER BY emp_id ASC LIMIT 1)

UNION ALL

(SELECT * FROM emp1 ORDER BY emp_id DESC LIMIT 1);
```

---

# 3️⃣1️⃣ Employees Reporting to Manager

```sql
SELECT *
FROM emp1
WHERE manager_id = 2;
```

---

# 3️⃣2️⃣ Total Departments

```sql
SELECT COUNT(DISTINCT department_id) AS total_departments
FROM emp1;
```

---

# 3️⃣3️⃣ Lowest Average Salary Department

```sql
SELECT department_id,
       AVG(salary) AS avg_salary
FROM emp1
GROUP BY department_id
ORDER BY avg_salary ASC
LIMIT 1;
```

---

# 3️⃣4️⃣ Delete Employees from Department

```sql
DELETE FROM emp1
WHERE department_id = 100;
```

---

# 3️⃣5️⃣ Employees More Than 5 Years Experience

```sql
SELECT *
FROM employees
WHERE DATEDIFF(CURDATE(), join_date) > 1825;
```

---

# 3️⃣6️⃣ Second Largest Value

```sql
SELECT MAX(salary)
FROM emp1
WHERE salary < (
    SELECT MAX(salary)
    FROM emp1
);
```

---

# 3️⃣7️⃣ Remove All Records Keep Structure

```sql
TRUNCATE TABLE emp1;
```

---

# 3️⃣8️⃣ Employee Records in XML Format

```sql
SELECT employee_id,
       name,
       department_id
FROM employees
FOR XML AUTO;
```

---

# 3️⃣9️⃣ Current Month Name

```sql
SELECT MONTHNAME(CURDATE());
```

---

# 4️⃣0️⃣ Employees Without Subordinates

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

# 4️⃣1️⃣ Total Sales Per Customer

```sql
SELECT customer_id,
       SUM(sales_amount)
FROM sales
GROUP BY customer_id;
```

---

# 4️⃣2️⃣ Check If Table Is Empty

```sql
SELECT CASE
       WHEN EXISTS (SELECT 1 FROM table_name)
       THEN 'Not Empty'
       ELSE 'Empty'
       END;
```

---

# 4️⃣3️⃣ Second Highest Salary in Each Department

```sql
SELECT department_id,
       salary
FROM (
    SELECT department_id,
           salary,
           DENSE_RANK() OVER(PARTITION BY department_id ORDER BY salary DESC) AS rank_no
    FROM employees
) ranked_salaries
WHERE rank_no = 2;
```

---

# 4️⃣4️⃣ Salary Multiple of 10000

```sql
SELECT *
FROM employees
WHERE salary % 10000 = 0;
```

---

# 4️⃣5️⃣ Fetch NULL Values

```sql
SELECT *
FROM employees
WHERE column_name IS NULL;
```

---

# 4️⃣6️⃣ Employee Count by Job Title

```sql
SELECT job_title,
       COUNT(*)
FROM employees
GROUP BY job_title;
```

---

# 4️⃣7️⃣ Names Ending with 'n'

```sql
SELECT *
FROM employees
WHERE name LIKE '%n';
```

---

# 4️⃣8️⃣ Employees in Both Departments

```sql
SELECT employee_id
FROM employees
WHERE department_id IN (101,102)
GROUP BY employee_id
HAVING COUNT(DISTINCT department_id) = 2;
```

---

# 4️⃣9️⃣ Employees With Same Salary

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

# 5️⃣0️⃣ Update Salary Based on Department

```sql
UPDATE emp1
SET salary =
CASE
    WHEN department_id = 101 THEN salary * 1.10
    WHEN department_id = 102 THEN salary * 1.05
    ELSE salary
END;
```

---

# 5️⃣1️⃣ Employees Without Department

```sql
SELECT *
FROM employees
WHERE department_id IS NULL;
```

---

# 5️⃣2️⃣ Max & Min Salary by Department

```sql
SELECT department_id,
       MAX(salary),
       MIN(salary)
FROM employees
GROUP BY department_id;
```

---

# 5️⃣3️⃣ Employees Hired in Last 6 Months

```sql
SELECT *
FROM employees
WHERE hire_date > ADDDATE(CURDATE(), INTERVAL -6 MONTH);
```

---

# 5️⃣4️⃣ Department Wise Total & Average Salary

```sql
SELECT department_id,
       SUM(salary) AS total_salary,
       AVG(salary) AS avg_salary
FROM emp1
GROUP BY department_id;
```

---

# 5️⃣5️⃣ Employees Joined Same Month as Manager

```sql
SELECT e.emp_id,
       e.name
FROM emp1 e
JOIN emp1 m
ON e.manager_id = m.emp_id
WHERE MONTH(e.join_date) = MONTH(m.join_date)
AND YEAR(e.join_date) = YEAR(m.join_date);
```

---

# 5️⃣6️⃣ Names Start & End Same Letter

```sql
SELECT COUNT(*)
FROM emp1
WHERE LEFT(emp_name,1) = RIGHT(emp_name,1);
```

---

# 5️⃣7️⃣ Employee Name & Salary in Single String

```sql
SELECT CONCAT(emp_name, ' earns ', salary) AS employee_info
FROM emp1;
```

---

# 5️⃣8️⃣ Salary Higher Than Manager

```sql
SELECT e.emp_id,
       e.emp_name
FROM emp1 e
JOIN emp1 m
ON e.manager_id = m.emp_id
WHERE e.salary > m.salary;
```

---

# 5️⃣9️⃣ Departments with Less Than 3 Employees

```sql
SELECT *
FROM employees
WHERE department_id IN (
    SELECT department_id
    FROM employees
    GROUP BY department_id
    HAVING COUNT(*) < 3
);
```

---

# 6️⃣0️⃣ Employees with Same First Name

```sql
SELECT *
FROM employees
WHERE first_name IN (
    SELECT first_name
    FROM employees
    GROUP BY first_name
    HAVING COUNT(*) > 1
);
```

---

# 6️⃣1️⃣ Delete Employees More Than 15 Years

```sql
DELETE FROM employees
WHERE DATEDIFF(CURDATE(), join_date) > 5475;
```

---

# 6️⃣2️⃣ Employees Under Same Manager

```sql
SELECT *
FROM employees
WHERE manager_id = 2;
```

---

# 6️⃣3️⃣ Top 3 Highest Paid Employees Department Wise

```sql
SELECT *
FROM (
    SELECT *,
           DENSE_RANK() OVER(PARTITION BY department_id ORDER BY salary DESC) AS rank_no
    FROM employees
) ranked_employees
WHERE rank_no <= 3;
```

---

# 6️⃣4️⃣ Employees with 5+ Years Experience

```sql
SELECT *
FROM employees
WHERE DATEDIFF(CURDATE(), join_date) > 1825;
```

---

# 6️⃣5️⃣ Departments Not Hiring in Last 2 Years

```sql
SELECT *
FROM employees
WHERE department_id IN (
    SELECT department_id
    FROM employees
    GROUP BY department_id
    HAVING MAX(hire_date) < ADDDATE(CURDATE(), INTERVAL -2 YEAR)
);
```

---

# 6️⃣6️⃣ Employees Earning Above Department Average

```sql
SELECT *
FROM employees e
WHERE salary > (
    SELECT AVG(salary)
    FROM employees
    WHERE department_id = e.department_id
);
```

---

# 6️⃣7️⃣ Managers with More Than 5 Subordinates

```sql
SELECT *
FROM employees
WHERE employee_id IN (
    SELECT manager_id
    FROM employees
    GROUP BY manager_id
    HAVING COUNT(*) > 5
);
```

---

# 6️⃣8️⃣ Employee Name & Hire Date Format

```sql
SELECT CONCAT(name, ' - ', DATE_FORMAT(hire_date, '%m/%d/%Y')) AS employee_info
FROM employees;
```

---

# 6️⃣9️⃣ Employees Salary in Top 10%

```sql
SELECT *
FROM employees
WHERE salary >= (
    SELECT PERCENTILE_CONT(0.9)
    WITHIN GROUP (ORDER BY salary ASC)
    FROM employees
);
```

---

# 7️⃣0️⃣ Employee Age Brackets

```sql
SELECT CASE
       WHEN age BETWEEN 20 AND 30 THEN '20-30'
       WHEN age BETWEEN 31 AND 40 THEN '31-40'
       ELSE '41+'
       END AS age_bracket,
       COUNT(*)
FROM employees
GROUP BY age_bracket;
```

---

# 7️⃣1️⃣ Average Salary of Top 5 Employees

```sql
SELECT department_id,
       AVG(salary)
FROM (
    SELECT department_id,
           salary,
           DENSE_RANK() OVER(PARTITION BY department_id ORDER BY salary DESC) AS rank_no
    FROM employees
) ranked_employees
WHERE rank_no <= 5
GROUP BY department_id;
```

---

# 7️⃣2️⃣ Employee Percentage by Department

```sql
SELECT department_id,
       (COUNT(*) * 100.0 / (SELECT COUNT(*) FROM employees)) AS percentage
FROM employees
GROUP BY department_id;
```

---

# 7️⃣3️⃣ Email Domain Search

```sql
SELECT *
FROM employees
WHERE email LIKE '%@example.com';
```

---

# 7️⃣4️⃣ Year-to-Date Sales

```sql
SELECT customer_id,
       SUM(sales_amount)
FROM sales
WHERE sale_date BETWEEN '2024-01-01' AND CURDATE()
GROUP BY customer_id;
```

---

# 7️⃣5️⃣ Hire Date with Day Name

```sql
SELECT name,
       hire_date,
       DAYNAME(hire_date) AS day_of_week
FROM employees;
```

---

# 7️⃣6️⃣ Employees Older Than 30

```sql
SELECT *
FROM employees
WHERE DATEDIFF(CURDATE(), birth_date)/365 > 30;
```

---

# 7️⃣7️⃣ Employees by Salary Range

```sql
SELECT CASE
       WHEN salary BETWEEN 0 AND 20000 THEN '0-20K'
       WHEN salary BETWEEN 20001 AND 50000 THEN '20K-50K'
       ELSE '50K+'
       END AS salary_range,
       COUNT(*)
FROM employees
GROUP BY salary_range;
```

---

# 7️⃣8️⃣ Employees Without Bonus

```sql
SELECT *
FROM employees
WHERE bonus IS NULL;
```

---

# 7️⃣9️⃣ Salary Statistics by Job Role

```sql
SELECT job_role,
       MAX(salary) AS highest_salary,
       MIN(salary) AS lowest_salary,
       AVG(salary) AS avg_salary
FROM employees
GROUP BY job_role;
```

---

# 8️⃣0️⃣ Odd Records

```sql
SELECT *
FROM employeeinfo
WHERE empid % 2 <> 0;
```

---

# 8️⃣1️⃣ Even Records

```sql
SELECT *
FROM employeeinfo
WHERE empid % 2 = 0;
```

---

# 8️⃣2️⃣ Top SQL Concepts Covered

✅ Joins
✅ CTE
✅ Window Functions
✅ Aggregate Functions
✅ Ranking Functions
✅ Subqueries
✅ Analytical Queries
✅ Data Cleaning
✅ SQL Optimization

---

# 🚀 Tools Used

* MySQL
* SQL Server
* PostgreSQL
* SSMS

---

# ⭐ Support

If you found this project useful:

⭐ Star this repository
🍴 Fork this repository
📢 Share with others

---

# 👨‍💻 Author

**Abhishek Kumar**

SQL | Power BI | Data Analytics | Business Intelligence

```
```
