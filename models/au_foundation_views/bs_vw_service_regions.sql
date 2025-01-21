{{ config(
    materialized='view',
    database='ezlicence-1506735963116',
    schema = 'au_foundation_view'
) }}

SELECT
   -- Primary Identifiers 
   id AS service_region_id,
   instructor_user_id,        -- INDEXED
   suburb_polygon_id,         -- INDEXED
   
   -- Location Information
   suburb,                    -- INDEXED
   postcode,                  -- INDEXED
   state,
--    lat AS latitude,
--    lng AS longitude,
   
   -- Metrics
   COALESCE(popularity, 0) AS popularity,
   
   -- Temporal Fields
   created_at,
   updated_at,
   
   -- Audit Fields
   CURRENT_TIMESTAMP() AS foundation_created_at

FROM `ezlicence-1506735963116.au_production_2_bq.public_service_regions`