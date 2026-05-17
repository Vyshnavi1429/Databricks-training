--1.For each employee Convert emp_name to proper case ---upper /lower ---Initcap (CamelCase)
select emp_name,
INITCAP(emp_name)as Proper_case
from employee_payments

--2 Calculate total income = base_salary + bonus (NULL safe)
select 
    emp_id,
    emp_name,
    base_salary,
    bonus,(base_salary + COALESCE(bonus,0)) AS total_income
from employee_payments;

--3 · Round total income to nearest integer
select base_salary + COALESCE(bonus,0) AS total_income,
round(base_salary + COALESCE(bonus,0)) AS rounded_income
from employee_payments;

--4 · Extract joining year
select emp_name,year(joining_date) as joining_year
from employee_payments;

--5 Senior if experience > 7 years, Mid if between 4 and 7, Junior otherwise
select emp_id, emp_name,joining_date,
timestampdiff(year,joining_date,curdate()) as experience,
case
when timestampdiff(year,joining_date,curdate()) > 7 then 'senior'
when timestampdiff(year,joining_date,curdate())  between 4 and  7 then 'mid'
else 'Junior'
end as emp_lev
from employee_payments;

--6 · Uppercase customer name
select customer_name,upper(customer_name)
as upper_case
from 
orders_delivery;

--7 · Calculate delivery days using date difference
select order_date,delivery_date,
datediff(delivery_date,order_date)as delivery_days
from orders_delivery;

--8 · Replace NULL delivery date with today
select order_id,delivery_date,
ifnull(delivery_date,curdate()) as delivery_date
from orders_delivery;

--9 · Truncate order amount to 1 decimal
select order_amount,
truncate(order_amount,1) as truncated_date
from orders_delivery;

--10· Use CASE: Same-day, Delayed (>3 days), Pending
select order_date,delivery_date,
case
when order_date = delivery_date then 'Same-Day'
when datediff(delivery_date,order_date)>3 then 'Delayed'
else
'Pending' end as delivery_output
from orders_delivery;

--11 · Customer name with first letter capitalized
select cust_name,
initcap(cust_name)
from customer_spending;

--12 · Month name of purchase
select cust_id,
month(purchase_date) as purchase_month
from customer_spending;

--13 · Rounded purchase amount
select purchase_amount,
round(purchase_amount) as rounded_amount
from customer_spending;

--14 Absolute value of purchase (defensive logic)
select purchase_amount,
abs(purchase_amount) as absolute_purchase_amount
from customer_spending;

--15 · CASE: High spender > 15000, Medium 8000–15000, Low otherwise
select cust_id,cust_name,purchase_amount,
case
when purchase_amount >15000 then 'High Spender'
when purchase_amount between 8000 and 15000 then 'Medium'
else 'Low'
end as Interest
from customer_spending;

--16 · Extract email domain
select user_id, user_email,
substring_index(user_email,'@',-1) as domain
from subscriptions;

--17 Calculate subscription duration in months
SELECT 
    user_id,
    user_email,
    start_date,
    end_date,

    TIMESTAMPDIFF(MONTH, start_date, end_date) AS subscription_months

FROM subscriptions;

--18 · Format fee with commas
select user_id,
format(subscription_fee,2) as formatted_fee
from subscriptions;

--19 Find remaining days from today
select user_id,end_date,
datediff(end_date,curdate()) as remain_days
from subscriptions;

--20 · CASE: Active, Expiring Soon (≤30 days), Expired

SELECT 
    user_id,
    user_email,
    end_date,

    DATEDIFF(end_date, CURDATE()) AS remaining_days,

    CASE
        WHEN DATEDIFF(end_date, CURDATE()) > 30 THEN 'Active'
        WHEN DATEDIFF(end_date, CURDATE()) BETWEEN 0 AND 30 THEN 'Expiring Soon'
        ELSE 'Expired'
    END AS subscription_status

FROM subscriptions;

--table 5: loan emi risk categorization
select
    loan_id,
    upper(customer_name) as customer_name,
    round((loan_amount * interest_rate / 100) / 12) as monthly_interest,
    timestampdiff(year,loan_start,curdate()) as years_since_loan,
    round(loan_amount / 12) as emi,
    case
        when interest_rate > 9 then 'high risk'
        when interest_rate between 8 and 9 then 'medium risk'
        else 'low risk'
    end as risk_level
