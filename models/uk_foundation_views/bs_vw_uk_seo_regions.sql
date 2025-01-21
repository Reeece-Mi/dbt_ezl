{{ config(
    materialized='view',
    database='ezlicence-1506735963116',
    schema = 'uk_foundation_view'
) }}
SELECT
   -- Primary Identifiers
   id AS seo_region_id,
   city_region_id,
   country_id,
   
   -- Region Information
   region_name,            -- Indexed
   region_path,
   state,
   
   -- Pricing
  --  auto_price_per_hour,
  --  manual_price_per_hour,
   
   -- Geographic Data
--    coverage_polygon,
--    coverage_center,
--    geojson,
   
   -- Temporal Fields  
   created_at,
   updated_at,
   
   -- Audit Fields
   CURRENT_TIMESTAMP() AS foundation_created_at,

FROM `ezlicence-1506735963116.uk_production_2_bq.seo_regions`