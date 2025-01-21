{{ config(
    materialized='view',
    database='ezlicence-1506735963116',
    schema = 'au_foundation_view'
) }}

SELECT
   -- Primary Identifiers
   id AS instructor_working_day_id,
   instructor_user_id,
   
   -- Schedule Information
   week_day,
   COALESCE(work_flag, TRUE) AS is_working_day,
   
   -- Temporal Fields
   created_at,
   updated_at,
   
   -- Audit Fields
   CURRENT_TIMESTAMP() AS foundation_created_at,

FROM `ezlicence-1506735963116.au_production_2_bq.public_instructor_working_days`