from loan_details;

--table 6: employee attendance evaluation
select
    emp_id,
    lower(emp_name) as employee_name,
    round((present_days / total_days) * 100,2) as attendance_percentage,
    monthname(record_date) as month_name,
    total_days - present_days as absent_days,
    case
        when ((present_days / total_days) * 100) >= 90 then 'excellent'
        when ((present_days / total_days) * 100) between 75 and 89 then 'average'
        else 'poor'
    end as attendance_status
from attendance;

--table 7:product discount validation
select
    product_id,
    concat(upper(left(product_name,1)),lower(substring(product_name,2))) as product_name,
    abs(mrp - selling_price) as discount_amount,
    round(((mrp - selling_price) / mrp) * 100,2) as discount_percentage,
    dayname(sale_date) as sale_day,
    case
        when selling_price < mrp then 'valid discount'
        when selling_price > mrp then 'overpriced'
        else 'no discount'
    end as discount_status
from product_sales;

--table 8: insurance policy aging
select
    policy_id,
    upper(holder_name) as holder_name,
    timestampdiff(year,policy_start,policy_end) as policy_duration,
    datediff(policy_end,curdate()) as remaining_days,
    round(premium_amount) as rounded_premium,
    case
        when timestampdiff(year,policy_start,policy_end) >= 5 then 'long term'
        when timestampdiff(year,policy_start,policy_end) between 2 and 4 then 'mid term'
        else 'expired'
    end as policy_status
from insurance_policies;

--table 9: salary increment simulation
select
    emp_id,
    lower(emp_name) as employee_name,
    timestampdiff(year,last_hike,curdate()) as years_since_hike,
    case
        when rating = 5 then current_salary * 0.20
        when rating = 4 then current_salary * 0.10
        when rating = 3 then current_salary * 0.05
        else 0
    end as increment_amount,
    round(
        current_salary +
        case
            when rating = 5 then current_salary * 0.20
            when rating = 4 then current_salary * 0.10
            when rating = 3 then current_salary * 0.05
            else 0
        end
    ) as new_salary,
    case
        when rating = 5 then 'high increment'
        when rating = 4 then 'moderate'
        else 'no increment'
    end as increment_status
from salary_revision;

--table 10: customer account status evaluation
select
    account_id,
    abs(balance) as absolute_balance,
    datediff(curdate(),last_transaction) as days_since_transaction,
    concat(upper(left(branch,1)),lower(substring(branch,2))) as branch_name,
    sign(balance) as balance_sign,
    case
        when balance < 0 then 'overdrawn'
        when datediff(curdate(),last_transaction) > 365 then 'dormant'
        else 'active'
    end as account_status
from bank_accounts;

--Level 1:salary risk flagging based on tax shock
select
    emp_id,
    lower(emp_name) as employee_name,
    round(salary - (salary * tax_percent / 100)) as net_salary,
    year(last_revision) as revision_year,
    timestampdiff(month,last_revision,curdate()) as months_since_revision,
    case
        when tax_percent > 20 and timestampdiff(month,last_revision,curdate()) > 24 then 'tax shock'
        when tax_percent between 15 and 20 then 'review needed'
        else 'stable'
    end as salary_status
from salary_audit;

--Level 2:  bonus abuse detection
select
    emp_code,
    concat(upper(left(emp_name,1)),lower(substring(emp_name,2))) as employee_name,
    round((bonus / base_salary) * 100,2) as bonus_percentage,
    dayname(bonus_date) as bonus_day,
    abs(base_salary - bonus) as salary_bonus_difference,
    case
        when ((bonus / base_salary) * 100) > 30
             and dayname(bonus_date) in ('saturday','sunday') then 'suspicious'
        when ((bonus / base_salary) * 100) <= 20 then 'normal'
        else 'audit'
    end as bonus_status
from bonus_monitor;

--Level 3: experience parity validation
select
    emp_id,
    upper(emp_name) as employee_name,
    timestampdiff(year,joining_date,curdate()) as actual_experience,
    declared_experience - timestampdiff(year,joining_date,curdate()) as experience_difference,
    floor(salary) as floor_salary,
    case
        when declared_experience > timestampdiff(year,joining_date,curdate()) then 'overstated'
        when declared_experience < timestampdiff(year,joining_date,curdate()) then 'understated'
        else 'matched'
    end as validation_status
