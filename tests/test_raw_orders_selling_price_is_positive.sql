with
    orders as (
select * from {{ ref('raw_orders') }} )

select orderid, 
sum(ordersellingprice) as total_sp 
from 
    orders
group by 
    orderid
---having order id that the selling price is less than Zero
having 
    total_sp<0