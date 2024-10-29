# Setup 

1. Create a new namespace in your Kubernetes cluster
```bash
oc new-project test
```

2. Deploy the generator model using KServe Serverless

    - navigate to `generator/caikit-standalone-deployment/grpc-deployment`
    - run `just create-caikit-all`

3. Deploy the detector model using KServe Serverless

    - navigate to `detectors`
    - run `oc apply -f regex_isvc.yaml`         

4. Deploy the orchestrator 
    
     - navigate to `orchestrator`
    - run `config.yaml`

5. You should eventually see the following pods within the `test` namespace: 
![](images/pod-screenshot.png)

