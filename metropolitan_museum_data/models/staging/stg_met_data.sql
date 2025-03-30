SELECT *
FROM {{ source('external', 'met_artworks_external') }}

-- Fields to select:
-- object_id
-- INTEGER

-- is_highlight
-- BOOLEAN

-- accession_number
-- STRING

-- accession_year
-- STRING

-- is_public_domain
-- BOOLEAN

-- primary_image
-- STRING

-- primary_image_small
-- STRING

-- additional_images
-- STRING

-- constituents
-- STRING

-- department
-- STRING

-- object_name
-- STRING

-- title
-- STRING

-- culture
-- STRING

-- period
-- STRING

-- dynasty
-- STRING

-- reign
-- STRING

-- portfolio
-- STRING

-- artist_role
-- STRING

-- artist_prefix
-- STRING

-- artist_display_name
-- STRING

-- artist_display_bio
-- STRING

-- artist_suffix
-- STRING

-- artist_alpha_sort
-- STRING

-- artist_nationality
-- STRING

-- artist_begin_date
-- STRING

-- artist_end_date
-- STRING

-- artist_gender
-- STRING

-- artist_wikidata_url
-- STRING

-- artist_ulan_url
-- STRING

-- object_date
-- STRING

-- object_begin_date
-- INTEGER

-- object_end_date
-- INTEGER

-- medium
-- STRING

-- dimensions
-- STRING

-- measurements
-- STRING

-- credit_line
-- STRING

-- geography_type
-- STRING

-- city
-- STRING

-- state
-- STRING

-- county
-- STRING

-- country
-- STRING

-- region
-- STRING

-- subregion
-- STRING

-- locale
-- STRING

-- locus
-- STRING

-- excavation
-- STRING

-- river
-- STRING

-- classification
-- STRING

-- rights_and_reproduction
-- STRING

-- link_resource
-- STRING

-- metadata_date
-- TIMESTAMP
