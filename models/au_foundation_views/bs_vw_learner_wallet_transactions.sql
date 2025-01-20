SELECT
   -- Primary Identifiers (with indices)
   id AS learner_wallet_transactions_id,                   
   learner_user_id,                        
   learner_wallet_id,                      
   learner_wallet_transaction_id,          
   learner_wallet_event_id,                
   
   -- Transaction Source Information
   source_type,      
   source_id,                              
   
   -- Transaction Amounts (using DECIMAL for precision)
   CAST(cash_amount AS DECIMAL) AS cash_amount,
   CAST(bonus_amount AS DECIMAL) AS bonus_amount,
   CAST(account_amount AS DECIMAL) AS account_amount,
   
   -- Balance Information
   CAST(cash_balance AS DECIMAL) AS cash_balance,
   CAST(bonus_balance AS DECIMAL) AS bonus_balance,
   CAST(account_balance AS DECIMAL) AS account_balance,
   CAST(refundable_balance AS DECIMAL) AS refundable_balance,
   
   
   -- Temporal Fields (maintaining precision)
   created_at,
   updated_at,
   
   -- Audit Fields
   CURRENT_TIMESTAMP() AS foundation_created_at

FROM `ezlicence-1506735963116.au_production_2_bq.public_learner_wallet_transactions`