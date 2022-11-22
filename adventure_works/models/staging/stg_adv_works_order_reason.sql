With
    order_reason as (
        select
            salesorderid
            , modifieddate
            , salesreasonid
        from {{ source('adv_works', 'salesorderheadersalesreason') }}
    )

    , transform as (
        select
            cast(salesorderid as int) as sales_order_id
            , cast(salesreasonid as int) as sales_reason_id
            , cast(modifieddate as date) as modified_date
        from order_reason
    )

select *
from transform