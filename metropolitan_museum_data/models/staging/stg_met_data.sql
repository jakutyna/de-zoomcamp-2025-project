{{ config(
    materialized = 'table',
    partition_by = {
      "field": "metadata_date",
      "data_type": "timestamp",
      "granularity": "day",
      
    },
    cluster_by = ["department", "classification"],
)}}

SELECT 
    object_id,
    object_name,
    title,
    department,
    CAST(NULLIF(SPLIT(accession_year, '-')[0], "") as INTEGER) accession_year,
    is_highlight,
    is_public_domain,
    primary_image,
    primary_image_small,
    JSON_EXTRACT_ARRAY(additional_images, '$') additional_images,
    culture,
    artist_role,
    artist_display_name,
    artist_nationality,
    CAST(NULLIF(SPLIT(artist_begin_date, '-')[0], "") as INTEGER) artist_begin_date,
    CAST(NULLIF(SPLIT(artist_end_date, '-')[0], "") as INTEGER) artist_end_date,
    object_date,
    object_begin_date,
    object_end_date,
    medium,
    credit_line,
    geography_type,
    city,
    country,
    region,
    NULLIF(classification, "") classification,
    repository,
    object_url,
    metadata_date
FROM {{ source('external', 'met_artworks_external') }}
