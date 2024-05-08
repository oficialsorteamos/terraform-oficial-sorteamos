# Sorteamos - Setup de um novo cliente

## Passo a Passo

Vamos utilizar como exemplo um novo cliente chamado xpto .

1. Banco de Dados

Altere o arquivo **cloud.tf** adicionando um novo database e usuario para o novo cliente no banco de dados(insira o código abaixo da ultima entrada de user do arquivo)
```
resource "digitalocean_database_db" "xpto_database" {
  cluster_id = digitalocean_database_cluster.sorteamos_database_cluster.id
  name       = "xpto"
}

resource "digitalocean_database_user" "xpto_app_user" {
  cluster_id = digitalocean_database_cluster.sorteamos_database_cluster.id
  name       = "xpto-app-user"
}
```

2. Namespace
    2.1 - Crie um arquivo chamado **xpto.yaml** dentro da pasta k8s/namespaces com o seguinte conteúdo
    ``` yaml
    apiVersion: v1
    kind: Namespace
    metadata:
        name: sorteamos-xpto
    ```

    2.2 - Adicione ao arquivo **namespaces.tf** o trecho de código abaixo:
    ```
    data "kubectl_path_documents" "xpto_namespace" {
        pattern = "${path.module}/k8s/namespaces/morin.yaml"
    }

    resource "kubectl_manifest" "xpto_namespace" {
        count     = length(data.kubectl_path_documents.xpto.documents)
        yaml_body = element(data.kubectl_path_documents.xpto.documents, count.index)

        depends_on = [
            kubectl_manifest.nginx_ingress
        ]
    }

    ```


3. Push Repo de infra
Esse push irá ativar o terraform e adicionar o novo banco de dados e usuário no servidor MySQL assim como irá efetuar a criacão do namespace sorteamos-xpto no cluster k8s.

4. Scripts Banco de Dados
Execute os scripts necessarios para criar a estrutura das tabelas e dados básicos para o novo banco de dados criado.   

5. Secrets
Aplique as secrets no novo namespaces criando o arquivo xpto-secrets.yaml no seu computador:(Modifique os valores para os que fazem sentido para o novo cliente)

``` yaml
apiVersion: v1
kind: Secret
metadata:
  name: sorteamos-secret
type: Opaque
stringData:
  APP_KEY: "base64:4i1kxCXD8fOwPEBmaEm1fDelVBvweTRHvrbgegYA/J8="
  DB_USERNAME: "xpto-app-user"
  DB_PASSWORD: ""
  REDIS_PASSWORD: ""
  MAIL_PASSWORD: ""
  AWS_ACCESS_KEY_ID: ""
  AWS_SECRET_ACCESS_KEY: ""
  PUSHER_APP_KEY: ""
  PUSHER_APP_SECRET: ""
  MIX_PUSHER_APP_KEY: ""
  VAPID_PUBLIC_KEY: ""
  VAPID_PRIVATE_KEY: ""
  ASAAS_API_KEY: ""
  GUPSHUP_PASSWORD: ""
  ZAPI_TOKEN: ""
```
Após a criacão do arquivo no seu computador execute esse comando para aplicar as secrets:
``` bash
kubectl apply -f xpto-secrets.yml -n sorteamos-xpto
```

6. Aplicacao
Crie um novo diretorio para representar a aplicacão em k8s/applications/xpto e copie os arquivos kustomization.yml e vars.properties de uma aplicacão existente.

Altere os valores das propriedades no arquivo vars.properties de acordo com os dados do novo cliente.

No arquivo kustomization.yaml altere o nome do namespace, o caminho da aplicacao e a imagem Docker desejada para o novo cliente.

``` yaml
apiVersion: kustomize.config.k8s.io/v1beta1
kind: Kustomization

bases:
  - ../base/

namespace: sorteamos-xpto

configMapGenerator:
  - name: sorteamos-config-map
    behavior: merge
    envs:
      - vars.properties

patches:
  - target:
      kind: Ingress
      name: sorteamos-ingress
    patch: |-
      - op: replace
        path: /spec/rules/0/host
        value: xpto.apps.sorteamos.online
      - op: replace
        path: /spec/tls/0/hosts/0
        value: xpto.apps.sorteamos.online
  - target:
      kind: Ingress
      name: sorteamos-ws-ingress
    patch: |-
      - op: replace
        path: /spec/rules/0/host
        value: ws.xpto.apps.sorteamos.online
      - op: replace
        path: /spec/tls/0/hosts/0
        value: ws.xpto.apps.sorteamos.online

images:
- name: registry.digitalocean.com/sorteamos/sorteamos
  newTag: Imagem Docker listada no Registry
``` 


7. ArgoCD
Precisamos adicionar a aplicacao ao ArgoCD para atualiza-la automaticamente no Kubernetes após qualquer mudanca no projeto de infra estrutura relacionada a a nova aplicacao. 

O ArgoCD monitora o repositorio de infra e qualquer mudanca nos manifestos kubernetes das aplicacões são aplicadas automaticamente ao cluster.

Um exemplo é no pipeline da aplicacão, quando mudamos a imagem docker utilizada para o projeto. Realizamos a alteracao e fazemos um push no repositorio de infra pelo pipeline. O ArgoCD verifica que a imagem mudou para a aplicacao e aplica essas mudancas no cluster.

O mesmo acontece se voce precisar ajustas algum valor de configmap ou a quantidade de replicas da aplicacao.

Qualquer mudanca nas configuracoes do projeto devem ser feitas no projeto de infraestrutura e nunca diretamente no cluster.

O ArgoCD tem a responsabilidade de manter essa estrutura atualizada com os valores definidos no projeto de infraestrutura.

Para adicionar a aplicacão ao ArgoCD siga esses passos: 

7.1 Crie um arquivo chamado **sorteamos-xpto.yaml** na pasta k8s/cluster-base/argocd/applications com o seguinte conteúdo:
``` yaml
apiVersion: argoproj.io/v1alpha1
kind: Application
metadata:
  name: sorteamos-xpto
  namespace: argocd
  finalizers:
    - resources-finalizer.argocd.argoproj.io
spec:
  project: default
  source:
    repoURL: git@github.com:devskyteam/devsky-infra.git
    targetRevision: HEAD
    path: k8s/applications/sorteamos-xpto
  destination:
    server: https://kubernetes.default.svc
    namespace: sorteamos-xpto
  syncPolicy:
    automated:
      selfHeal: true
    syncOptions:
      - CreateNamespace=true
```

7.2 Adicione ao arquivo **applications.tf** o seguinte trecho de código:
```
data "kubectl_path_documents" "argocd_application_sorteamos_xpto" {
  pattern = "${path.module}/k8s/cluster-base/argocd/applications/sorteamos-xpto.yaml"
}

resource "kubectl_manifest" "argocd_application_sorteamos_xpto" {
    count     = length(data.kubectl_path_documents.argocd_application_sorteamos_xpto.documents)
    yaml_body = element(data.kubectl_path_documents.argocd_application_sorteamos_xpto.documents, count.index)
    override_namespace = "argocd"

    depends_on = [
      kubectl_manifest.argocd
    ]
}
```

8. Realize um push no projeto de infra e a aplicacão para o novo cliente será criada com sucesso.
