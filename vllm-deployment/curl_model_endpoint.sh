#!/bin/bash

# Get token
SA_TOKEN=$(oc create token user-one)

# Get route
LLM_ROUTE=$(oc get inferenceservice -o jsonpath="{.items[0].status.url}")

# Get model
MODEL=$(curl -sk "$LLM_ROUTE/v1/models" -H "Authorization: Bearer ${SA_TOKEN}" | jq -r ".data[0].root")
echo "Using model: $MODEL"

# Run the curl command with the prompt
curl -skv -X POST "$LLM_ROUTE/v1/completions" \
    -H "Authorization: Bearer ${SA_TOKEN}" \
    -H "Content-Type: application/json" \
    -d "{\"model\": \"$MODEL\", \"prompt\": \"$1\", \"max_tokens\": 50}"
