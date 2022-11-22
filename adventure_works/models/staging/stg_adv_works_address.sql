With
    address as (
        select
            addressid
            , stateprovinceid
            , addressline1
            , addressline2
            , city
            , modifieddate
            , rowguid
            , postalcode
            , spatiallocation
        from {{ source('adv_works', 'address') }}
    )

    , transform as (
        select
            cast(addressid as int) as address_id
            , cast(stateprovinceid as int) as state_province_id
            , cast(addressline1 as string) as address_line1
            , cast(addressline2 as string) as address_line2
            , cast(city as string) as city
            , cast(modifieddate as date) as modified_date
            , cast(rowguid as string) as rowguid
            , cast(postalcode as string) as postal_code
            , cast(spatiallocation as string) as spatial_location
        from address
    )

select *
from transform