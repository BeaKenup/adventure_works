With
    products as (
        select
            productid
            , productmodelid
            , productsubcategoryid
            , sellenddate
            , safetystocklevel
            , finishedgoodsflag
            , class
            , makeflag
            , productnumber
            , reorderpoint
            , modifieddate
            , rowguid
            , weightunitmeasurecode
            , standardcost
            , name
            , style
            , sizeunitmeasurecode
            , listprice
            , daystomanufacture
            , productline
            , size
            , color
            , sellstartdate
            , weight
        from {{ source('adv_works', 'product') }}
    )

    , transform as (
        select
        cast(productid as int) as product_id
        , cast(productmodelid as int) as product_model_id
        , cast(productsubcategoryid as int) as product_sub_category_id
        , cast(sellenddate as date) as sell_end_date
        , cast(safetystocklevel as int) as safety_stock_level
        , cast(finishedgoodsflag as string) as finished_goods_flag
        , cast(class as string) as class
        , cast(makeflag as string) as make_flag
        , cast(productnumber as string) as product_number
        , cast(reorderpoint as int) as reorder_point
        , cast(modifieddate as date) as modified_date
        , cast(rowguid as string) as row_guid
        , cast(weightunitmeasurecode as string) as weight_unit_measure_code
        , cast(standardcost as float64) as standard_cost
        , cast(name as string) as name
        , cast(style as string) as style
        , cast(sizeunitmeasurecode as string) as size_unit_measure_code
        , cast(listprice as float64) as list_price
        , cast(daystomanufacture as int) as days_to_manufacture
        , cast(productline as string) as product_line
        , cast(size as string) as size
        , cast(color as string) as color
        , cast(sellstartdate as date) as sell_start_date
        , cast(weight as int) as weight
        from products
    )

select *
from transform