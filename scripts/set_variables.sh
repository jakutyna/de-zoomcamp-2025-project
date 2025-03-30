#!/bin/bash

export GCP_PROJECT_ID=$(jq -r '.project_id' ${GOOGLE_APPLICATION_CREDENTIALS})
export GCP_CLIENT_EMAIL=$(jq -r '.client_email' ${GOOGLE_APPLICATION_CREDENTIALS})
export GCP_PRIVATE_KEY=$(jq -r '.private_key' ${GOOGLE_APPLICATION_CREDENTIALS})
export GCS_BUCKET_NAME="${GCP_PROJECT_ID}-bucket"
export BQ_DATASET_NAME=met_museum_data

# Variables for teraform
export TF_VAR_gcp_project=$GCP_PROJECT_ID
export TF_VAR_gcs_bucket_name=$GCS_BUCKET_NAME
export TF_VAR_bq_dataset_name=$BQ_DATASET_NAME