{{ config(
    materialized='view',
    database='ezlicence-1506735963116',
    schema = 'uk_foundation_view'
) }}
SELECT
    -- Primary Identifiers (with indices awareness)
    id AS payment_id,               -- PRIMARY KEY, UNIQUE INDEX
    learner_user_id,               -- INDEX
    instructor_user_id,
    paypal_pay_id,                 -- UNIQUE INDEX
    transaction_id,
    stripe_payment_intent_id,
    -- stripe_uid,
    stripe_token,
    payer_id,
    
    -- Payment Details
    CASE 
        WHEN payment_type = 0 THEN 'lesson'
        WHEN payment_type = 1 THEN 'test_package'
        WHEN payment_type = 2 THEN 'gift_card'
        WHEN payment_type = 3 THEN 'test_package_with_lesson'
        ELSE 'unknown'
    END AS payment_type,
    CAST(payment_method AS INT64) AS payment_method_id,
    CASE 
        WHEN payment_method = 1 THEN 'stripe_saved_card'
        WHEN payment_method = 2 THEN 'stripe_new_card'
        WHEN payment_method = 3 THEN 'paypal'
        WHEN payment_method = 4 THEN 'stripe_google_or_apple_pay'
        WHEN payment_method = 5 THEN 'stripe_afterpay_clearpay'
        WHEN payment_method = 6 THEN 'stripe_klarna'
        ELSE 'unknown'
    END AS payment_method,
    CASE 
        WHEN gate_way = 0 THEN 'stripe'
        WHEN gate_way = 1 THEN 'paypal'
        ELSE 'unknown'
    END AS gate_way,
    payment_source AS payment_source,     
    -- source AS source,
    payment_email,
    
    -- Monetary Values (using NUMERIC for precision)
    amount,
    CAST(credit_amount AS INT64) AS credit_amount,
    -- CAST(test_package_credit_amount AS INT64) AS test_package_credit_amount,
    ezl_revenue,
    lesson_total_price,            
    test_package_total_price,      
    original_lesson_amount,
    lesson_discount,
    cash_credits,
    process_fee,
    
    -- Billing Information
    billing_name,
    billing_address,
    postcode,
    suburb,
    state,
    suburb_polygon_id,
    currency,
    description,
    
    -- Invoice Details
    invoice_file_name,
    invoice_content_type,
    CAST(invoice_file_size AS INT64) AS invoice_file_size,
    invoice_updated_at,
    invoice_fingerprint,
    
    -- Purchase Details
    CAST(purchases AS INT64) AS purchases,
    -- CASE 
    --     WHEN campaign_type = 0 THEN 'free_lesson'
    --     WHEN campaign_type = 1 THEN 'price_25_percent_off'
    --     ELSE 'unknown'
    -- END AS campaign_type,
    purchase_journey_id,
    CASE 
        WHEN transmission = 0 THEN 'auto'
        WHEN transmission = 1 THEN 'manual'
        ELSE 'unknown'
    END AS transmission,
    proposed_group_id,
    
    -- Flags and Indicators
    COALESCE(payment_with_coupon, FALSE) AS has_coupon,    
    COALESCE(full_refunded, FALSE) AS is_fully_refunded,   
    COALESCE(instructor_proposal, FALSE) AS is_instructor_proposal,
    COALESCE(dynamic_pricing, FALSE) AS has_dynamic_pricing,
    
    -- Related References
    CAST(coupon_id AS INT64) AS coupon_id,
    
    -- Timestamps
    created_at,                    
    updated_at,                   
    gift_card_assigned_at,
    
    -- Audit Fields
    CURRENT_TIMESTAMP() AS foundation_created_at,

FROM `ezlicence-1506735963116.uk_production_2_bq.payments`

