{{ config(
    materialized='view'
) }}

with fail_record as (
    select *
    from {{ source('production', 'public_public_search_records') }}
    where result_count = 0 
    and date(created_at) > '2023-09-15'
    order by created_at desc
)

select 
    fail_record.suburb,
    event_tracking_type,
    transmission, 
    date(created_at) as date,
    geo_layers.State,
    geo_layers.MicroRegion,
    geo_layers.MacroRegion
from fail_record
left join `ezlicence-1506735963116.Dimensions.au_vw_geo_layers` geo_layers 
    on fail_record.suburb_polygon_id = geo_layers.suburb_polygon_id
where event_tracking_type is not null