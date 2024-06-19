select
--from raw orders
{{ dbt_utils.generate_surrogate_key(['o.orderid', 'c.customerid', 'p.productid']) }} as sk_orders,
o.orderid,
o.orderdate,
o.shipdate,
o.shipmode,
o.ordersellingprice - o.ordercostprice as orderprofit,
o.ordersellingprice,
o.ordercostprice,
---From raw customer
c.customerid,
c.customername,
c.segment,
c.country,
--From raw product
p.productid,
p.category,
p.productname,
p.subcategory,
{{ markup('ordersellingprice', 'ordercostprice' ) }} as markup, ---- for markup in macro folder
d.delivery_team ---for adding delivery team
FROM {{ ref('raw_orders') }} as o
--- for join with another table (raw_customers)
left join {{ ref('raw_customers') }} as c
--for joining specific id
on o.customerid = c.customerid
--- for join with another table (raw_product)
left join {{ ref('raw_product') }} as p
on o.productid = p.productid
---for adding delivery team
left join {{ ref('delivery_team') }} as d
on o.shipmode = d.shipmode

