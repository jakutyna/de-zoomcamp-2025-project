import os
import pendulum
from dlt_pipeline.extract_to_gcs import run_pipeline

from airflow.decorators import dag, task


@dag(
    schedule=None,
    start_date=pendulum.datetime(2025, 1, 1, tz="UTC"),
    catchup=False,
    tags=["met_data"],
)
def met_museum_dag():
    """Dag definition"""

    @task
    def extract_load_data():
        """
        Run dlt pipeline to extract data from metropolitan 
        museum API and load it into GCS bucket.
        """
        run_pipeline()

    @task.bash
    def create_external_table():
        """
        Trigger dbt command to create an external table in BiqQuery
        based on data stored in GCS bucket.
        """
        return r'''dbt run-operation stage_external_sources \
            --vars "ext_full_refresh: true" \
            --project-dir ${DBT_HOME} \
            --profiles-dir ${DBT_HOME}
        '''
    
    @task.bash
    def transform_data():
        """
        Trigger dbt command to run data transformations in BigQuery.
        """
        return r'''dbt run \
            --project-dir ${DBT_HOME} \
            --profiles-dir ${DBT_HOME}
        '''

    extract_load_data() >> create_external_table() >> transform_data()


met_museum_dag()
