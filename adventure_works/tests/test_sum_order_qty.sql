With
    validation as (
        select sum(order_qty) as sum_validation
        from {{ref('fct_adv_works__order_detail')}}

    )

select *
from validation
where sum_validation = 274914