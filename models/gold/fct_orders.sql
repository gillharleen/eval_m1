{{ config(
    materialized='incremental',
    unique_key='order_item_id',
    incremental_strategy='delete+insert'
) }}

select
    oi.order_item_id,
    o.order_id,
    o.customer_id,
    oi.product_id,
    o.order_date,
    o.status,
    oi.quantity,
    oi.unit_price,
    oi.quantity * oi.unit_price as line_amount,
    o.updated_at,
    current_timestamp as dbt_loaded_at
from {{ ref('silver_orders') }} o
join {{ ref('silver_order_items') }} oi
    on oi.order_id = o.order_id

{% if is_incremental() %}
where o.updated_at > (select max(updated_at) from {{ this }})
{% else %}
where o.order_date >= '{{ var('start_date', '1900-01-01') }}'
{% endif %}
