With
    customers as (
        select *
        from {{ ref('stg_adv_works__customers') }}
    )

    , person as (
        select *
        from {{ ref('stg_adv_works__person') }}

    )

    , transform as (
        select
            row_number() over (order by customer_id) as customer_sk
            , row_number() over (order by business_entity_id) as business_entity_sk
            , person.business_entity_id			
            , customers.customer_id
            , customers.person_id
            , person.first_name || " " || person.last_name as complete_name
            , person.first_name		
            , person.last_name		
            , person.suffix		
            , person.email_promotion		
            , person.title		
            , person.middle_name
        from customers
        left join person on customers.person_id = person.business_entity_id
    )

select *
from transform

