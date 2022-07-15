#!/bin/bash


# Airflow needs a home. `~/airflow` is the default, but you can put it
# somewhere else if you prefer (optional)

export AIRFLOW_HOME=$(pwd)'/docker'

# # Install Airflow using the constraints file
AIRFLOW_VERSION=2.3.0

# PYTHON_VERSION="$(python --version | cut -d " " -f 2 | cut -d "." -f 1-2)"
# For example: 3.7

CONSTRAINT_URL="https://raw.githubusercontent.com/apache/airflow/constraints-${AIRFLOW_VERSION}/constraints-3.8.txt"

pip install "apache-airflow==${AIRFLOW_VERSION}" --constraint "${CONSTRAINT_URL}"
