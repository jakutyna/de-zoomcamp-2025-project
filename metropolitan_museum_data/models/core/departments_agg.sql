SELECT 
    department,
    COUNT(*) obj_count,
    date(metadata_date) updated_date
FROM {{ ref('stg_met_data') }}
WHERE TIMESTAMP_TRUNC(metadata_date, DAY) > DATE_ADD(CURRENT_TIMESTAMP(), INTERVAL -7 DAY)
GROUP BY department, updated_date
