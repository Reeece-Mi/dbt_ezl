{{ config(
    materialized='view',
    database='ezlicence-1506735963116',
    schema = 'uk_foundation_view'
) }}


SELECT
   -- Primary Identifiers (with indices preserved)
   id AS sublocality_id,
   code AS sublocality_code,          
   locality,                          
   locality_slug,                     
   
   -- Location Hierarchy
   country_id,                        
   state_id,
  --  administrative_area_id,           
   administrative_area,
   suburb,
   state,
   postcode,
   
   -- Geographical Coordinates
--    center_lat,
--    center_lng,
--    latlngs,                          
--    geom,                             
--    centroid,                        
   
   -- Pricing Information
--    auto_price_per_hour,
--    final_auto_price_per_hour,
--    manual_price_per_hour,
--    final_manual_price_per_hour,
   
   -- Region Configuration
  --  except_regions,
  --  plus_regions,
   suburb_parameterize,
   
   -- Temporal Fields
   created_at,
   updated_at,
   
   -- Audit Fields
   CURRENT_TIMESTAMP() AS foundation_created_at

FROM `ezlicence-1506735963116.uk_production_2_bq.sublocalities`