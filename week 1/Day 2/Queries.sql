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
      select distinct salary
     from Employee
     order by salary desc
     limit 1 offset 2; 

--52. Select employees who are older than all employees in the HR department
      select name, age
      from Employee
      where age > (
        select max(e2.age) from Employee e2
        join Department d
        on e2.department_id = d.department_id
        where d.name = 'HR'
         );

--53. Select departments where the average salary is greater than 55000
select d.name, avg(e.salary) as avg_salary
from Employee e
join Department d
on e.department_id = d.department_id
group by d.name
having avg(e.salary) > 55000;

--54. Select employees who work in a department with at least 2 projects
select e.name
from Employee e
where e.department_id in (
    select Department_id
    from Project
    group by department_id
    having count(*) >= 2
);

--55. Select employees who were hired on the same date as 'Jane Smith'
select name, hire_date
from Employee
where hire_date = (
    select hire_date
    from Employee
    where name = 'Jane Smith'
);

--56. Select the Total salary of employees hired in 2020
select sum(salary) as total_salary
from Employee
where year(hire_date) = 2020;

--57. Select the average salary of employees in each department, ordered by the average salary in descending order.
select d.name, avg(e.salary) as avg_salary
from Employee e
join Department d
on e.department_id = d.department_id
group by d.name
order by avg_salary desc;

--58.Select departments with more than 1 employee and an average salary greater than 55000.
select d.name, avg(e.salary) as avg_salary, count(*) as emp_count
from Employee e
join Department d
on e.department_id = d.department_id
group by d.name
having count(*) > 1 and avg(e.salary) > 55000;

--59.Select employees hired in the last 2 years, ordered by their hire date.
select name, hire_date
from Employee
where hire_date >= curdate() - interval 2 year
order by hire_date;

--60. . Select the total number of employees and the average salary for departments with more than 2 employees
select d.name, count(*) as total_employees, avg(e.salary) as avg_salary
from Employee e
join Department d
on e.department_id = d.department_id
group by d.name
having count(*) > 2;

--61. Select the name and salary of employees whose salary is above the average salary of their department.
select e.name, e.salary
from Employee e
where e.salary > (
    select avg(e2.salary)
    from Employee e2
    where e2.department_id = e.department_id
);

--62. Select the names of employees who are hired on the same date as the oldest employee in the company.
select name, hire_date
from Employee
where hire_date = (
    select min(hire_date)
    from Employee
);

--63. Select the department names along with the total number of projects they are working on, ordered by the number of projects.
select d.name, count(p.project_id) as project_count
from Department d
left join Project p
on d.department_id = p.department_id
group by d.name
order by project_count desc;

--64. Select the employee name with the highest salary in each department.
select e.name, d.name as department_name, e.salary
from Employee e
join Department d
on e.department_id = d.department_id
where e.salary = (
    select max(e2.salary)
    from Employee e2
    where e2.department_id = e.department_id
);

--65. Select the names and salaries of employees who are older than the average age of employees in their department.
select e.name, e.salary
from Employee e
where e.age > (
    select avg(e2.age)
    from Employee e2
    where e2.department_id = e.department_id
);








