-- Stg com os motivos de vendas
With
    sales_reason as (
        select
            salesreasonid
            , reasontype
            , name
            , modifieddate
        from {{ source('adv_works', 'salesreason') }}
    )

    , transform as (
        select
            cast(salesreasonid as int) as sales_reason_id
            , cast(reasontype as string) as reason_type
            , cast(name as string) as name_reason
            , cast(modifieddate as date) as modified_date
        from sales_reason
    )

select *
from transform
