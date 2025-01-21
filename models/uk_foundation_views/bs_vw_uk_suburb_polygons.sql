{{ config(
    materialized='view',
    database='ezlicence-1506735963116',
    schema = 'uk_foundation_view'
) }}


SELECT
   -- Primary Identifiers
   id AS suburb_polygons_id,
   state_id,
   
   -- Location Information
   state,
   postcode,
   suburb_parameterize AS suburb_slug,
   
   -- Geographical Coordinates
--    latlngs,               -- Text representation of coordinates
--    center_lat,
--    center_lng,
   
   -- Pricing Information
--    auto_price_per_hour,
--    final_auto_price_per_hour,
--    manual_price_per_hour,
--    final_manual_price_per_hour,
   
   -- Region Configuration
   except_regions,
   plus_regions,
   
   -- Temporal Fields
   created_at,
   updated_at,
   
   -- Audit Fields
   CURRENT_TIMESTAMP() AS foundation_created_at,

FROM `ezlicence-1506735963116.uk_production_2_bq.suburb_polygons`