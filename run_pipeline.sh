#!/bin/bash

set -euo pipefail

PROJECT_ID=p1rcc-red
OUTPUT_BUCKET=vcf2bigquery
INPUT_FILE=$1

gcloud alpha genomics pipelines run \
    --project "${PROJECT_ID}" \
    --pipeline-file vcf_to_bigquery.yaml \
    --logging gs://"${OUTPUT_BUCKET}"/"${INPUT_FILE}"/temp/runner_logs \
    --zones us-west1-b \
    --service-account-scopes https://www.googleapis.com/auth/bigquery \
    --inputs `echo \
      PROJECT_ID="${PROJECT_ID}", \
      OUTPUT_BUCKET="${OUTPUT_BUCKET}", \
      INPUT_FILE="${INPUT_FILE}" \
      | tr -d '[:space:]'`
