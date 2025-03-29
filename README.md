# de-zoomcamp-2025-project

The project target is to get some insights on artworks available in NYC Metropolitan Museum. All the data used in this project is publicly available through the museum's REST API: https://metmuseum.github.io/

### Prerequisites
- terraform installed
- docker installed
- jq command installed: https://jqlang.org/download/

### GCP steps
Setting up project environment on GCP:
- Create new project (if you don't have one)
- Create service account ([https://cloud.google.com/iam/docs/service-accounts-create](https://cloud.google.com/iam/docs/service-accounts-create#iam-service-accounts-create-console))
    - Add roles BigQuery Admin, Storage Admin
    - Create a JSON service account key ([https://cloud.google.com/iam/docs/keys-create-delete](https://cloud.google.com/iam/docs/keys-create-delete#iam-service-account-keys-create-console))
    - Store a downloaded JSON file in the location of your choice
    - Set an environment variable with a path to your JSON key file
- run bash script (??????) to extract env vars from your JSON file or set them up manually:

```sh
export GOOGLE_APPLICATION_CREDENTIALS=<path-to-JSON-file>
````



Required environment variables:
- (gcp key location)
- (gcp project id)
- (dataset name ?)



# Testing steps

- `terraform -chdir=de-zoomcamp-2025-project/terraform apply`
- `python dlt/es
- `terraform -chdir=de-zoomcamp-2025-project/terraform destroy`