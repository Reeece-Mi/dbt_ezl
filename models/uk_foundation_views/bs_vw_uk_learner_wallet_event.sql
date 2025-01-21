{{ config(
    materialized='view',
    database='ezlicence-1506735963116',
    schema = 'uk_foundation_view'
) }}

SELECT
    -- Primary Identifiers 
    id AS wallet_event_id,        
    learner_user_id,              
    learner_wallet_id,            
    source_id,                    
    
    -- Event Classification
    LOWER(event_type) AS event_type,
    source_type,  
    
    -- Financial Fields (maintaining precision)
    CAST(amount AS NUMERIC) AS transaction_amount,    
    CAST(balance AS NUMERIC) AS wallet_balance, 
    
    -- Temporal Fields (maintaining microsecond precision)
    created_at,                   
    updated_at,                  
    
    -- Audit Fields
    CURRENT_TIMESTAMP() AS foundation_created_at

FROM `ezlicence-1506735963116.uk_production_2_bq.learner_wallet_events`
