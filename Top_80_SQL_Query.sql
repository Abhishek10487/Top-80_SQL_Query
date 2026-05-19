create table emp1(
emp_id int,
emp_name varchar(20),
department_id int,
salary int,
manager_id int,
emp_age int);

insert into emp1 values (101, 'Ankit', 100,10000, 4, 39);
insert into emp1 values (102, 'Mohit', 100, 15000, 5, 48);
insert into emp1 values (103, 'Vikas', 100, 10000,4,37);
insert into emp1 values (104, 'Rohit', 100, 5000, 2, 16);
insert into emp1 values (105, 'Mudit', 200, 12000, 6,55);
insert into emp1 values (106, 'Agam', 200, 12000,2, 14);
insert into emp1 values (107, 'Sanjay', 200, 9000, 2,13);
insert into emp1 values (108, 'Ashish', 200,5000,2,12);
insert into emp1 values (109, 'Mukesh',300,6000,6,51);
insert into emp1 values (110, 'Rakesh',300,7000,6,50);
insert into emp1 values (104, 'Rohit', 100, 5000, 2, 16);
insert into emp1 values (105, 'Mudit', 200, 12000, 6,55);
insert into emp1 values (106, 'Agam', 200, 12000,2, 14);

Drop Table emp1;

Select * From Emp1;

 --- Top 10 SQL interview Questions and Answers | Frequently asked SQL interview questions.

 --- Q1 How to find duplicates in a given table
     Select * From Emp1;

     Select emp_id, Count(1) 
	 from emp1 
	 group by emp_id 
	 having COUNT(1)>1

 --- Q2 How to delete duplicates
     Select * From Emp1;

     With Cte as
     (Select *, ROW_NUMBER() Over(Partition by emp_id order by emp_id) as rnk from emp1)
     Delete from Cte 
	 where rnk>1

 --- Q3 difference between union (we can get only unique Values) remove the duplicates and union all (Combining two tables)
     Select manager_id from emp
     Union all
     Select manager_id from emp1
	 

 -- Q4 difference between rank, row_number and dense_rank (Window is created by partition by function)
     Select emp_id,emp_name, department_id, salary, 
     Rank() Over(partition by department_id order by salary desc) as Rank,
     Dense_Rank() Over(partition by department_id order by salary desc) as Dense_rank,
     Row_Number() Over(partition by department_id order by salary desc) as Row_No
     from emp

	 

  -- Q5 how to find department wise Highest salary
     Select * from (
	 Select emp_id,emp_name, department_id, salary, 
     Rank() Over(partition by department_id order by salary desc) as rnk
     from emp) a
	 Where rnk = 1

--- Q6 employees who are not present in department table
	create table dept(
	dep_id int,
	dep_name varchar(10)
	);
	insert into dept values (100,'Analytics');
	insert into dept values (300,'IT');

	Drop table dept;

	Select * from emp
	Select * from dept

	Select * from emp 
	where department_id not in (Select dept_id from department); 

	Select emp.*, dept.dep_id, dept.dep_name 
	from emp 
	Left JOIN dept 
	on emp.department_id = dept.dep_id
	Where dept.dep_name is null;

--- Q7 second highest salary in each dep
    Select * From (
	Select emp.*, dense_rank() over(partition by department_id order by salary desc) as Rnk From emp
	) a
	Where Rnk = 2

--- Q8 find all transaction done by Shilpa
	create table orders(
	customer_name char(10),
	order_date date,
	order_amount int,
	customer_gender char(6)
	);

	insert into orders values('Shilpa','2020-01-01',10000,'Male');
	insert into orders values('Rahul','2020-01-02',12000,'Female');
	insert into orders values('Shilpa','2020-01-02',12000,'Male');
	insert into orders values('Rohit','2020-01-03',15000,'Female');
	insert into orders values('Shilpa','2020-01-03',14000,'Male');

	Drop Table orders
 
	Select * from orders where UPPER(Customer_name) = 'SHILPA';

--- Q9 Find employees with salary more than their managers salary -- (self join, manager salary > emp salary)
    Select * from emp

	Select e.emp_id,e.emp_name,m.emp_name as manager_name, e.salary, m.salary as manager_salary
	From emp e
	Inner Join emp m 
	on e.manager_id = m.emp_id
	Where e.salary > m.salary

--- Q10 Joins Left join/äner join

--- Q11 update query to swap gender
    Select * from orders;

	Update orders 
	set customer_gender = case when customer_gender= 'Male' then 'Female'
							   when customer_gender= 'Female' then 'Male' end

--- 12 How to retrieve the second-highest salary of an employee? 
     SELECT MAX (salary)  
     FROM emp1  
     WHERE salary < (SELECT MAX (salary) FROM emp1);
	 
	 Select * from emp1;

