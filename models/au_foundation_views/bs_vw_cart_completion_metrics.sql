{{ config(
    materialized='view',
    database='ezlicence-1506735963116',
    schema = 'au_foundation_view'
) }}

SELECT
   -- Primary Identifiers and References
   id AS cart_completion_metric_id,
   cart_id,
   purchase_journey_id,
   payment_id,
   learner_user_id,
   instructor_user_id,
   
   -- Payment Details
   payment_method,
   completion_duration,
   
      
   -- Total Credits
   total_credits,

   -- Credits Breakdown - Cash
   cash_credits_added_by_lesson,
   case when cash_credits_added_by_test_pack > 0 then 2.5 end as test_package_hours_of_credits_purchasededits_added_by_test_pack,
   cash_credits_added_by_lesson_shortfall,
   cash_credits_added_by_test_pack_shortfall,
   account_credits_added_by_dkt,
   reserved_account_credits,
   
   -- Credits Breakdown - Bonus
   bonus_credits_added_by_lesson,

   
   -- Hours Metrics
   equivalent_hours,
   blended_equivalent_hours,
   credits_added_by_lesson_equivalent_hours,
   
   -- Temporal Fields
   created_at,
   updated_at,
   
   -- Audit Fields
   CURRENT_TIMESTAMP() AS foundation_created_at

FROM `ezlicence-1506735963116.au_production_2_bq.public_cart_completion_metrics`