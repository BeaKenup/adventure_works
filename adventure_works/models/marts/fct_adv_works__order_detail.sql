--Realizado LEFT JOIN das tabelas salesorderdetail, salesorderheader e salesorderheadersalesreason para obter uma fato de pedidos mais completa, com a inclusão dos detalhes e a chave do motivo dos pedidos.
With
    order_header as (
        select *
        from {{ ref('stg_adv_works__order_header')}}
    )
    , order_detail as (
        select *
        from {{ ref('stg_adv_works__order_detail') }}
    )
    , order_reason as (
        select *
        from {{ ref('stg_adv_works__order_reason') }}
    )

-- Unindo a stg_adv_works_order_header com a stg_adv_works_order_reason, utilizando a sales_order_id
    , order_header_with_order_reason as (
        select             
            order_header.sales_order_id
            , order_header.sales_person_id
            , order_header.ship_to_address_id
            , order_reason.sales_reason_id
            , order_header.credit_card_id
            , order_header.customer_id
            , order_header.purchase_order_number
            , order_header.tax_amt
            , order_header.online_order_flag
            , order_header.order_date
            , order_header.credit_card_approval_code
            , order_header.sub_total
            , order_header.freight
            , order_header.due_date
            , order_header.total_due
            , order_header.ship_date
            , case 
                when order_header.status = 1 then "Em processo"
                when order_header.status = 2 then "Aprovado"
                when order_header.status = 3 then "Em espera"
                when order_header.status = 4 then "Rejeitado"
                when order_header.status = 5 then "Enviado"
                when order_header.status = 6 then "Cancelado"
            end as status
        from order_header
        left join order_reason on order_header.sales_order_id = order_reason.sales_order_id
    )
-- Acrescentando a stg_sdv_works_order_detail utilizando sales_order_id
    , final as (
        select
            order_header_with_order_reason.sales_order_id
            , order_header_with_order_reason.sales_person_id
            , order_header_with_order_reason.ship_to_address_id
            , order_header_with_order_reason.credit_card_id
            , order_header_with_order_reason.customer_id
            , order_header_with_order_reason.purchase_order_number
            , order_header_with_order_reason.tax_amt
            , order_header_with_order_reason.online_order_flag
            , order_header_with_order_reason.status
            , order_header_with_order_reason.order_date
            , order_header_with_order_reason.credit_card_approval_code
            , order_header_with_order_reason.sub_total
            , order_header_with_order_reason.freight
            , order_header_with_order_reason.due_date
            , order_header_with_order_reason.total_due
            , order_header_with_order_reason.ship_date
            , order_header_with_order_reason.sales_reason_id
            , order_detail.sales_order_detail_id
            , order_detail.product_id
            , order_detail.order_qty
            , order_detail.unit_price
            , order_detail.unit_price_discount
            , order_detail.unit_price - (order_detail.unit_price * order_detail.unit_price_discount) as unit_price_negocied
        from order_header_with_order_reason
        left join order_detail on order_header_with_order_reason.sales_order_id = order_detail.sales_order_id
    )

select *
from final