from employee_experience;

--level 4 :salary digit pattern analysis
select    emp_id,
    right(emp_name,2) as last_two_characters,
    day(credit_date) as credit_day,
    truncate(salary,0) as truncated_salary,
    mod(salary,10) as salary_mod,
    case
        when mod(salary,10) = day(credit_date) then 'pattern match'
        else 'no match'
    end as pattern_status
from salary_digits;

--level 5: odd-even salary compliance
select
    emp_id,
    lower(emp_name) as employee_name,
    dayname(payment_date) as weekday_name,
    round(salary) as rounded_salary,
    mod(round(salary),2) as salary_mod,
    case
        when mod(round(salary),2) = 0
             and dayofweek(payment_date) in (2,4,6) then 'violation'
        else 'compliant'
    end as compliance_status
from payroll_control;

--level 6: salary inflation drift
select 
    emp_id,
    concat(upper(left(emp_name,1)),lower(substring(emp_name,2))) as proper_name,
    timestampdiff(year,last_hike,curdate()) as years_since_hike,
    power(timestampdiff(year,last_hike,curdate()),2) as power_years,
    round(salary * power(timestampdiff(year,last_hike,curdate()),2),2) as salary_impact,
    case
        when timestampdiff(year,last_hike,curdate()) > 5 then 'high inflation risk'
        when timestampdiff(year,last_hike,curdate()) between 3 and 5 then 'moderate'
        else 'low'
    end as inflation_status
from inflation_watch;


--level 7: salary sign integrity check
 select emp_id,
    upper(emp_name) as employee_name,
    year(record_date) as record_year,
    sign(salary) as salary_sign,
    abs(salary) as absolute_salary,
    case
        when sign(salary) = -1 then 'negative error'
        when sign(salary) = 0 then 'zero salary'
        else 'valid'
    end as salary_status
from salary_integrity;

--level 8: name length vs salary correlation
select 
    emp_id,
    length(emp_name) as name_length,
    timestampdiff(year,join_date,curdate()) as years_of_service,
    round(salary) as rounded_salary,
    case
        when length(emp_name) > timestampdiff(year,join_date,curdate()) then 'name bias'
        else 'neutral'
    end as comparison_status
from name_salary;

--level 9: salary spike detection by month
select 
    emp_id,
    monthname(paid_date) as month_name,
    ceil(salary) as ceil_salary,
    last_day(paid_date) as month_last_day,
    case
        when paid_date = last_day(paid_date) then 'end month spike'
        else 'regular'
    end as salary_status
from salary_monthly;

--level 10: salary digit sum audit
select 
    emp_id,
    left(emp_name,1) as first_character,
    truncate(salary,0) as truncated_salary,
    mod(truncate(salary,0),9) as logical_digit_sum,
    day(audit_date) as audit_day,
    case
        when mod(truncate(salary,0),9) = day(audit_date) then 'digit alert'
        else 'normal'
    end as audit_status
from digit_audit;

--level 11: weekend salary credit fraud detection
select 
    emp_id,
    left(bank_code,4) as bank_prefix,
    dayname(credit_date) as weekday_name,
    round(salary) as rounded_salary,
    mod(round(salary),5) as salary_mod,

    case
        when dayname(credit_date) in ('saturday','sunday')
             and mod(round(salary),5) = 0
        then 'weekend fraud'

        when left(bank_code,4) = 'HDFC'
        then 'bank review'

        else 'normal'
    end as fraud_status

from salary_credit_audit;

--level 12: salary credit time drift analysis
select 
    emp_id,
    hour(credit_ts) as credit_hour,
    lower(emp_name) as employee_name,
    floor(salary) as floor_salary,
    abs(floor(salary) - hour(credit_ts)) as salary_hour_difference,

    case
        when hour(credit_ts) between 0 and 3 then 'midnight drift'
        when hour(credit_ts) > 18 then 'after hours'
        else 'business hours'
    end as drift_status

from salary_time_drift;

