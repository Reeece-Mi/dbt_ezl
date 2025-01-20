{{ config(
    materialized='view',
    database='ezlicence-1506735963116',
    schema = 'au_foundation_view'
) }}

SELECT
    -- Primary Identifiers (with original indices preserved)
    id AS calendar_item_id,  
    instructor_user_id,      
    learner_user_id,       
    booking_group_identifier_id, 
    
    -- Event Classification
    type AS event_type,           
    CASE    
        WHEN status = 1 THEN 'waiting_for_confirm'
        WHEN status = 2 THEN 'confirmed'
        WHEN status = 3 THEN 'rejected'
        WHEN status = 4 THEN 'cancelled'
        WHEN status = 5 THEN 'unsuccessful'
    END as status,  
    
    CASE    
        WHEN activity = 0 THEN 'message_delivered'
        WHEN activity = 1 THEN 'site_action_performed'
        WHEN activity = 2 THEN 'detail_viewed'
    END as activity,

    CASE    
        WHEN instructor_event_type = 0 THEN 'manual'
        WHEN instructor_event_type = 1 THEN 'auto'
        WHEN instructor_event_type = 2 THEN 'private_event'
    END as instructor_event_type,
    
    -- Temporal Fields (maintaining index awareness)
    start_time,            
    end_time,               
    pickup_time,
    created_at,             
    updated_at,             
    proposed_at,
    source,
    
    -- Event Details
    -- CAST(learner_credits_required AS INT64) AS credits_required,
    lesson_create_user_type,
    NULLIF(token_lessons, '') AS token_lessons,
    NULLIF(unsupervised_driving_hours, '') AS unsupervised_driving_hours,
    CASE    
        WHEN transmission = 0 THEN 'auto'
        WHEN transmission = 1 THEN 'manual'
    END as transmission,
    
    -- Location Information (with index awareness)
    address,
    postcode,               
    state,                 
    region,
    preferred_pickup_region,
    
    -- Pickup Address Components
    pickup_address,
    pickup_address_suburb,
    pickup_address_postcode,
    pickup_address_state,
    pickup_address_street_number,
    pickup_address_street_name,
    pickup_address_street_type,
    pickup_suburb_polygon_id,
    
    -- Dropoff Address Components
    dropoff_address,
    dropoff_address_suburb,
    dropoff_address_postcode,
    dropoff_address_state,
    dropoff_address_street_number,
    dropoff_address_street_name,
    dropoff_address_street_type,
    dropoff_suburb_polygon_id,
    
    -- Travel Times (preserving defaults)
    event_travel_time_before,        
    event_travel_time_after,         
    event_conflict_transmission_travel_time_before, 
    event_conflict_transmission_travel_time_after,  
    
    -- Boolean Flags (preserving defaults)
    COALESCE(calendar_flag, TRUE) AS is_calendar_visible,         -- DEFAULT true
    COALESCE(k2d_lesson, FALSE) AS is_k2d_lesson,                -- DEFAULT false
    COALESCE(passed, FALSE) AS is_passed,
    COALESCE(private_lesson, FALSE) AS is_private_lesson,
    COALESCE(dynamic_pricing, FALSE) AS has_dynamic_pricing,
    
    -- Cancellation Flags (preserving defaults)
    COALESCE(cancelled_by_ezl, FALSE) AS is_cancelled_by_system,         -- DEFAULT false
    COALESCE(cancelled_by_instructor, FALSE) AS is_cancelled_by_instructor, -- DEFAULT false
    COALESCE(cancelled_by_learner_in_24_hours, FALSE) AS is_cancelled_by_learner_24h, -- DEFAULT false
    
    -- Notes and Details
    NULLIF(note, '') AS event_note,
    NULLIF(event_detail, '') AS event_detail,
    NULLIF(address_note, '') AS address_note,
    
    -- System Identifiers
    driving_test_location_id,
    instructor_proposed_lesson_id,

    -- Audit Fields
    CURRENT_TIMESTAMP() AS foundation_created_at,

FROM `ezlicence-1506735963116.au_production_2_bq.public_calendar_items`
