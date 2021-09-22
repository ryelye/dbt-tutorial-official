select 
    order_id, 
    sum(amount) as total_amount
from {{ ref('stg_payments') }}
group by 1
having not(total_amount >= 0)

-- dbt test --data (to test data tests 9sql files in TEST file)