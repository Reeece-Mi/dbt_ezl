{{ config(
    materialized='view',
    database='ezlicence-1506735963116',
    schema = 'uk_foundation_view'
) }}

SELECT
   -- Primary Identifiers 
   id AS instructor_working_snapshot_id,         
   instructor_user_id,        
   
   -- Date and Time Fields
   working_date,
   CAST(week_day AS INT64) AS week_day_number,
   created_at,                 
   updated_at,                 

   -- Hours Metrics 
   CAST(opening_hours AS NUMERIC) AS opening_hours,              
   CAST(private_unavailable_hours AS NUMERIC) AS private_unavailable_hours,  
   CAST(lesson_hours AS NUMERIC) AS lesson_hours,
   CAST(test_package_hours AS NUMERIC) AS test_package_hours,
   CAST(filtered_private_unavailable_hours AS NUMERIC) AS filtered_private_unavailable_hours,
   CAST(gross_hours AS NUMERIC) AS gross_hours,
   CAST(working_hours AS NUMERIC) AS working_hours,
   CAST(real_opening_hours AS NUMERIC) AS real_opening_hours,

   -- Location Information 
   postcode,                   
   state,                     

   -- Availability Flags
   COALESCE(auto_am, TRUE) AS is_auto_available_morning,      
   COALESCE(auto_pm, TRUE) AS is_auto_available_afternoon,    
   COALESCE(manual_am, TRUE) AS is_manual_available_morning,  
   COALESCE(manual_pm, TRUE) AS is_manual_available_afternoon,

   -- Utilization Rates
   CAST(gross_utilisation_rate AS NUMERIC) AS gross_utilization_rate,
   CAST(opening_hours_utilisation_rate AS NUMERIC) AS opening_hours_utilization_rate,

   -- Working Time Periods 
   working_times,
   working_time_periods,       
   real_working_time_periods, 

   -- Audit Fields
   CURRENT_TIMESTAMP() AS foundation_created_at

FROM `ezlicence-1506735963116.uk_production_2_bq.warehouse_instructor_working_time_snapshots`