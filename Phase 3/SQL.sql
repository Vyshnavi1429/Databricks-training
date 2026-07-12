--1. Read sales data -> clean nulls -> calculate daily sales
select
    sale_date,
    sum(total_amount) as daily_sales
from sales
where sale_date is not null
  and total_amount is not null
group by sale_date
order by sale_date;

-- 2. Read customer data -> clean invalid rows -> city-wise revenue
select
    c.city,
    sum(s.total_amount) as total_revenue
from customers c
join sales s
on c.customer_id = s.customer_id
where c.city is not null
  and c.customer_id is not null
  and s.customer_id is not null
  and s.total_amount is not null
group by c.city
order by c.city;

--3. Find repeat customers (>2 orders)
from pyspark.sql.functions import count, col

result = (
    sales.groupBy("customer_id")
         .agg(count("*").alias("total_orders"))
         .filter(col("total_orders") > 2)
)

result.show()


--4. Find highest spending customer in each city
select
    city,
    customer_id,
    total_spend
from (
    select
        c.city,
        s.customer_id,
        sum(s.total_amount) as total_spend,
        row_number() over (
            partition by c.city
            order by sum(s.total_amount) desc
        ) as rn
    from sales s
    join customers c
    on s.customer_id = c.customer_id
    group by c.city, s.customer_id
) t
where rn = 1;

--5. Build final reporting table with customer, city, total spend, order count
select
    c.customer_id,
    c.first_name,
    c.last_name,
    c.city,
    sum(s.total_amount) as total_spend,
    count(*) as order_count
from customers c
join sales s
on c.customer_id = s.customer_id
group by
    c.customer_id,
    c.first_name,
    c.last_name,
    c.city;
