{{ config(
    materialized='view',
    database='ezlicence-1506735963116',
    schema = 'uk_foundation_view'
) }}

SELECT
   -- Primary Identifiers
   id AS seo_suburb_id,
   seo_region_id,
   suburb_polygon_id,         
   
   -- Location Information
   suburb,
   postcode,
   state,
   
   -- Temporal Fields
   created_at,
   updated_at,
   
   -- Audit Fields
   CURRENT_TIMESTAMP() AS foundation_created_at

FROM `ezlicence-1506735963116.uk_production_2_bq.seo_region_suburbs`