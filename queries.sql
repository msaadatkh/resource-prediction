RESET QUERY CACHE;

USE employees;

SELECT e.first_name, e.last_name, d.dept_name, t.title, t.from_date, t.to_date FROM employees e INNER JOIN  dept_emp de ON e.emp_no=de.emp_no INNER JOIN departments d ON de.dept_no=d.dept_no INNER JOIN titles t ON e.emp_no=t.emp_no ORDER BY  e.first_name, e.last_name, d.dept_name, t.from_date
