#!/bin/bash

# Get token
SA_TOKEN=$(oc create token user-one)

# Get route
LLM_ROUTE=$(oc get inferenceservice -o jsonpath="{.items[0].status.url}")
MODEL_ID=$(oc get inferenceservice -o jsonpath="{.items[0].metadata.name}")

# Run the curl command with the prompt
curl --json '{
    "model_id": "'"${MODEL_ID}"'",
    "inputs": "'"$1"'"
}' "$LLM_ROUTE/api/v1/task/text-generation" \
    -H "Authorization: Bearer ${SA_TOKEN}" \
    -H "Content-Type: application/json"