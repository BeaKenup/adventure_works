--Staging da tabela com as informações dos clientes
With
    customers as (
        select
            customerid
            , personid
            , territoryid
            , storeid
            , rowguid
            , modifieddate
        from {{ source('adv_works', 'customer') }}
    )

    , transform as (
        select
            cast(customerid as int) as customer_id
            , cast(personid as int) as person_id
            , cast(territoryid as int) as territory_id
            , cast(storeid as int) as store_id
            , cast(rowguid as string) as rowguid
            , cast(modifieddate as date) as modified_date
        from customers
    )

select *
from transform