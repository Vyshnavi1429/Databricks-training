--Display all employee details.
select * from Employees;

--Display only employee names and salaries.
select emp_name,salary
from Employees;

--Display employee names and departments.
select emp_name,department
from Employees;

--Display all employees from the IT department.
select emp_name,department
from Employees
where department='IT';

--Display employee names and experience.
select emp_name,experience
from Employees;

--Find employees with salary greater than 70000.
select emp_name,salary
from Employees
where salary > 70000;

--Find employees working in Hyderabad.
select emp_name,city
from Employees
where city='Hyderabad';

--Find employees with experience less than 4 years.
select emp_name,experience
from Employees
where experience<4;

--Find employees from Finance department.
select emp_name,department
from Employees
where department='Finance';

--10 Find employees whose salary is equal to 52000.
select emp_name,salary
from Employees
where salary=52000;

--11 Find total salary department-wise.
select department,sum(salary)
from Employees
group by department;

--12 Find average salary in each department.
select department,avg(salary) as avg_sal
from Employees
group by department;

--13 Count employees in each city.
select city,count(*) as no_of_emp
from Employees
group by city;

--14 Find maximum salary in each department.
select department,max(salary)
from Employees
group by department;

--15 Find minimum experience department-wise.
select department,min(experience) as min_exp
from Employees
group by department;

--16 Find departments having more than 3 employees.
select department,count(*) as emp_count
from Employees
Group by department
having count(*)>3;

--17 Find departments where average salary is greater than 60000
select department,avg(salary) as avg_salary
from Employees
Group by department
having avg(salary)>60000

--18 Find cities having more than 2 employees.
select city, count(*) as emp_count
from Employees
group by city
having count(*) >2;

--19 Find departments where total salary is greater than 200000.
select department,sum(salary) as total_sal
from Employees
group by department
having sum(salary)>20000;

--20 Find departments where maximum salary is above 90000.
select department,max(salary) as max_sal
from Employees
group by department
having max(salary)>90000;

--21 Display top 5 highest paid employees.
select emp_name,salary
from Employees
order by salary desc
limit 5

--22 Display top 3 employees with highest experience.
select emp_name,experience
from Employees
order by experience desc
limit 3

--23 Display top 2 salaries from Finance department.
select  emp_name,salary
from Employees
where department='Finance'
order by salary desc
limit 2;

--24 Display top 4 employees from Hyderabad.
select  emp_name,city
from Employees
where city='Hyderabad'
limit 4;

--25 Display top 1 highest salary employee.
select  emp_name,salary
from Employees
order by salary desc
limit 1;

--26 Display distinct department names.
select distinct department
from Employees;

--27 Display distinct city names.
select distinct city
from Employees;

--28 Display distinct salary values.
select distinct salary
from Employees;

--29 Display distinct combinations of department and city.
select distinct department,city
from Employees;

--30 Display distinct experience values.
Display distinct experience values.

--31 Find employees with salary >= 80000.
select emp_name,salary
from Employees
where salary >= 80000

--32 Find employees with experience <= 3.
select emp_name,experience
from Employees
where experience <=3;

--33 Find employees whose salary <> 45000.
select emp_name,salary
from Employees
where salary <>45000;

--34 Find employees with salary < 50000
select emp_name,salary
from Employees
where salary <50000;

--35 Find employees with experience > 5.
select emp_name,experience
from Employees
where experience > 5;

--36 Find employees from IT department AND salary greater than 70000.
select *
from Employees
where department='IT' and salary>70000;

--37 Find employees from Hyderabad OR Bangalore.
select *
from Employees
where city='Hyderabad' or city='Bangalore';

--38 Find employees from HR department AND experience less than 3.
select *
from Employees
where department='HR' and experience< 3;
