--List the following details of each employee: employee number, last name, 
--first name, sex, and salary.
SELECT emp.emp_no, last_name, first_name, sex, salary
FROM employees AS emp LEFT JOIN
	salaries AS sal ON emp.emp_no = sal.emp_no
;

--List first name, last name, and hire date for employees who were 
--hired in 1986.
SELECT first_name, last_name, hire_date
FROM employees
WHERE CAST(SUBSTRING(hire_date, 7, 4) AS INT) >= 1995
;

--List the manager of each department with the following information: 
--department number, department name, the manager's employee number, 
--last name, first name.
SELECT dept.dept_no, dept_name, mgr.emp_no, emp.last_name, emp.first_name
FROM departments AS dept 
	LEFT JOIN dept_manager AS mgr ON dept.dept_no = mgr.dept_no
	LEFT JOIN employees AS emp ON mgr.emp_no = emp.emp_no
;

--List the department of each employee with the following information: 
--employee number, last name, first name, and department name.
SELECT emp.emp_no, last_name, first_name, dept_name
FROM employees AS emp
	LEFT JOIN dept_emp AS de ON emp.emp_no = de.emp_no
	LEFT JOIN departments AS dept ON de.dept_no = dept.dept_no
;

--List first name, last name, and sex for employees whose first name is 
--"Hercules" and last names begin with "B."
SELECT first_name, last_name, sex
FROM employees
WHERE first_name = 'Hercules' AND
	SUBSTRING(last_name,1,1) = 'B'
;

--List all employees in the Sales department, including their employee 
--number, last name, first name, and department name.
SELECT emp.emp_no, last_name, first_name, dept.dept_name
FROM employees AS emp
	LEFT JOIN dept_emp AS de ON emp.emp_no = de.emp_no
	LEFT JOIN departments AS dept ON de.dept_no = dept.dept_no
WHERE dept_name = 'Sales'
;

--List all employees in the Sales and Development departments, including 
--their employee number, last name, first name, and department name.
SELECT emp.emp_no, last_name, first_name, dept.dept_name
FROM employees AS emp
	LEFT JOIN dept_emp AS de ON emp.emp_no = de.emp_no
	LEFT JOIN departments AS dept ON de.dept_no = dept.dept_no
WHERE dept_name = 'Sales' OR dept_name = 'Development'
;

--In descending order, list the frequency count of employee last names, 
--i.e., how many employees share each last name.
SELECT last_name, COUNT(last_name)
FROM employees
GROUP BY last_name
ORDER BY COUNT(last_name) DESC
;