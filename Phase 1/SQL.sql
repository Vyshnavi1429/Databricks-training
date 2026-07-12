--1. Total order amount for each customer
select
    customer_id,
    sum(total_amount) as total_spend
from sales
group by customer_id
order by total_spend desc;

--2. Top 3 customers by total spend
select
    c.customer_id,
    c.customer_name,
    sum(s.total_amount) as total_spend
from customers c
join sales s
on c.customer_id = s.customer_id
group by c.customer_id, c.customer_name
order by total_spend desc;

--3. Customers with no orders
select
    c.customer_id,
    c.customer_name
from customers c
left join sales s
on c.customer_id = s.customer_id
where s.customer_id is null;

--4. City-wise total revenue
select
    c.city,
    sum(s.total_amount) as total_revenue
from customers c
join sales s
on c.customer_id = s.customer_id
group by c.city
order by total_revenue desc;

--5. Average order amount per customer
select
    customer_id,
    avg(total_amount) as average_order_amount
from sales
group by customer_id
order by customer_id;

--6. Customers with more than one order
select
    customer_id,
    count(*) as total_orders
from sales
group by customer_id
having count(*) > 1;

--7. Sort customers by total spend descending
select
    customer_id,
    sum(total_amount) as total_spend
from sales
group by customer_id
order by total_spend desc;






