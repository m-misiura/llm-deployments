#!/bin/bash

# Get token
SA_TOKEN=$(oc create token user-one)

# Get route
LLM_ROUTE=$(oc get inferenceservice -o jsonpath="{.items[0].status.url}")
LLM_ROUTE=${LLM_ROUTE#https://}
MODEL_ID=$(oc get inferenceservice -o jsonpath="{.items[0].metadata.name}")
TEXT_INPUT=$1
# Run the curl command with the prompt
grpcurl -insecure -d '{"text": "'"${TEXT_INPUT}"'"}' \
    -H "Authorization: Bearer ${SA_TOKEN}" \
    -H "mm-model-id: ${MODEL_ID}" \
    ${LLM_ROUTE}:443 caikit.runtime.Nlp.NlpService/TextGenerationTaskPredict