--question 13 – salary decimal precision audit
select 
    emp_id,
    truncate(salary,2) as truncated_salary,

    round(salary,2) - truncate(salary,2)
    as precision_difference,

    dayname(record_date) as weekday_name,

    length(emp_name) as name_length,

    case
        when round(salary,2) - truncate(salary,2) > 0.01
        then 'precision loss'
        else 'safe'
    end as precision_status

from salary_precision;

--question 14 – salary growth power index
select 
    emp_id,

    timestampdiff(year,last_hike,curdate())
    as years_since_hike,

    power(
        growth_rate,
        timestampdiff(year,last_hike,curdate())
    ) as growth_power,

    round(
        base_salary * power(
            growth_rate,
            timestampdiff(year,last_hike,curdate())
        ),2
    ) as projected_salary,

    upper(emp_name) as employee_name,

    case
        when round(
            base_salary * power(
                growth_rate,
                timestampdiff(year,last_hike,curdate())
            ),2
        ) > 150000
        then 'explosive growth'

        when round(
            base_salary * power(
                growth_rate,
                timestampdiff(year,last_hike,curdate())
            ),2
        ) between 100000 and 150000
        then 'controlled'

        else 'stagnant'
    end as growth_status

from salary_growth;

--question 15 – salary symmetry check
select 
    emp_id,

    replace(salary,'.','')
    as salary_without_decimal,

    reverse(replace(salary,'.',''))
    as reversed_salary,

    dayname(processed_date) as weekday_name,

    concat(
        upper(left(emp_name,1)),
        lower(substring(emp_name,2))
    ) as proper_name,

    case
        when replace(salary,'.','') =
             reverse(replace(salary,'.',''))
        then 'symmetric pay'

        else 'asymmetric'
    end as symmetry_status

from salary_symmetry;

--question 16 – leap year salary adjustment audit
select 
    emp_id,

    year(credit_date) as credit_year,

    ceil(salary) as ceil_salary,

    dayofyear(credit_date) as day_number,

    case
        when (year(credit_date) % 4 = 0
              and year(credit_date) % 100 != 0)
              or year(credit_date) % 400 = 0
        then 'leap credit'

        else 'non-leap credit'
    end as leap_status

from leap_salary;

--question 17 – fiscal year boundary salary check
select 
    emp_id,

    case
        when month(credit_date) >= 4
        then concat(
            year(credit_date),
            '-',
            year(credit_date)+1
        )

        else concat(
            year(credit_date)-1,
            '-',
            year(credit_date)
        )
    end as fiscal_year,

    monthname(credit_date) as month_name,

    format(salary,2) as formatted_salary,

    lower(emp_name) as employee_name,

    case
        when month(credit_date) = 3
        then 'year end credit'

        when month(credit_date) = 4
        then 'year start credit'

        else 'mid year'
    end as fiscal_status

from fiscal_salary;


--question 18 – salary random sampling for audit
select 
    emp_id,

    rand() as random_value,

    round(salary) as rounded_salary,

    dayname(record_date) as weekday_name,

    left(emp_name,1) as first_character,

    case
        when rand() > 0.7
        then 'sampled'

        else 'skipped'
    end as sample_status

from salary_sampling;

--question 19 – salary ascii integrity check
select 
    emp_id,

    ascii(left(emp_name,1))
    as ascii_value,

    timestampdiff(year,join_date,curdate())
    as years_since_joining,

    floor(salary) as floor_salary,

    case
        when ascii(left(emp_name,1)) >
             timestampdiff(year,join_date,curdate())
        then 'name dominates'

        else 'experience dominates'
    end as integrity_status

from salary_ascii;


--question 20 – salary vs calendar symmetry logic

select 
    emp_id,

    day(credit_date) as credit_day,

    month(credit_date) as credit_month,

    right(truncate(salary,0),2)
    as last_two_digits,

    upper(emp_name) as employee_name,

    abs(day(credit_date) - month(credit_date))
    as day_month_difference,

    case
        when day(credit_date) = month(credit_date)
             or right(truncate(salary,0),2) =
                lpad(month(credit_date),2,'0')
        then 'calendar match'

        else 'calendar drift'
    end as calendar_status

from salary_calendar;

