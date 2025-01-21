{{ config(
    materialized='view',
    database='ezlicence-1506735963116',
    schema = 'uk_foundation_view'
) }}


SELECT
    -- Primary Identifiers (with original indices preserved)
    id AS instructor_payment_id,
    instructor_user_id,
    learner_user_id,
    calendar_item_id,
    payment_id,
    instructor_payout_id,
    
    -- Payment Amounts
    amount AS payment_amount,
    original_amount,
    total_amount,
    
    -- Commission Details
    commission AS commission_amount,
    original_commission,
    commission_discount_amount,
    original_commission_discount_amount,
    commission_discount_rate,
    
    -- Additional Payment Fields
    reimburse_amount AS reimbursement_amount,
    take_more AS additional_take_amount,
    booking_value_at_authorisation AS booking_auth_value,
    
    -- Boolean Flags
    COALESCE(transfer_flag, FALSE) AS is_transferred,
    COALESCE(private_payment, FALSE) AS is_private_payment,
    COALESCE(dynamic_pricing, FALSE) AS has_dynamic_pricing,
    COALESCE(overrule, FALSE) AS is_overruled,
    COALESCE(is_dkt, FALSE) AS is_driver_knowledge_test,
    
    -- Reference IDs
    instructor_special_commission_id,
    incentive_id,
    experiment_group_id,
    
    -- Temporal Fields
    created_at,
    updated_at,
    
    -- Audit Fields
    CURRENT_TIMESTAMP() AS foundation_created_at

FROM `ezlicence-1506735963116.uk_production_2_bq.instructor_payments`