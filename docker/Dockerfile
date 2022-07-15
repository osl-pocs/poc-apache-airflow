FROM apache/airflow:slim-latest-python3.7
RUN pip install --user psycopg2-binary
ENV AIRFLOW_HOME=/opt/airflow
COPY ./airflow.cfg /opt/airflow/airflow.cfg

# RUN chown -R airflow:airflow /usr/local/airflow