{{ config(
    materialized='view',
    database='ezlicence-1506735963116',
    schema = 'uk_foundation_view'
) }}


SELECT
    -- Primary Identifiers (maintaining composite uniqueness)
    id AS lifecycle_snapshot_id,                    
    instructor_user_id,                   
    date AS snapshot_date,                
    
    -- Lifecycle Information
    CASE 
        WHEN lifecycle = 0 THEN 'pre_register'
        WHEN lifecycle = 1 THEN 'training_complete'
        WHEN lifecycle = 2 THEN 'active_high'
        WHEN lifecycle = 3 THEN 'active_medium'
        WHEN lifecycle = 4 THEN 'active_low'
        WHEN lifecycle = 5 THEN 'inactive'
        WHEN lifecycle = 6 THEN 'churned_never_acquired'
        WHEN lifecycle = 7 THEN 'churned_voluntary'
        WHEN lifecycle = 8 THEN 'churned_involuntary'
        WHEN lifecycle = 9 THEN 'onboarding'
        ELSE 'unknown'
    END AS lifecycle,
    CAST(instructor_archive_reason_record_id AS INT64) AS archive_reason_id,
    
    -- Metrics
    CAST(gross_availability_14_days AS NUMERIC) AS availability_14d_hours,
    
    -- Temporal Fields (preserving precision)
    created_at,
    updated_at,

    -- Add audit columns
    CURRENT_TIMESTAMP() AS foundation_created_at

FROM `ezlicence-1506735963116.uk_production_2_bq.instructor_lifecycle_snapshots`