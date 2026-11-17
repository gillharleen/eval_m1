select oi.order_item_id, o.order_id, o.customer_id, oi.product_id, 
o.order_date, o.status, oi.quantity, oi.unit_price, 
oi.quantity * oi.unit_price as line_amount, 
o.updated_at from {{ ref('silver_orders') }} o
join {{ ref('silver_order_items') }} oi 
on oi.order_id = o.order_id