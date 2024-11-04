## Vars
SA_TOKEN=$(oc create token user-one)
echo $SA_TOKEN
LLM_ROUTE=gpt2-test.apps.rosa.mac-trustyai.swih.p3.openshiftapps.com
MODEL_ID=gpt2

## Internal routes:
```
grpcurl --plaintext -H "Authorization: Bearer ${SA_TOKEN}" gpt2-predictor.test.svc.cluster.local:80 list
grpcurl --plaintext -H "Authorization: Bearer ${SA_TOKEN}" gpt2-predictor-00001.test.svc.cluster.local:81 list
grpcurl --plaintext -H "Authorization: Bearer ${SA_TOKEN}" gpt2-predictor-00001.test.svc.cluster.local:443 list
grpcurl --plaintext -H "Authorization: Bearer ${SA_TOKEN}" gpt2-predictor-00001-private.test.svc.cluster.local:80 list
grpcurl --plaintext -H "Authorization: Bearer ${SA_TOKEN}" gpt2-predictor-00001-private.test.svc.cluster.local:443 list
grpcurl --plaintext -H "Authorization: Bearer ${SA_TOKEN}" gpt2-predictor-00001-private.test.svc.cluster.local:8013 list

```

## 

```bash
grpcurl --plaintext -H "Authorization: Bearer ${SA_TOKEN}" gpt2-predictor.test.svc.cluster.local:80 describe caikit.runtime.Nlp.NlpService
```

## Curl model inferences list endpoint
```bash
grpcurl  -H "Authorization: Bearer ${SA_TOKEN}" $LLM_ROUTE:443 list
grpcurl --insecure -H "Authorization: Bearer ${SA_TOKEN}" $LLM_ROUTE:443 list
```

## Curl model inference endpoint
```bash
grpcurl -insecure -d '{"text": "cheeks"}' \
    -H "Authorization: Bearer ${SA_TOKEN}" \
    -H "mm-model-id: ${MODEL_ID}" \
    ${LLM_ROUTE}:443 caikit.runtime.Nlp.NlpService/TextGenerationTaskPredict
```

## Curl model inference endpoint

```bash
grpcurl --plaintext \
  -H "Authorization: Bearer ${SA_TOKEN}" \
  -H "mm-model-id: gpt2" \
  -d '{"text": "dummy input"}' \
  gpt2-predictor.test.svc.cluster.local:80 \
  caikit.runtime.Nlp.NlpService/TextGenerationTaskPredict
```

## Curl detector endpoint
```bash
REGEX_URL=https://regex-detector-test.apps.rosa.mac-trustyai.swih.p3.openshiftapps.com/api/v1/text/contents
curl -kv $REGEX_URL \
-H "Content-Type: application/json" \
-H "detector-id: has_regex_match" \
-H "Authorization: Bearer ${SA_TOKEN}" \
-d '{
    "contents": ["My email address is xx@domain.com and zzz@hotdomain.co.uk"]
}'
```

```bash
REGEX_URL=http://regex-detector-predictor.test.svc.cluster.local:80/api/v1/text/contents
curl -kv $REGEX_URL \
-H "Content-Type: application/json" \
-H "detector-id: has_regex_match" \
-H "Authorization: Bearer ${SA_TOKEN}" \
-d '{
    "contents": ["My email address is xx@domain.com and zzz@hotdomain.co.uk"]
}'
```

## Curl orchestrtator endpoints

```bash
curl -v http://localhost:8034/info
curl -v http://localhost:8034/health
```


```bash
curl -v -H "Content-Type: application/json" -H "Authorization: Bearer $SA_TOKEN" --data '{
    "model_id": "gpt2",
    "inputs": "dummy input",
    "guardrail_config": {
        "input": {
            "masks": [],
            "models": {}
        },
        "output": {
            "models": {}
        }
    }
}' http://localhost:8033/api/v1/task/classification-with-text-generation
```

```bash
curl -kv -H "Content-Type: application/json" \
  -H "Authorization: Bearer $SA_TOKEN" \
  -H "mm-model-id: gpt2" \
  --data '{
    "inputs": "dummy input",
    "guardrail_config": {
        "input": {
            "masks": [],
            "models": {}
        },
        "output": {
            "models": {}
        }
    }
}' http://localhost:8033/api/v1/task/classification-with-text-generation
```

```bash
curl -kv -H "Content-Type: application/json" \
  -H "Authorization: Bearer $SA_TOKEN" \
  -H "mm-model-id: gpt2" \
  --data '{
    "model_id": "gpt2",
    "inputs": "dummy input",
    "guardrail_config": {
        "input": {
            "masks": [],
            "models": {}
        },
        "output": {
            "models": {}
        }
    }
}' http://localhost:8033/api/v1/task/classification-with-text-generation
```

```bash
curl -v -H "Content-Type: application/json" \
     -H "Authorization: Bearer $SA_TOKEN" \
     -H "mm-model-id: gpt2" \
     --data '{
    "model_id": "gpt2",
    "inputs": "dummy input",
    "guardrail_config": {
        "input": {
            "masks": [],
            "models": {}
        },
        "output": {
            "models": {}
        }
    }
}' http://localhost:8033/api/v1/task/classification-with-text-generation
```