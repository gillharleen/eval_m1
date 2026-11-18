select order_id, status
from {{ ref('silver_orders') }}
where status not in ('completed', 'shipped', 'cancelled')