With
    order_detail as (
        select
            salesorderid
            , salesorderdetailid
            , productid
            , specialofferid
            , orderqty
            , unitprice
            , modifieddate
            , rowguid
            , carriertrackingnumber
            , unitpricediscount
        from {{ source('adv_works', 'salesorderdetail') }}
    )

    , transform as (
        select
            cast(salesorderid as int) as sales_order_id
            , cast(salesorderdetailid as int) as sales_order_detail_id
            , cast(productid as int) as product_id
            , cast(specialofferid as int) as special_offer_id
            , cast(orderqty as int) as order_qty
            , cast(unitprice as float64) as unit_price
            , cast(modifieddate as date) as modified_date
            , cast(rowguid as string) as rowguid
            , cast(carriertrackingnumber as string) as carrier_tracking_number
            , cast(unitpricediscount as float64) as unit_price_discount
        from order_detail
    )

select *
from transform