{{ config(
    materialized='view',
    database='ezlicence-1506735963116',
    schema = 'uk_foundation_view'
) }}


SELECT
    -- Primary Identifiers 
    id AS wallet_credit_id,                    
    learner_wallet_transaction_id,             
    instructor_payment_strategy_id,
    
    -- Credit Details
    CASE 
        WHEN credit_type = 0 THEN 'cash'
        WHEN credit_type = 1 THEN 'bonus'
        WHEN credit_type = 2 THEN 'account'
        ELSE 'unknown'
    END AS credit_type,
    CAST(credit_amount AS NUMERIC) AS credit_amount,  
    
    -- System Flags
    COALESCE(legacy_bmp, FALSE) AS is_legacy_bmp,    
    
    -- Timestamps (preserving microsecond precision)
    created_at,                                
    updated_at,                                
    
    -- Audit Fields
    CURRENT_TIMESTAMP() AS foundation_created_at

FROM `ezlicence-1506735963116.uk_production_2_bq.learner_wallet_credits`