--- 13 How to get the nth highest salary in? 
      SELECT salary  
      FROM (SELECT salary, DENSE_RANK () OVER (ORDER BY salary DESC) AS rank  
      FROM emp1) AS ranked_salaries  
      WHERE rank = 3;

	  Select * From emp1;

--- How to get the 3rd highest salary using CTE ?
      WITH SalaryRank AS 
      (SELECT emp_id, emp_name, salary, DENSE_RANK() OVER (ORDER BY salary DESC) AS rank
      FROM emp1)
      SELECT * FROM SalaryRank
      WHERE rank = 3;

--- 14 How do you fetch all employees whose salary is greater than the average salary? 
       SELECT * FROM emp1
       WHERE salary > (SELECT AVG (salary) FROM emp1);
	 
--- 15 Write a query to display the current date and time in. 
     SELECT CURRENT_TIMESTAMP.
	 
--- 16 How to find duplicate records in a table? 
       SELECT emp_id,emp_name,COUNT(*) as Xyz 
       FROM emp1 
       GROUP BY emp_id,emp_name
       HAVING COUNT (*) > 1; 

--- 17 How can you delete duplicate rows in?
        WITH CTE AS 
        (SELECT emp_id, ROW_NUMBER () OVER (PARTITION BY emp_id ORDER BY department_id) 
        AS row_num 
        FROM emp1 ) 
        DELETE FROM CTE WHERE row_num > 1;

		Select * from emp1

--- 18	How to get the common records from two tables? 
        SELECT *  FROM table1  
        INTERSECT  
        SELECT * FROM table2

--- 19	How to retrieve the last 5 records from a table?  
        SELECT * FROM emp1
        ORDER BY emp_id DESC
        LIMIT 5;

--- 20 How do you fetch the top 5 employees with the highest salaries? 
       SELECT * FROM emp1 
       ORDER BY salary DESC  
       LIMIT 5; 

--- 21 How to calculate the total salary of all employees?
       SELECT SUM(salary) 
       FROM emp1; 

--- 22.	How to write a query to find all employees who joined in the year 2020?  
        SELECT * FROM employee  
        WHERE YEAR(join_date) = 2020; 

--- 23	Write a query to find employees whose name starts with 'A'.  
        SELECT * FROM emp1  
        WHERE emp_name LIKE 'A%'

---24	How can you find the employees who do not have a manager? 
        SELECT * FROM emp1  
        WHERE manager_id IS NULL; 

---25	How to find the department with the highest number of employees? 
        SELECT department_id, COUNT (*)  
        FROM emp1 
        GROUP BY department_id  
        ORDER BY COUNT (*) DESC 
        LIMIT 1; 

--- 26	How to get the count of employees in each department? 
        SELECT department_id, COUNT (*)
        FROM emp1
        GROUP BY department_id; 

---27	Write a query to fetch employees having the highest salary in each department. 
        SELECT department_id, emp_id, salary  
        FROM emp1 AS Emp
        WHERE salary = (SELECT MAX(salary) FROM emp1 WHERE department_id = e.department_id);

		Select * From EMP1

---28	How to write a query to update the salary of all employees by 10%? 
         UPDATE emp1 
         SET salary = salary * 1.1; 

---29	How can you find employees whose salary is between 50,000 and 1,00,000? 
         SELECT * FROM emp1
         WHERE salary BETWEEN 5000 AND 10000;

---30	How to find the youngest employee in the organization? 
         SELECT * FROM emp1
         ORDER BY emp_age DESC 
         LIMIT 1; 

---31	How to fetch the first and last record from a table?
        (SELECT * FROM emp1 ORDER BY employee_id ASC LIMIT 1) 
         UNION ALL 
        (SELECT * FROM emp1 ORDER BY employee_id DESC LIMIT 1);
		
---32	Write a query to find all employees who report to a specific manager.   
        SELECT * FROM emp  
        WHERE manager_id = 2;

---33	How can you find the total number of departments in the company?  
        SELECT COUNT(DISTINCT department_id) as Dept
        FROM emp; 

---34	How to find the department with the lowest average salary?   
        SELECT department_id, AVG (salary)  
        FROM emp 
        GROUP BY department_id  
        ORDER BY AVG (salary) ASC  
        LIMIT 1; 

---35	How to delete all employees from a department in one query? 
        DELETE FROM emp
        WHERE department_id = ?; 

---36	How to display all employees who have been in the company for more than 5 years?   
        SELECT *  
        FROM employees  
        WHERE DATEDIFF(CURDATE(), join_date) > 1825; 

---37	How to find the second-largest value from a table?   
         SELECT MAX(column_name)  
         FROM table_name  
         WHERE column_name < (SELECT MAX(column_name) FROM table_name);

