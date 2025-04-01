FROM apache/airflow:2.10.5

ENV AIRFLOW_HOME="/opt/airflow"
ENV DLT_HOME="${AIRFLOW_HOME}/dlt_pipeline"
ENV DBT_HOME="${AIRFLOW_HOME}/metropolitan_museum_data"
ENV PYTHONPATH="${DLT_HOME}:${PYTHONPATH}"
ENV GOOGLE_APPLICATION_CREDENTIALS="/opt/service_account.json"

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY --chown=airflow:root dlt_pipeline ${DLT_HOME}
COPY --chown=airflow:root metropolitan_museum_data ${DBT_HOME}
COPY --chown=airflow:root gcp_credentials/service_account.json ${GOOGLE_APPLICATION_CREDENTIALS}

RUN dbt deps \
    --project-dir ${DBT_HOME} \
    --profiles-dir ${DBT_HOME} && \
    chmod -R 777 ${DBT_HOME}
