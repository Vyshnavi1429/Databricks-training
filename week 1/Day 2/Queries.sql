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