---38	How to write a query to remove all records from a table but keep the table structure? 
        TRUNCATE TABLE table_name;
 
---39	Write a query to get all employee records in XML format. 
        SELECT employee_id, name, department_id  
        FROM employees  
        FOR XML AUTO;

---40	How to get the current month’s name from?
        SELECT MONTHNAME (CURDATE ());


---42  How to find all employees who do not have any subordinates?
       SELECT *  
       FROM emp1  
       WHERE emp_id NOT IN (SELECT manager_id FROM emp1 WHERE manager_id IS NOT NULL); 

---43  Write a query to calculate the total sales per customer in a sales table.   
       SELECT customer_id, SUM (sales_amount)  
       FROM sales  
       GROUP BY customer_id;

---44	How to write a query to check if a table is empty?   
        SELECT CASE 
        WHEN EXISTS (SELECT 1 FROM table_name)  
        THEN 'Not Empty'  
        ELSE 'Empty'  
        END; 

---45	How to find the second highest salary for each department? 
        SELECT department_id, salary 
        FROM (SELECT department_id, salary, DENSE_RANK() OVER (PARTITION BY department_id ORDER BY salary DESC) AS rank
        FROM employees) AS ranked_salaries
        WHERE rank = 2; 

---46	Write a query to fetch employees whose salary is a multiple of 10,000.   
        SELECT * FROM employees
        WHERE salary % 10000 = 0; 

---47	How to fetch records where a column has null values? 
        SELECT * FROM employees
        WHERE column_name IS NULL; 

---48	How to write a query to find the total number of employees in each job title?   
        SELECT job_title, COUNT(*) 
        FROM employees  
        GROUP BY job_title; 

---49	Write a query to fetch all employees whose names end with ‘n’.
        SELECT * FROM employees 
        WHERE name LIKE '%n'; 

---50	How to find all employees who work in both departments 101 and 102? 
        SELECT employee_id
        FROM employees
        WHERE department_id IN (101, 102)
        GROUP BY employee_id  
        HAVING COUNT(DISTINCT department_id) = 2;

---51	Write a query to fetch the details of employees with the same salary. 
        SELECT * FROM emp1
        WHERE salary IN (SELECT salary
        FROM emp1
        GROUP BY salary
        HAVING COUNT(*) > 1);
		
---52	How to update salaries of employees based on their department?   
         UPDATE emp1 
         SET salary = CASE 
         WHEN department_id = 101 THEN salary * 1.10      
         WHEN department_id = 102 THEN salary * 1.05
         ELSE salary  
         END;

---53	How to write a query to list all employees without a department?   
         SELECT * FROM employees  
         WHERE department_id IS NULL; 

---54	Write a query to find the maximum salary and minimum salary in each department.   
         SELECT department_id, MAX(salary), MIN(salary)  
         FROM employees
         GROUP BY department_id; 

---55 	How to list all employees hired in the last 6 months?  
         SELECT * FROM employees  
         WHERE hire_date > ADDDATE(CURDATE(), INTERVAL -6 MONTH); 

---56	Write a query to display department-wise total and average salary. 
         SELECT department_id, SUM(salary) AS total_salary, AVG(salary) AS avg_salary 
         FROM emp1
         GROUP BY department_id;


---57	How to find employees who joined the company in the same month and year as their manager?   
        SELECT e.emp_id, e.name 
        FROM emp1 e  
        JOIN emp1 m ON e.manager_id = m.emp_id  
        WHERE MONTH(e.join_date) = MONTH(m.join_date) 
        AND YEAR(e.join_date) = YEAR(m.join_date);

---58	Write a query to count the number of employees whose names start and end with the same letter. 
         SELECT COUNT(*) 
         FROM emp1 
         WHERE LEFT(name, 1) = RIGHT(name, 1); 

---59	How to retrieve employee names and salaries in a single string?   
         SELECT CONCAT(name, ' earns ', salary) AS employee_info
         FROM emp1; 

---60	How to find employees whose salary is higher than their manager's salary
         SELECT e.employee_id, e.name
         FROM emp1 e 
         JOIN employees m ON e.manager_id = m.employee_id  
         WHERE e.salary > m.salary;

---61	Write a query to get employees who belong to departments with less than 3 employees. 
        SELECT * FROM employees
        WHERE department_id IN (SELECT department_id 
                                FROM employees 
                                GROUP BY department_id  
                                HAVING COUNT(*) < 3); 
---62	How to write a query to find employees with the same first name? 
        SELECT * FROM employees
        WHERE first_name IN (SELECT first_name 
                             FROM employees
                             GROUP BY first_name
                             HAVING COUNT(*) > 1);

