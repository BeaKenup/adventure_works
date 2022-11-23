With
    sales_reason as (
        select *
        from {{ ref('stg_adv_works_sales_reason') }}
    )

    , transform as (
        select
            row_number() over (order by sales_reason_id) as sales_reason_sk 
            , sales_reason_id
            , reason_type
            , name_reason
            , modified_date
        from sales_reason
    )

select *
from transform
