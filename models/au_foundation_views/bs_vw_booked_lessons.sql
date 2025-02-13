{{ config(
    materialized='view',
    database='ezlicence-1506735963116',
    schema = 'au_foundation_view'
) }}

SELECT
   -- Primary Identifiers
   id AS booked_lesson_id,
   learner_user_id,
   instructor_user_id,
   prestored_learner_user_id,
--    lesson_bulk_id,
   proposed_group_id,
   driving_test_location_id,
   
   -- Temporal Fields (Lesson Schedule)
   lesson_date,
   lesson_time, 
   start_time,
   end_time,
   
   -- Lesson Details
   CASE 
    WHEN transmission = 0 then 'auto'
    WHEN transmission = 1 then 'manual'
    END as transmission,
   type,
   CASE 
    WHEN proposed_lesson_category = 0 then 'lesson'
    WHEN proposed_lesson_category = 1 then 'test_package'
    END as proposed_lesson_category,
   CASE
    WHEN status = 0 then 'proposed'
    WHEN status = 1 then 'learner_confirmed'
    WHEN status = 2 then 'expired'
    WHEN status = 2 then 'rejected'
    WHEN status = 2 then 'removed_by_instructor'
    WHEN status = 2 then 'prestored_proposed'
   END AS status,

   -- Pickup Location
   pickup_address_street_number,
   pickup_address_street_name,
   pickup_address_street_type,
   pickup_address_region,
   COALESCE(use_default_pickup_address, TRUE) AS is_default_pickup,
   
   -- Dropoff Location
   dropoff_address_street_number,
   dropoff_address_street_name,
   dropoff_address_street_type,
   dropoff_address_region,
   COALESCE(use_default_dropoff_address, TRUE) AS is_default_dropoff,
   
   -- Additional Information
   instructor_note,
   
   -- Temporal Fields (System)
   created_at,
   updated_at,
   
   -- Audit Fields
   CURRENT_TIMESTAMP() AS foundation_created_at

FROM `ezlicence-1506735963116.au_production_2_bq.public_booked_lessons`