---63	How to write a query to delete employees who have been in the company for more than 15 years?
         DELETE FROM employees
         WHERE DATEDIFF(CURDATE(), join_date) > 5475;

---64	Write a query to list all employees working under the same manager.   
         SELECT * FROM employees  
         WHERE manager_id = ?; 

---65	How to find the top 3 highest-paid employees in each department? 
         SELECT * FROM (
		 SELECT *, DENSE_RANK() OVER (PARTITION BY department_id ORDER BY salary DESC) AS rank 
         FROM employees) AS ranked_employees 
         WHERE rank <= 3; 

---66	Write a query to list all employees with more than 5 years of experience in each department. 
        SELECT * FROM employees 
        WHERE DATEDIFF(CURDATE(), join_date) > 1825;

---67	How to list all employees in departments that have not hired anyone in the past 2 years? 
        SELECT * FROM employees 
        WHERE department_id IN (SELECT department_id  
                                FROM employees  
                                GROUP BY department_id  
                                HAVING MAX(hire_date) < ADDDATE(CURDATE(), INTERVAL -2 YEAR));
								
---68	Write a query to find all employees who earn more than the average salary of their department.
        SELECT * FROM employees e  
        WHERE salary > (SELECT AVG(salary)  
                        FROM employees  
                        WHERE department_id = e.department_id);
						
---69	How to list all managers who have more than 5 subordinates? 
        SELECT * FROM employees  
        WHERE employee_id IN (SELECT manager_id  
                              FROM employees  
                              GROUP BY manager_id  
                              HAVING COUNT(*) > 5);

---70	Write a query to display employee names and hire dates in the format "Name - MM/DD/YYYY".
        SELECT CONCAT(name, ' - ', DATE_FORMAT(hire_date, '%m/%d/%Y')) AS employee_info  
        FROM employees;

---71	How to find employees whose salary is in the top 10%?
         SELECT * FROM employees  
         WHERE salary >= (SELECT PERCENTILE_CONT(0.9)  
                          WITHIN GROUP (ORDER BY salary ASC)  
                          FROM employees);

---72	Write a query to display employees grouped by their age brackets (e.g., 20-30, 31-40, etc.).
         SELECT CASE  
         WHEN age BETWEEN 20 AND 30 THEN '20-30'           
         WHEN age BETWEEN 31 AND 40 THEN '31-40'  
         ELSE '41+'  
         END AS age_bracket,  
         COUNT(*) FROM employees  
         GROUP BY age_bracket; 

---73	How to find the average salary of the top 5 highest-paid employees in each department?
         SELECT department_id, AVG(salary)  
         FROM (SELECT department_id, salary, DENSE_RANK() OVER (PARTITION BY department_id ORDER BY salary DESC) AS rank  
         FROM employees) AS ranked_employees  
         WHERE rank <= 5  
         GROUP BY department_id;

---74	How to calculate the percentage of employees in each department?
         SELECT department_id,(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM employees)) AS percentage  
         FROM employees  
         GROUP BY department_id;

---75	Write a query to find all employees whose email contains the domain '@example.com'.
        SELECT * FROM employees  
        WHERE email LIKE '%@example.com';

---76	How to retrieve the year-to-date sales for each customer?
        SELECT customer_id, SUM(sales_amount)  
        FROM sales  
        WHERE sale_date BETWEEN '2024-01-01' AND CURDATE()  
        GROUP BY customer_id;

---77	Write a query to display the hire date and day of the week for each employee. 
        SELECT name, hire_date, DAYNAME(hire_date) AS day_of_week  
        FROM employees;

---78	How to find all employees who are older than 30 years? 
         SELECT * FROM employees  
         WHERE DATEDIFF(CURDATE(), birth_date) / 365 > 30;

---79	Write a query to display employees grouped by their salary range (e.g., 020K, 20K-50K).
         SELECT CASE  
         WHEN salary BETWEEN 0 AND 20000 THEN '0-20K'  
         WHEN salary BETWEEN 20001 AND 50000 THEN '20K-50K'  
         ELSE '50K+'  
         END AS salary_range,  
         COUNT(*)  
         FROM employees  
         GROUP BY salary_range;

---80	How to list all employees who do not have a bonus? 
         SELECT * FROM employees  
         WHERE bonus IS NULL; 

---81	Write a query to display the highest, lowest, and average salary for each job role. 
         SELECT job_role, MAX(salary) AS highest_salary, MIN(salary) AS lowest_salary, AVG(salary) AS avg_salary  
         FROM employees  
         GROUP BY job_role;

---82	Write a query to calculate the even and odd records from a table.
        Select * From employeeinfo where empid % 2 <> 0   ---- ODD
        Select * From employeeinfo where empid % 2 = 0    ----Even



  




  







