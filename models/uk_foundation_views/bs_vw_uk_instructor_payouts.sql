{{ config(
    materialized='view',
    database='ezlicence-1506735963116',
    schema = 'uk_foundation_view'
) }}
SELECT
   -- Primary Identifiers
   id AS instructor_payout_id,
   instructor_user_id,
   payout_info_id,
   payout_id,
   stripe_transfer_id,
   
   -- Amounts & Fees
   amount,
   process_fee,
   monthly_surcharge_amount,
   reversed_amount,
   
   -- GST Information
   total_lesson_gst,
   total_ezlicence_gst,
   COALESCE(process_fee_consumption_tax, FALSE) AS has_process_fee_tax,
   process_fee_consumption_tax_percentage,
   
   -- Revenue Components
   total_lesson_price,
   total_test_package_price,
   COALESCE(total_private_booking_price, 0) AS total_private_booking_price,
   
   -- Status & Flags
   CASE
    WHEN status = 0 then 'success'
    WHEN status = 1 then 'transfer_failed'
    WHEN status = 2 then 'payout_failed'
   END AS status,
   COALESCE(monthly_fee_flag, FALSE) AS has_monthly_fee,
   
   -- Temporal Fields
   created_at,
   updated_at,
   
   -- Audit Fields
   CURRENT_TIMESTAMP() AS foundation_created_at

FROM `ezlicence-1506735963116.uk_production_2_bq.instructor_payouts`