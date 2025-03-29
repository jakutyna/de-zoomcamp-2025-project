variable "gcp_project" {
  description = "GCP project ID"
  # No default - define TF_VAR_gcp_project env variable
}

variable "gcs_bucket_name" {
  description = "Storage Bucket Name"
  # No default - define TF_VAR_gcs_bucket_name env variable
}

variable "bq_dataset_name" {
  description = "BigQuery Dataset Name"
  # No default - define TF_VAR_bq_dataset_name env variable
}

variable "region" {
  description = "Project Region"
  default     = "europe-central2"
}

variable "location" {
  description = "Project Location"
  default     = "EUROPE-CENTRAL2"
}

variable "gcs_storage_class" {
  description = "Bucket Storage Class"
  default     = "STANDARD"
}
