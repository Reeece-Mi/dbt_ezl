{{ config(
    materialized='view',
    database='ezlicence-1506735963116',
    schema = 'au_foundation_view'
) }}
SELECT
    -- Primary Identifiers (with index awareness)
    id AS snapshot_id,          -- PRIMARY KEY, UNIQUE INDEX
    instructor_user_id,         -- INDEX
    
    -- Temporal Fields
    date AS snapshot_date,
    go_live_date AS instructor_go_live_date,
    created_at,                
    updated_at,           
    
    -- Status Fields
    CAST(status AS INT64) AS instructor_status_id,
    CASE 
        WHEN status = 0 THEN 'registered'
        WHEN status = 1 THEN 'profile_completed'
        WHEN status = 2 THEN 'avaliability_completed'
        WHEN status = 3 THEN 'pending'
        WHEN status = 4 THEN 'approved'
        WHEN status = 5 THEN 'rejected'
        WHEN status = 6 THEN 'document_expired'
        WHEN status = 7 THEN 'booking_disabled'
        WHEN status = 8 THEN 'deleted'
        WHEN status = 9 THEN 'pre_registered'
        ELSE 'unknown'
    END AS instructor_status_name,
    
    -- Boolean Settings
    COALESCE(public_search_disabled, FALSE) AS is_public_search_disabled,
    COALESCE(booking_disabled, FALSE) AS is_booking_disabled,
    COALESCE(blocked, FALSE) AS is_blocked,
    
    -- Audit Fields
    CURRENT_TIMESTAMP() AS foundation_created_at

FROM `ezlicence-1506735963116.au_production_2_bq.public_instructor_status_snapshots`