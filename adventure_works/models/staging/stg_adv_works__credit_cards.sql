-- staging da tabela com as informações de cartões de crédito
With
    credit_card as (
        select
            creditcardid
            , cardtype
            , expyear
            , modifieddate
            , expmonth
            , cardnumber
        from {{ source('adv_works', 'creditcard') }}
    )

    , transform as (
        select
        cast(creditcardid as int) as credit_card_id
        , cast(cardtype as string) as card_type
        , cast(expyear as int) as exp_year
        , cast(modifieddate as date) as modified_date
        , cast(cardnumber as int) as card_number
        , cast(expmonth as int) as exp_month
        from credit_card
    )

select *
from transform