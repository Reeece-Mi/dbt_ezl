{{ config(
    materialized='view',
    database='ezlicence-1506735963116',
    schema = 'au_foundation_view'
) }}


SELECT
   -- Primary Identifiers
   id AS instructor_dynamic_pricing_snapshot_id,
   instructor_user_id,
   snapshot_date,
   seo_region_id,
   
   -- Pricing Information 
   auto_price,
   manual_price,
   CASE 
    WHEN transmission = 0 then 'auto'
    WHEN transmission = 1 then 'manual'
    END as transmission,
   COALESCE(dynamic_pricing, FALSE) AS has_dynamic_pricing,
   
   -- Temporal Fields
   created_at,
   updated_at,
   
   -- Audit Fields
   CURRENT_TIMESTAMP() AS foundation_created_at,

FROM `ezlicence-1506735963116.au_production_2_bq.public_instructor_dynamic_pricing_snapshots`