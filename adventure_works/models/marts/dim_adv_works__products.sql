With
    products as (
        select *
        from {{ ref('stg_adv_works__products')}}
    )

    , transform as (
        select
            row_number() over (order by product_id) as product_sk --auto incremental surrogate key
            , product_id
            , sell_end_date
            , safety_stock_level
            , finished_goods_flag
            , make_flag
            , product_number
            , reorder_point
            , modified_date
            , row_guid
            , weight_unit_measure_code
            , standard_cost
            , name_products
            , style
            , size_unit_measure_code
            , list_price
            , days_to_manufacture
            , product_line
            , size
            , color
            , sell_start_date
            , weight
        from products
    )

select *
from transform