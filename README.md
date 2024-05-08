# DEVSKY - Infraestrutura

## Recursos utilizados da Digital Ocean

| Recurso            | Funcão                          | Estimativa Valor Total           |  Detalhes                                                                            |
| -------            | ------                          | -----                            |  -----                                                                               |
| Space Bucket       | Terraform State & Audio, Images | $5,00                            |  [Detalhes](https://docs.digitalocean.com/products/spaces/details/pricing/)          |
| Container Registry | OCI / Docker Images             | $20,00                           |  [Detalhes](https://www.digitalocean.com/pricing/container-registry)                 |
| MySQL Database     | Database Producão               | $120,00 (4cpu 8GB)               |  [Detalhes](https://docs.digitalocean.com/products/databases/mysql/details/pricing/) |
| MySQL Database     | Database Staging                | $60,00  (2cpu 4GB)               |  [Detalhes](https://docs.digitalocean.com/products/databases/mysql/details/pricing/) |
| Redis Cache        |)  Cache Producão                  | $15,00  (1cpu 1GB)               |  [Detalhes](https://docs.digitalocean.com/products/databases/mysql/details/pricing/) |
| Redis Cache        | Cache Staging                   | $15,00  (1cpu 1GB)               |  [Detalhes](https://docs.digitalocean.com/products/databases/mysql/details/pricing/) |
| Kubernetes Cluster | Control Panel                   | $40,00                           |  [Detalhes](https://www.digitalocean.com/pricing/kubernetes)                         |
| Kubernetes Cluster | Worker Nodes - 3 servidores     | $378,00 (4cpu 8GB cada servidor) |  [Detalhes](https://www.digitalocean.com/pricing/kubernetes)                         |
| Load Balancer      | Load Balancer                   | $12,00 (1 instancia(s))          |  [Detalhes](https://www.digitalocean.com/products/load-balancer)                     |
| Volumes            | Store metrics, logs & etc..     | $20,00 (205GB)                   |  [Detalhes]()                                                                        |

**Total Estimado por mês:** $ 685,00

## Ferramentas configuradas no Cluster Kubernetes

| Ferramenta              | Funcão                                       | Detalhes                                                                       |
| -------                 | ------                                       | -----                                                                          |
| NgInx Ingress           | Load Balancer                                | [Detalhes](https://kubernetes.github.io/ingress-nginx/user-guide/basic-usage/) |
| Harpin Proxy            | Proxy para tráfego interno do Load Balancer  | [Detalhes](https://github.com/compumike/hairpin-proxy)                         |
| Cert Manager            | Gestão de Certificados SSL                   | [Detalhes](https://cert-manager.io/docs/)                                      |
| ArgoCD                  | Deploy Contínuo                              | [Detalhes](https://argo-cd.readthedocs.io/en/stable/)                          |
| Kube Prometheus Stack   | Monitoramento do Cluster Kubernetes          | [Detalhes](https://github.com/prometheus-community/helm-charts)                |
| Grafana Loki            | Agregador de Logs                            | [Detalhes](https://grafana.com/oss/loki/)                                      |
| Promtail                | Coletor de Logs                              | [Detalhes](https://grafana.com/docs/loki/latest/clients/promtail/)             |


## Setup maquina do desenvolvedor

### Configurando Terraform

1. [Instale](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli) o CLI do terraform

2. Crie chave ssh na Digital Ocean

3. Crie Token para API na Digital Ocean

4. Crie um novo Space na Digital Ocean para manter o arquivo do terraform state

5. Exporte as varíaveis de ambiente do terraform
```shell
    export TF_VAR_do_token=""

    export TF_VAR_spaces_access_key=""

    export TF_VAR_spaces_secret_key=""
```

6. Inicie Terraform
```shell
terraform init -backend-config="access_key=$TF_VAR_spaces_access_key" -backend-config="secret_key=$TF_VAR_spaces_secret_key"
```

7. Valide o script do Terraform
```shell
terraform plan
```

8. Aplique o Script do Terraform
```shell
terraform apply
```

### Configuracao Digital Ocean CLI
 1. [Instale](https://docs.digitalocean.com/reference/doctl/how-to/install/) o CLI da Digital Ocean

 2. Liste as contas ativas
 ```shell
 doctl auth list
 ```

 3. Liste os clusters Kubernetes ativos 
 ```shell
 doctl kubernetes cluster list
 ```
    
### Configuracao Kubectl

 1. [Instale](https://kubernetes.io/docs/tasks/tools/) o kubectl
 

 2. Configure o cluster recem criado pelo terraform no kubectl
 ```shell
doctl kubernetes cluster kubeconfig save devsky-k8s
 ```

### Configuracao ArgoCD

 1. [Instale](https://argo-cd.readthedocs.io/en/stable/cli_installation/) o CLI do ArgoCD

 2. Recupere a senha gerada para o ArgoCD no novo cluster Kubernetes
 ```shell
kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d; echo
 ```

 3. Realize o Port-Forward do servico do ArgoCD para sua maquina
 ```shell
kubectl port-forward svc/argocd-server -n argocd 8080:443
 ```

 4. Efetue Login no CLI do ArgoCD
 ```shell
argocd login localhost:8080
 ```
 > Utilize o login **admin** e a senha retornada pelo passo 2 do setup do ArgoCD

 5. Registre o repositorio Git da infraestrutura no ArgoCD
 ```shell
argocd repo add git@github.com:devskyteam/devsky-infra.git --ssh-private-key-path ~/.ssh/id_rsa
 ```

# terraform-oficial-sorteamos
