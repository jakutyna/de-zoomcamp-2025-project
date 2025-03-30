import os
import pendulum
from dlt_pipeline.test_airflow import test_func

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
    def python_envs():
        """
        Python task
        """
        # return f"GCP PROJECT: {os.environ["GCP_PROJECT_ID"]}"
        return test_func()
    @task.bash
    def bash_envs():
        """
        Bash task
        """
        # return "env | sort"
        return "pwd"
    
    # python_task = python_envs()
    # bash_task = bash_envs()
    # python_task >> bash_task
    python_envs() >> bash_envs()

met_museum_dag()
