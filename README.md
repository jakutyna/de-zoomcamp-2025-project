# de-zoomcamp-2025-project

## About the project

The project target is to get some insights on artworks available in NYC Metropolitan Museum. All the data used in this project is publicly available through the museum's REST API: [https://metmuseum.github.io/](https://metmuseum.github.io/)

Following dashboard was created using the API data: [Dashboard](https://lookerstudio.google.com/reporting/0e7d5875-999e-4fa6-9c6d-35adfdb9bd2b).

__Chart 1__

__Chart 2__

__Bonus chart__


### Components

- Infrastructure as Code: Terraform
- Workflow Orchestration: Airflow
- Extract and Load data: dlt

Data Lake: Google Cloud Storage
Data Warehouse: Google BigQuery
Batch Processing: Spark on Dataproc
Visualisation: Google Data Studio

## Project setup

### Prerequisites
- Install terraform:
- Install docker:
- Clone the repository
- Optionally: install `jq` bash command: https://jqlang.org/download/

### GCP setup
Setting up project environment on GCP:
- Create new project (if you don't have one)
- Create service account ([https://cloud.google.com/iam/docs/service-accounts-create](https://cloud.google.com/iam/docs/service-accounts-create#iam-service-accounts-create-console))
    - Add roles BigQuery Admin, Storage Admin
    - Create a JSON service account key ([https://cloud.google.com/iam/docs/keys-create-delete](https://cloud.google.com/iam/docs/keys-create-delete#iam-service-account-keys-create-console))
    - Store a downloaded JSON key file in the location of your choice
    - Set an environment variable with a path to your JSON key file

```sh
export GOOGLE_APPLICATION_CREDENTIALS=<path-to-JSON-file>
```

- run bash script to copy JSON key file to repo directory (or copy it manually)
- run bash script (??????) to extract env vars from your JSON file or set them up manually:

### Airflow

- airflow docker-compose.yaml and Dockerfile were created following this: ([Running Airflow in Docker](https://airflow.apache.org/docs/apache-airflow/stable/howto/docker-compose/index.html))


```sh
docker compose build
```


```sh
docker compose up airflow-init
```

```sh
docker compose up
```

### DBT

- dbt_external_tables package is used to create external tables in BQ (https://hub.getdbt.com/dbt-labs/dbt_external_tables/latest/)


Required environment variables:
- (gcp key location)
- (gcp project id)
- (dataset name ?)



# Testing steps
- source scripts/pre-build.sh
- source scripts/set_variables.sh
- `terraform -chdir=./terraform apply`
- docker compose commands (build, airflow-init, up -d)
- `terraform -chdir=de-zoomcamp-2025-project/terraform destroy`
- docker compose down --volumes --rmi all
dbt clean
