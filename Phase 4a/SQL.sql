--Task 1: Create Gold / Silver / Bronze Segmentation
select
    customer_id,
    sum(total_amount) as total_spend,
    case
        when sum(total_amount) > 10000 then 'gold'
        when sum(total_amount) between 5000 and 10000 then 'silver'
        else 'bronze'
    end as segment
from sales
group by customer_id;

--Task 2: Count Customers in Each Segmen
select
    segment,
    count(*)
from (
    select
        customer_id,
        case
            when sum(total_amount) > 10000 then 'gold'
            when sum(total_amount) between 5000 and 10000 then 'silver'
            else 'bronze'
        end as segment
    from sales
    group by customer_id
) t
group by segment;
