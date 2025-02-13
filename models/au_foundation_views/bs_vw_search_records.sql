{{ config(
    materialized='view',
    database='ezlicence-1506735963116',
    schema = 'au_foundation_view'
) }}
    SELECT
        -- Primary Key 
        id AS search_record_id,
        
        -- Temporal Fields (standardized)
        DATE(COALESCE(date_range_start, date_range_end)) AS search_date_start,
        date_range_end AS search_date_end,
        updated_at,

        
        -- Core Business Fields (standardized)
        learner_user_id,
        instructor_user_ids,  
        driving_test_location_id,
        transmission,
        CASE 
            WHEN public_search_type = 0 THEN 'lesson'
            WHEN public_search_type = 1 THEN 'test_package'
            WHEN public_search_type = 2 THEN 'test_package_with_lesson'
            ELSE NULL
        END AS public_search_type,
        COALESCE(private_search, FALSE) AS is_private_search,
        COALESCE(result_count, 0) AS result_count,
        
        -- Location Fields (standardized)
        postcode,
        suburb,
        suburb_polygon_id,
        state,
        COALESCE(timezone, 'UTC') AS timezone,
        
        -- Metadata Fields
        LOWER(TRIM(event_tracking_type)) AS event_tracking_type,
        LOWER(TRIM(user_device)) AS user_device,
        
        -- Add standard audit columns
        CURRENT_TIMESTAMP() AS foundation_created_at
    FROM `ezlicence-1506735963116.au_production_2_bq.public_public_search_records`
    ORDER BY created_at DESC