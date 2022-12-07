--Realizado LEFT JOIN das tabelas address, stateprovince e countryregion para obter uma dimensão de endereço mais completa, com a inclusão dos estados, pronvicias e países.
With
    address as (
        select *
        from {{ ref('stg_adv_works__address')}}
    )
    , state_province as (
        select *
        from {{ ref('stg_adv_works__state_province') }}
    )
    , country_region as (
        select *
        from {{ ref('stg_adv_works__country_region') }}
    )

-- Unindo a stg_adv_works_address com a stg_adv_works_state_province, utilizando a state_province_id
    , address_with_state_province as (
        select             
            address.address_id
            , address.state_province_id
            , state_province.territory_id
            , state_province.country_region_code
            , state_province.state_province_code     
            , address.address_line1
            , address.address_line2
            , address.city
            , address.modified_date
            , address.postal_code
            , address.spatial_location
            , state_province.name_state
            , state_province.is_only_state_province_flag
        from address
        left join state_province on address.state_province_id = state_province.state_province_id
    )
-- Acrescentando a stg_sdv_works_country_region utilizando country_region_code
    , final as (
        select
            row_number() over (order by address_id) as address_sk --auto incremental surrogate key
            , row_number() over (order by state_province_id) as state_province_sk --auto incremental surrogate key
            , address_with_state_province.address_id
            , address_with_state_province.state_province_id
            , address_with_state_province.territory_id
            , address_with_state_province.state_province_code
            , address_with_state_province.country_region_code 
            , address_with_state_province.address_line1
            , address_with_state_province.address_line2
            , address_with_state_province.city
            , address_with_state_province.modified_date
            , address_with_state_province.postal_code
            , address_with_state_province.spatial_location
            , address_with_state_province.name_state 
            , country_region.name_country     
        from address_with_state_province
        left join country_region on address_with_state_province.country_region_code = country_region.country_region_code
    )

select *
from final