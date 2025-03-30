FROM apache/airflow:2.10.5

ENV PYTHONPATH="/opt/airflow/dlt_pipeline:${PYTHONPATH}"

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY --chown=airflow:root dlt_pipeline dlt_pipeline