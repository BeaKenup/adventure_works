With
    customers as (
        select *
        from {{ ref('stg_adv_works_customers') }}
    )

    , transform as (
        select
            row_number() over (order by customer_id) as customer_sk
            , customer_id
            , person_id
            , territory_id
            , store_id
            , rowguid
            , modified_date
        from customers
    )

select *
from transform