select order_item_id, line_amount
from {{ ref('fct_orders') }}
where line_amount <= 0
