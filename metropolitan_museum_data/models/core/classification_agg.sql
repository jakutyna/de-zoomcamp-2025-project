WITH century_calc AS (
  SELECT
    classification,
    COUNT(*) OVER (PARTITION BY classification) class_count,
    (object_begin_date + object_end_date) / 2 / 100 century_raw,
    metadata_date
    FROM {{ ref('stg_met_data') }}
    WHERE TIMESTAMP_TRUNC(metadata_date, DAY) > DATE_ADD(CURRENT_TIMESTAMP(), INTERVAL -7 DAY)
    AND classification IS NOT NULL
),

class_per_century AS (
  SELECT
    *,
    CASE 
      WHEN century_raw > 0 THEN
        CAST(CEIL(century_raw) AS INT)
      ELSE 
        CAST(FLOOR(century_raw) AS INT)
    END AS century,
    DENSE_RANK() OVER(ORDER BY class_count DESC) class_rank
  FROM century_calc
  QUALIFY class_rank <= 3 --limit 3 most numerous object types
)

SELECT 
    classification,
    century,
    COUNT(*) obj_count,
    date(metadata_date) updated_date
FROM class_per_century
WHERE TIMESTAMP_TRUNC(metadata_date, DAY) > DATE_ADD(CURRENT_TIMESTAMP(), INTERVAL -7 DAY)
GROUP BY classification, century, updated_date