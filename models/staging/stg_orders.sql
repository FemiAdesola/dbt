select
--from raw orders
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
{{ markup('ordersellingprice', 'ordercostprice' ) }} as markup ---- for markup in macro folder
FROM {{ ref('raw_orders') }} as o
--- for join with another table (raw_customers)
left join {{ ref('raw_customers') }} as c
--for joining specific id
on o.customerid = c.customerid
--- for join with another table (raw_product)
left join {{ ref('raw_product') }} as p
on o.productid = p.productid
