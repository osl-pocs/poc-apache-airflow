FROM apache/airflow:slim-latest-python3.7

ENV AIRFLOW_HOME=/opt/airflow

RUN pip install --user psycopg2-binary

USER root
RUN mkdir -p /opt/scripts/ \
  && chown airflow /opt/scripts/

USER airflow
COPY ./airflow.cfg /opt/airflow/airflow.cfg
COPY ./entrypoint.sh /opt/scripts/entrypoint.sh

# RUN chown -R airflow:airflow /usr/local/airflow