--question 1 – employee login discipline & performance classification
select 
    emp_id,

    concat(
        upper(left(emp_name,1)),
        lower(substring(emp_name,2))
    ) as proper_name,

    case
        when dayname(login_time)
             in ('saturday','sunday')
        then 'weekend'

        else 'weekday'
    end as login_type,

    round(
        timestampdiff(
            minute,
            login_time,
            logout_time
        ) / 60,
        2
    ) as working_hours,

    case
        when dayname(login_time)
             not in ('saturday','sunday')
             and (
                timestampdiff(
                    minute,
                    login_time,
                    logout_time
                ) / 60
             ) >= 8
        then 'good performer'

        when dayname(login_time)
             not in ('saturday','sunday')
             and (
                timestampdiff(
                    minute,
                    login_time,
                    logout_time
                ) / 60
             ) < 6
        then 'bad performer'

        else 'weekend login'
    end as performance_status

from employee_login;


--question 2 – past 7 days attendance & productivity check
select 
    emp_id,

    upper(emp_name) as employee_name,

    case
        when login_date >=
             curdate() - interval 7 day
        then 'within 7 days'

        else 'older'
    end as attendance_period,

    case
        when dayname(login_date)
             in ('saturday','sunday')
        then 'weekend'

        else 'weekday'
    end as day_type,

    timediff(logout_time,login_time)
    as working_hours,

    case
        when login_date >=
             curdate() - interval 7 day
             and time_to_sec(
                 timediff(
                    logout_time,
                    login_time
                 )
             ) / 3600 >= 8
        then 'active & productive'

        when login_date >=
             curdate() - interval 7 day
             and time_to_sec(
                 timediff(
                    logout_time,
                    login_time
                 )
             ) / 3600 < 8
        then 'active but low hours'

        else 'absent from last 7 days'
    end as productivity_status

from attendance_log;


--question 3 – weekend work abuse detection
select 
    emp_id,

    dayname(work_date) as weekday_name,

    lower(emp_name) as employee_name,

    ceil(
        time_to_sec(
            timediff(
                logout_time,
                login_time
            )
        ) / 3600
    ) as working_hours,

    case
        when dayname(work_date)
             in ('saturday','sunday')
             and time_to_sec(
                 timediff(
                    logout_time,
                    login_time
                 )
             ) / 3600 >= 8
        then 'weekend overtime'

        when dayname(work_date)
             in ('saturday','sunday')
             and time_to_sec(
                 timediff(
                    logout_time,
                    login_time
                 )
             ) / 3600 < 4
        then 'suspicious login'

        else 'normal working day'
    end as abuse_status

from weekend_monitor;


--question 4 – login time deviation & discipline score
select 
    emp_id,

    hour(login_datetime)
    as login_hour,

    truncate(
        timestampdiff(
            minute,
            login_datetime,
            logout_datetime
        ) / 60,
        1
    ) as working_hours,

    dayname(login_datetime)
    as weekday_name,

    case
        when dayname(login_datetime)
             not in ('saturday','sunday')
             and hour(login_datetime) < 9
             and (
                timestampdiff(
                    minute,
                    login_datetime,
                    logout_datetime
                ) / 60
             ) >= 8
        then 'disciplined'

        when dayname(login_datetime)
             not in ('saturday','sunday')
             and hour(login_datetime) > 10
        then 'late comer'

        else 'poor discipline'
    end as discipline_status

from login_discipline;


--question 5 – absenteeism vs performance correlation
select 
    emp_id,

    case
        when work_date >=
             curdate() - interval 7 day
        then 'recent'

        else 'old'
    end as work_period,

    case
        when dayname(work_date)
             in ('saturday','sunday')
        then 'weekend'

        else 'weekday'
    end as day_type,

    floor(
        time_to_sec(
            timediff(
                logout_time,
                login_time
            )
        ) / 3600
    ) as total_hours,

    case
        when work_date >=
             curdate() - interval 7 day
             and dayname(work_date)
                 not in ('saturday','sunday')
             and time_to_sec(
                 timediff(
                    logout_time,
                    login_time
                 )
             ) / 3600 >= 8
        then 'consistent performer'

        when time_to_sec(
                 timediff(
                    logout_time,
                    login_time
                 )
             ) / 3600 < 6
        then 'irregular performer'

        else 'absent / old record'
    end as performance_status

from performance_tracker;








































