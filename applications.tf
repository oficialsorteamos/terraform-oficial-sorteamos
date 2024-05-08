data "kubectl_path_documents" "argocd_application_sorteamos_clientex" {
  pattern = "${path.module}/k8s/cluster-base/argocd/applications/sorteamos-clientex.yaml"
}

resource "kubectl_manifest" "argocd_application_sorteamos_clientex" {
    count     = length(data.kubectl_path_documents.argocd_application_sorteamos_clientex.documents)
    yaml_body = element(data.kubectl_path_documents.argocd_application_sorteamos_clientex.documents, count.index)
    override_namespace = "argocd"

    depends_on = [
      kubectl_manifest.argocd
    ]
}