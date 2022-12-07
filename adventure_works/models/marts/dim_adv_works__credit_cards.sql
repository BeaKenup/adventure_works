With
    credit_card as (
        select *
        from {{ ref('stg_adv_works__credit_cards') }}
    )

    , transform as (
        select
            row_number() over (order by credit_card_id) as credit_card_sk --autoincremental surrogate key
            , credit_card_id
            , card_type
            , exp_year
            , modified_date
            , card_number
            , exp_month
        from credit_card
    )

select *
from transform