With
    country_region as (
        select
            countryregioncode
            , name
            , modifieddate
        from {{ source('adv_works', 'countryregion') }}
    )

    , transform as (
        select
            cast(countryregioncode as string) as country_region_code
            , cast(name as string) as name_country     
            , cast(modifieddate as date) as modified_date
        from country_region
    )

select *
from transform