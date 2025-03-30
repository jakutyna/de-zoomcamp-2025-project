import os
from datetime import date, timedelta

import dlt
from dlt.sources.helpers.rest_client import RESTClient


def run_pipeline():
    """Run dlt pipeline to extract metropolitan museum data"""

    DAYS_OFFSET = 1  # TODO: change to 14 default
    metadata_date = date.today() - timedelta(days=DAYS_OFFSET)

    # Set up secrects
    private_key_unescaped = (
        os.environ.get("GCP_PRIVATE_KEY")
        .encode("raw_unicode_escape")
        .decode("unicode_escape")
    )
    dlt.secrets["destination.filesystem.bucket_url"] = "gs://" + os.environ.get(
        "GCS_BUCKET_NAME"
    )
    dlt.secrets["destination.filesystem.credentials.project_id"] = os.environ.get(
        "GCP_PROJECT_ID"
    )
    dlt.secrets["destination.filesystem.credentials.private_key"] = (
        private_key_unescaped
    )
    dlt.secrets["destination.filesystem.credentials.client_email"] = os.environ.get(
        "GCP_CLIENT_EMAIL"
    )
    dataset_name = os.environ.get("BQ_DATASET_NAME")

    # Define the API resource for Metropolitan Museum data
    @dlt.resource(name="met_artworks", max_table_nesting=0)
    def met_artworks():
        """Dlt resource for Metropolitan Museum artworks API."""
        client = RESTClient(
            base_url="https://collectionapi.metmuseum.org/public/collection/v1",
        )
        # Pull ids of most recent museum objects
        response = client.get("/objects", params={"metadataDate": metadata_date})
        object_ids = response.json()["objectIDs"][
            :100
        ]  # TODO: REMOVE SLICE AFTER TESTING

        # TODO: Add logger
        print(f"Pulled ids of {len(object_ids)} museum artworks.")

        # Pull data for each object from object_ids list
        for page in object_ids:
            yield client.get("/objects/" + str(page)).json()

    # Create and run dlt pipeline
    # TODO: Include Airflow logging like here: https://dlthub.com/docs/general-usage/pipeline
    pipeline = dlt.pipeline(
        destination="filesystem",
        dataset_name=dataset_name,  # TODO: use env var
        progress=dlt.progress.log(60),  # Log progress every 60s
    )
    load_info = pipeline.run(
        met_artworks, write_disposition="replace", loader_file_format="parquet"
    )
    return load_info


if __name__ == "__main__":
    run_pipeline()
