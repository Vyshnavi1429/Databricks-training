--41. Select Employees who are not assigned to any project
    select e.name
    from Employee e
    left join Department d
    on e.department_id = d.department_id
    left join Project p
    on d.department_id = p.department_id
    where p.project_id is null;

--42. Select employees and the number of projects their department is working on.
    select e.name, count(p.project_id) as project_count from Employee e
    left join Department d on e.department_id = d.department_id
    left join Project p on d.department_id = p.department_id
    group by e.name;

--43 Select the departments that have no employees
     select d.name from Department d left join Employee e on d.department_id = e.department_id
     where e.emp_id is null;
--44. Select employees names who share department with 'John Doe'.
      select name
      from Employee
      where department_id = (
            select department_id
            from Employee
            where name = 'John Doe'
            );
--45. Select the department name with the highest average salary
      select d.name, avg(e.salary) as avg_salary from Employee join Department d
      on e.department_id = d.department_id group by d.name
      order by avg_salary desc
      limit 1;
--46. Select the employee with the highest salary.
      select name, salary
      from Employee
      where salary = (select max(salary) from Employee);

--47. Select employees whose salary is above the average salary.
      select name, salary
      from Employee
      where salary > (select avg(salary) from Employee);

--48. Select the second highest salary from yhe Employee table.
    select max(salary) as second_highest_salary
    from Employee
    where salary < (select max(salary) from Employee);

--49. Select the department with the most employees.
      select d.name, count(e.emp_id) as emp_count from Department d
      join Employee e on d.department_id = e.department_id
      group by d.name
      order by emp_count desc
      limit 1;

--50. Select employees who earn more than the everage salary of their dwpartment.
      select e.name, e.salary
      from Employee e
      where e.salary > (
          select avg(e2.salary)
          from Employee e2
          where e2.department_id = e.department_id
          );

--51. Select the nth highest salary(for example ,3rd Highest)










