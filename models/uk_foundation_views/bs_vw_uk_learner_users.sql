{{ config(
    materialized='view',
    database='ezlicence-1506735963116',
    schema = 'uk_foundation_view'
) }}

SELECT
   -- Primary Identifiers
   id AS learner_id,
--    email,
   
   -- User Profile
   first_name,
   last_name,
   date_of_birth,
--    phone_number,
--    formatted_phone_number,
   language_spoken,
   
   -- Location Information
   suburb,
   postcode,
   state,
   parameterize_suburb,
   suburb_polygon_id,
--    lat AS latitude,
--    lng AS longitude,
   
   -- Preferences
   preferred_transmission,
--    preferred_language,
   preferred_pickup_address,
--    preferred_car_type,
   preferred_pickup_address_lat,
   preferred_pickup_address_lng,
   
   -- Relationships
  --  instructor_user_id,
   current_instructor_id,
  --  refer_instructor_id,
   inviter_instructor_user_id,
   learner_referral_id,
   
   -- Parent/Guardian Information
   parent_first_name,
   parent_last_name,
   parent_phone_number,
   relationship,
   COALESCE(book_for_myself, FALSE) AS is_self_booking,
   
   -- Authentication & Security
   sign_in_count,
   current_sign_in_at,
   last_sign_in_at,
   current_sign_in_ip,
   last_sign_in_ip,
   access_token,
   CASE
    WHEN status = 0 THEN 'registered'
    WHEN status = 1 THEN 'profile_complete'
    END as status,
   
   -- Notification Preferences
   COALESCE(email_notification, TRUE) AS is_email_enabled,
   COALESCE(sms_notification, TRUE) AS is_sms_enabled,
   notification_setting_id,
   
   -- Payment Information
   stripe_uid,
   card_last_4,
   card_exp_month,
   card_exp_year,
   card_brand,
   COALESCE(save_card, FALSE) AS is_card_saved,
   COALESCE(refunding, FALSE) AS is_refunding,
   
   -- Feature Flags
   COALESCE(blocked, FALSE) AS is_blocked,
   COALESCE(k2d_used, FALSE) AS has_used_k2d,
   COALESCE(sign_up_with_coupon, FALSE) AS has_signup_coupon,
   COALESCE(confirm_password, FALSE) AS is_password_confirmed,
   COALESCE(completed_dkt, FALSE) AS has_completed_dkt,
   COALESCE(is_dkt_user, FALSE) AS is_dkt_user,
   COALESCE(test_user, FALSE) AS is_test_account,
   COALESCE(private_learner, FALSE) AS is_private_learner,
   COALESCE(propose_redirect, FALSE) AS needs_redirect,
   
   -- Marketing & Attribution
   source AS acquisition_source,
  --  sign_up_coupon_id,
   mailchimp_id,
   utm_campaign,
   utm_content,
   CAST(segmentation AS INT64) AS segment_id,
   
   -- Timestamps
   created_at,
   updated_at,
   
   -- Audit Fields
   CURRENT_TIMESTAMP() AS foundation_created_at,
   
   -- Derived Fields
   CONCAT(first_name, ' ', last_name) AS full_name,
   EXTRACT(YEAR FROM CURRENT_DATE()) - EXTRACT(YEAR FROM date_of_birth) AS approximate_age

FROM `ezlicence-1506735963116.uk_production_2_bq.learner_users`