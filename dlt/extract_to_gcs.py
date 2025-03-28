from datetime import date, timedelta

import dlt
from dlt.sources.helpers.rest_client import RESTClient


DAYS_OFFSET = 1 # TODO: change to 14 default
metadata_date = date.today() - timedelta(days=DAYS_OFFSET)

# Define the API resource for Metropolitan Museum data
@dlt.resource(name="met_artworks", max_table_nesting=0)
def met_artworks():
    """Dlt resource for Metropolitan Museum artworks API."""
    client = RESTClient(
        base_url="https://collectionapi.metmuseum.org/public/collection/v1",
    )
    # Pull ids of most recent museum objects
    response = client.get("/objects", params={"metadataDate": metadata_date})
    object_ids = response.json()["objectIDs"][:100] # TODO: REMOVE SLICE AFTER TESTING

    # TODO: Add logger
    print(f"Pulled ids of {len(object_ids)} museum artworks.")

    # Pull data for each object from object_ids list
    for page in object_ids:
        yield client.get("/objects/" + str(page)).json()

# # For testing
# for i in met_artworks:
#     print(i)

# Create and run dlt pipeline
# TODO: Include Airflow logging like here: https://dlthub.com/docs/general-usage/pipeline
pipeline = dlt.pipeline(
    destination="duckdb",
    progress=dlt.progress.log(60) # Log progress every 60s
)
load_info = pipeline.run(met_artworks, write_disposition="replace")
print(load_info)
