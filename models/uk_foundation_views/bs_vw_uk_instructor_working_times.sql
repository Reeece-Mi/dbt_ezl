{{ config(
    materialized='view',
    database='ezlicence-1506735963116',
    schema = 'uk_foundation_view'
) }}


SELECT
   -- Primary Identifiers
   id AS instructor_working_time_id,
   instructor_working_day_id,
   
   -- Time Period
   start_time,
   end_time,
   
   -- Temporal Fields
   created_at,
   updated_at,
   
   -- Audit Fields
   CURRENT_TIMESTAMP() AS foundation_created_at,


FROM `ezlicence-1506735963116.uk_production_2_bq.instructor_working_times`