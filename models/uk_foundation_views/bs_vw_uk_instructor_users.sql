{{ config(
    materialized='view',
    database='ezlicence-1506735963116',
    schema = 'uk_foundation_view'
) }}

SELECT
   -- Primary Identifiers
   id AS instructor_id,
--    email,
   original_email,
   
   -- Personal Information
   first_name,
   last_name,
   preferred_name,
   date_of_birth,
   gender,
   phone_number,
   formatted_phone_number,
   original_phone_number,
   instructor_bio AS bio,
   background,
   
   -- Location Information
  --  city,
   postcode,
   state,
   country_id,
   timezone,
   seo_region_id,
   popular_suburb,
   in_priority_regions,
   
   -- Vehicle Details
   vehicle_make,
   vehicle_model,
   vehicle_year,
   vehicle_registration_number,
   vehicle_transmission,
   ANCAP_rating,
   dual_controls,
   
   -- Professional Details
   years_for_instructing,
   career_start_date,
   instructor_association_member,
   instructor_experience_id,
   CASE 
    WHEN transmission_type = 0 then 'auto'
    WHEN transmission_type = 1 then 'manual'
    END as transmission_type,
   business_type,
   lesson_travel_time,
   conflict_transmission_travel_time,
   instructor_product_service_ids,
   referal_code AS referral_code,
   language_spoken,
   
   -- Commission and Payouts
   commission_rate,
   promote_commission_rate,
   last_payout_date,
   CASE 
    WHEN payout_frequency = 7 then 'weekly'
    WHEN payout_frequency = 14 then 'fortnightly'
    WHEN payout_frequency = 28 then 'four_weeks'
    END as payout_frequency,
   
   -- Status and Settings
   CASE 
    WHEN status = 0 then 'registered'
    WHEN status = 1 then 'profile_completed'
    WHEN status = 2 then 'avaliability_completed'
    WHEN status = 3 then 'pending'
    WHEN status = 4 then 'approved'
    WHEN status = 5 then 'rejected'
    WHEN status = 6 then 'document_expired'
    WHEN status = 7 then 'booking_disabled'
    WHEN status = 8 then 'deleted'
    WHEN status = 9 then 'pre_registered'
   END as status,
   CASE 
    WHEN lifecycle = 0 then 'pre_register'
    WHEN lifecycle = 1 then 'training_complete'
    WHEN lifecycle = 2 then 'active_high'
    WHEN lifecycle = 3 then 'active_medium'
    WHEN lifecycle = 4 then 'active_low'
    WHEN lifecycle = 5 then 'inactive'
    WHEN lifecycle = 6 then 'churned_never_acquired'
    WHEN lifecycle = 7 then 'churned_voluntary'
    WHEN lifecycle = 8 then 'churned_involuntary'
    WHEN lifecycle = 9 then 'onboarding'
    END as lifecycle,
   COALESCE(blocked, FALSE) AS is_blocked,
   COALESCE(test_user, FALSE) AS is_test_account,
   COALESCE(keys2drive, FALSE) AS is_keys2drive,
   COALESCE(public_search_disabled, FALSE) AS is_search_disabled,
   COALESCE(booking_disabled, FALSE) AS is_booking_disabled,
   COALESCE(private_booking_enabled, FALSE) AS is_private_booking_enabled,
   COALESCE(is_smart_scheduling, FALSE) AS has_smart_scheduling,
   COALESCE(self_registered, FALSE) AS is_self_registered,
   COALESCE(ideal_instructor, FALSE) AS is_ideal_instructor,
   COALESCE(opening_hours_completed, FALSE) AS has_completed_hours,
   COALESCE(term_conditions_accepted, FALSE) AS has_accepted_terms,
   agreed_tscs_version,
   
   -- Notification Settings
   COALESCE(email_notification, FALSE) AS is_email_enabled,
   COALESCE(sms_notification, FALSE) AS is_sms_enabled,
   notification_setting_id,
   
   -- Security
   sign_in_count,
   current_sign_in_at,
   last_sign_in_at,
   current_sign_in_ip,
   last_sign_in_ip,
   access_token,
   COALESCE(two_fa_enabled, TRUE) AS is_2fa_enabled,
   second_factor_attempts_count,
   
   -- Important Dates
   go_live_date,
   first_booking_received,
   max_booking_date,
   availability_updated_at,
   
   -- System Fields
   mailchimp_id,
   created_at,
   updated_at,
   
   -- Audit Fields
   CURRENT_TIMESTAMP() AS foundation_created_at,
FROM `ezlicence-1506735963116.uk_production_2_bq.instructor_users`