--staging da tabela person com as informações das pessoas ligadas a empresa Adventure Works
With
    person as (
        select
            businessentityid
            , firstname
            , lastname
            , persontype
            , namestyle
            , suffix
            , modifieddate
            , rowguid
            , emailpromotion
            , title
            , middlename
        from {{ source('adv_works', 'person') }}
    )

    , transform as (
        select
            cast(businessentityid as int) as business_entity_id
            , cast(firstname as string) as first_name
            , cast(lastname as string) as last_name
            , cast(persontype as string) as person_type
            , cast(namestyle as string) as name_style
            , cast(suffix as string) as suffix
            , cast(modifieddate as date) as modified_date
            , cast(rowguid as string) as rowguid
            , cast(emailpromotion as string) as email_promotion
            , cast(title as string) as title
            , cast(middlename as string) as middle_name
        from person
    )

select *
from transform

