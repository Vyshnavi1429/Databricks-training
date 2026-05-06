--1.Select all columns form Employee Table 
    select * from Employee;

--2.Select only the name, salary columns from Employee Table. 
     select name,salary from Employee;

--3. Select Employees who are older than 30
     select name from Employee
     where age > 30;
--4. Select names of all Departments
     select name from Department;

--5. Select Employess who work in the IT Department 
     select name from Employee where department_id=1;
            --(or)
           SELECT e.name
           FROM Employee e
           JOIN Department d
           ON e.department_id = d.department_id
           WHERE d.name = 'IT';

--6. Select Employees whose name start with ‘J’ 
     select name from Employee
     where name like 'J%';

--7. Select Employees whose name end with ‘e’ 
     select name from Employee
     where name like '%e';
--8. Select Employees whose name contains ‘a’ 
     select name from Employee
    where name like '%a%';
--9. Select employees whose names are exactly 9 characters long.
     select name
     from Employee
     where name LIKE '_________';
--10. select employees whose names have ‘o’ as  the second character.
      select name
      from Employee
      where name LIKE '_o%';

--11. Select employees hired in the year 2020.
      select name,hire_date
      from Employee
      where YEAR(hire_date)=2020;

--12. Select employees hired in January of any year
      select name,hire_date
      from Employee 
      Where MONTH(hire_date)=1;

--13. Select employees hired before 2019.
      select name,hire_date
      from Employee
      where YEAR(hire_date)<2019;

--14. Select employees hired on or after March 1, 2021. 
      SELECT name,hire_date
      FROM Employee
      WHERE hire_date >= '2021-03-01';

--15. Select employees hired in the last 2 years
      select name,hire_date
      from Employee 
      where
      hire_date between '2020-01-1' and '2021-12-31';

--16. Select the total salary of all employees. 
      select sum(salary) as Total_salary
      from Employee;

--17.Select the average salary of employee. 
     select avg(salary) as avg_salary
     from Employee;

--18. Select the minimum salary in the Employee table. 
      select name, salary
      from Employee
      where salary = (select min(salary) from Employee);

--19. Select the number of employees in each department.
      select department_id, count(*) as employee_count
      from Employee
      group by department_id;

--20. Select the average salary of employees in each department. 
      select department_id,avg(salary) as avg_salary
      from Employee
      group by department_id;
--21. Select the total salary for each department.
      select d.name, SUM(e.salary) as total_salary
      from Employee e
      join Department d
      on e.department_id = d.department_id
      group by d.name;
--22. Select the average age of employees in each department.
      select d.name, avg(e.age) as avg_age
      from Employee e join Department d
      on e.department_id=d.department_id
      group by d.name;

--23. Select the number of employees hired in each year. 
      select YEAR(hire_date) as Year,count(*) as no_of_emps from Employee e
      group by YEAR(hire_date);

--24. Select the highest salary in each department.
      select d.name,MAx(salary) from Employee e join Department d on d.department_id=e.department_id
      group by d.name;

--25. Select the department with the highest average salary. 
      select d.name, avg(e.salary) as avg_salary from Employee e
      join Department d on e.department_id = d.department_id
      group by d.name;

--26. Select departments with more than 2 employees. 
      SELECT department_id, COUNT(*) AS emp_count FROM Employee
      GROUP BY department_id
      HAVING COUNT(*) >  2;
--27. Select departments with an average salary grester than 55000.
      Select d.name,avg(salary) as avg_salary from Employee e join Department d on e.department_id=d.department_id
      group by d.name having avg(e.salary)>55000;
--28. Select years with more than 1 employee hired. 
      SELECT YEAR(hire_date) AS Years, COUNT(*) AS emp_count
      FROM Employee
      GROUP BY YEAR(hire_date)
      HAVING COUNT(*) > 1;

--29. Select departments with a total salary expense less than 100000. 
      SELECT d.name, SUM(e.salary) AS total_salary FROM Employee e
      JOIN Department d ON e.department_id = d.department_id
      GROUP BY d.name
      HAVING SUM(e.salary) < 100000;

--30. Select departments with the maximum salary 75000.
      Select d.name, max(e.salary) AS max_salary FROM Employee e
      JOIN Department d ON e.department_id = d.department_id
      GROUP BY d.name
      HAVING max(e.salary) = 75000;

--31. Select all employees ordered by their salary in ascending order.
      Select name,salary
      from Employee order by salary;

--32. Select all employees ordered by their age in descending order.
      select name,age 
      from Employee order by age desc;

--33. Select all employees ordered by their hire date in ascending order
      select name,hire_date
      from Employee order by hire_date;

--34. Select employees ordered by their department and then by their salary
      select name,department_id,salary
      from Employee order by department_id,salary;

--35. Select departments ordered by the total salary of their employees.
      select d.name, sum(e.salary) as total_salary from Employee e
      join Department d on e.department_id = d.department_id
      group by d.name
      order by total_salary;
--36. Select employee names along with their deparments names. 
      select e.name,d.name
      from Employee e join Department d on e.department_id=d.department_id;

--37.Select project names along with the department names they belong to.
     select p.name as pro_name,d.name as dept_name
     from Project p join Department d on p.department_id=d.department_id;

--38. Select employees names and their corresponding project name
      SELECT e.name, p.name AS project_name FROM Employee e
      JOIN Department d ON e.department_id = d.department_id
      JOIN Project p ON d.department_id = p.department_id;

--39. Select all employees and their departments, including those without a department.
      SELECT e.name, d.name AS department_name FROM Employee e
      LEFT JOIN Department d
      ON e.department_id = d.department_id;

--40. Select all departments and their employees, including department without employees. 
      select d.name as dept_name,e.name as emp_name
      from Department d left join Employee e on d.department_id = e.department_id;
