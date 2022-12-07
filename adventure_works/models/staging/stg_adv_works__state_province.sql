-- Stg com os estados e provincias que será utilizada para compor a dim_full_adress
With
    state_province as (
        select
            stateprovinceid
            , countryregioncode
            , modifieddate
            , rowguid
            , name
            , territoryid
            , isonlystateprovinceflag
            , stateprovincecode
        from {{ source('adv_works', 'stateprovince') }}
    )

    , transform as (
        select
            cast(stateprovinceid as int) as state_province_id
            , cast(territoryid as int) as territory_id
            , cast(countryregioncode as string) as country_region_code 
            , cast(modifieddate as date) as modified_date 
            , cast(rowguid as string) as rowguid 
            , cast(name as string) as name_state 
            , cast(isonlystateprovinceflag as string) as is_only_state_province_flag 
            , cast(stateprovincecode as string) as state_province_code 
        from state_province
    )

select *
from transform

