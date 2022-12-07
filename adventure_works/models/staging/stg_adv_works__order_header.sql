--staging da tabela salesorderheader com as informações de pedidos, que irá compor a fato
With
    order_header as (
        select
            shipmethodid
            , salesorderid
            , billtoaddressid
            , salespersonid
            , shiptoaddressid
            , territoryid
            , currencyrateid
            , creditcardid
            , customerid
            , purchaseordernumber
            , modifieddate
            , rowguid
            , taxamt
            , onlineorderflag
            , status
            , orderdate
            , creditcardapprovalcode
            , subtotal
            , revisionnumber
            , freight
            , duedate
            , totaldue
            , shipdate
            , accountnumber
        from {{ source('adv_works', 'salesorderheader') }}
    )

    , transform as (
        select
            cast(shipmethodid as int) as ship_method_id
            , cast(salesorderid as int) as sales_order_id
            , cast(billtoaddressid as int) as bill_to_address_id
            , cast(salespersonid as int) as sales_person_id
            , cast(shiptoaddressid as int) as ship_to_address_id
            , cast(territoryid as int) as territory_id
            , cast(currencyrateid as int) as currency_rate_id
            , cast(creditcardid as int) as credit_card_id
            , cast(customerid as int) as customer_id
            , cast(purchaseordernumber as string) as purchase_order_number
            , cast(modifieddate as date) as modified_date
            , cast(rowguid as string) as rowguid
            , cast(taxamt as float64) as tax_amt
            , cast(onlineorderflag as string) as online_order_flag
            , cast(status as int) as status
            , cast(orderdate as date) as order_date
            , cast(creditcardapprovalcode as string) as credit_card_approval_code
            , cast(subtotal as float64) as sub_total
            , cast(revisionnumber as int) as revision_number
            , cast(freight as float64) as freight
            , cast(duedate as date) as due_date
            , cast(totaldue as float64) as total_due
            , cast(shipdate as date) as ship_date
            , cast(accountnumber as string) as account_number
        from order_header
    )

select *
from transform