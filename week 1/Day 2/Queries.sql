--41. Select Employees who are not assigned to any project
    select e.name
from Employee e
left join Department d
on e.department_id = d.department_id
left join Project p
on d.department_id = p.department_id
where p.project_id is null;


