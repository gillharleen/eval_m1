select customer_id, initcap(trim(full_name)) as full_name, 
lower(trim(email)) as email, 
trim(city) as city, 
created_at from {{ ref('bronze_customers') }}
where customer_id is not null