## Deploy with VLLM

1. Set up a service account with the necessary permissions: `oc apply -f service-account.yaml`
2. Set up model storage `oc apply -f llm-model-container.yaml`
3. Create vllm serving runtime `oc apply -f vllm_serving_runtime.yaml`
4. Deploy the VLLM model `oc apply -f vllm_isvc.yaml`

On the Open Data Hub version 2.18.2, there is a bug in the `inferenceservice-config` within the `opendatahub` namespace. To fix this, run the following command:

```bash
export KUBE_EDITOR="code --wait"
oc edit configmap inferenceservice-config -n opendatahub
```

add a missing comma in the `storage initializer` section, so that this section looks like

```
  storageInitializer: |-
    {
        "image" : "quay.io/opendatahub/kserve-storage-initializer:v0.12.1.6",
        "memoryRequest": "100Mi",
        "memoryLimit": "1Gi",
        "cpuRequest": "100m",
        "cpuLimit": "1",
        "caBundleConfigMapName": "",
        "caBundleVolumeMountPath": "/etc/ssl/custom-certs",
        "cpuModelcar": "10m",
        "memoryModelcar": "15Mi",
        "enableDirectPvcVolumeMount": true,
        "enableModelcar": true
    }
```

## Testing some of the endpoints

1. Get the service account token: `SA_TOKEN=$(oc create token user-one)` 
2. Get the route for the generator: `LLM_ROUTE="$(oc get inferenceservice gpt-2 -o jsonpath='{.status.url}')"`

```
curl -skv -X POST "$LLM_ROUTE/v1/completions" \
   -H "Authorization: Bearer ${SA_TOKEN}" \
   -H "Content-Type: application/json" \
   -d '{"model": "gpt-2", "prompt": "Water is wet", "max_tokens": 50}'
```



