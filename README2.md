## PRE-STEP 01 - criar o arquivo /home/{{user}}/.kube/config

## STEP 01 - Authenticate
Autenticar no digital ocean

```sh
doctl auth init
```
## STEP 02 - Connecting to Kubernetes

Esta abordagem renova automaticamente o certificado do seu cluster. Execute o comando abaixo para autenticar:

```sh 
doctl kubernetes cluster kubeconfig save 07f13e0d-55a7-49fa-82ea-8d524285e70a
```

## STEP 03 - Verify connectivity

| Command | Description |
|----------|----------|
| kubectl config get-contexts | Lists your cluster |name, user, and namespace
| kubectl cluster-info | Display addresses of the |control plane and cluster services
| kubectl version | Display the client and server k8s |version
| kubectl get nodes | List all nodes created in the |cluster
| kubectl help | Displays commands that help manage |your cluster

## STEP 04 - execute o deploy