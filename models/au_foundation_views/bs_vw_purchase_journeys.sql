{{ config(
    materialized='view',
    database='ezlicence-1506735963116',
    schema = 'au_foundation_view'
) }}

SELECT
   -- Primary Identifiers
   id AS purchase_journey_id,
   uid AS journey_uid,
   
   -- User References (preserving indices)
   learner_user_id,
   instructor_user_id,
   prestored_learner_user_id,
   admin_user_id,
   public_search_record_id,
   
   -- Journey State
   form_step,
   CASE
    WHEN status = 0 THEN 'initialized'
    WHEN status = 1 THEN 'paid'
    WHEN status = 2 THEN 'archived'
    WHEN status = 3 THEN 'payment_started'
   END as status,
   CASE
    WHEN flow = 0 THEN 'learner_signup'
    WHEN flow = 1 THEN 'add_credits'
    WHEN flow = 2 THEN 'new_bookings'
    WHEN flow = 3 THEN 'gift_card'
    WHEN flow = 4 THEN 'gift_card_redeem'
    WHEN flow = 5 THEN 'update_booking'
    WHEN flow = 6 THEN 'accept_proposal'
    WHEN flow = 7 THEN 'call_centre_admin'
   END as flow,
--    coupon_code,
   ip_address,
   
   -- Temporal Sequence
   attempt_started_on AS journey_start_time,
   last_active_at,
   status_updated_at,
   form_step_updated_at,
   created_at,
   updated_at,
   
   -- Audit Fields
   CURRENT_TIMESTAMP() AS foundation_created_at

FROM `ezlicence-1506735963116.au_production_2_bq.public_purchase_journeys`