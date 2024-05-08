data "kubectl_path_documents" "morin_namespace" {
  pattern = "${path.module}/k8s/namespaces/morin.yaml"
}

resource "kubectl_manifest" "morin_namespace" {
  count     = length(data.kubectl_path_documents.morin_namespace.documents)
  yaml_body = element(data.kubectl_path_documents.morin_namespace.documents, count.index)

  depends_on = [
    kubectl_manifest.nginx_ingress
  ]
}

data "kubectl_path_documents" "inove_namespace" {
  pattern = "${path.module}/k8s/namespaces/inove.yaml"
}

resource "kubectl_manifest" "inove_namespace" {
  count     = length(data.kubectl_path_documents.inove_namespace.documents)
  yaml_body = element(data.kubectl_path_documents.inove_namespace.documents, count.index)

  depends_on = [
    kubectl_manifest.nginx_ingress
  ]
}

data "kubectl_path_documents" "devsky_namespace" {
  pattern = "${path.module}/k8s/namespaces/devsky.yaml"
}

resource "kubectl_manifest" "devsky_namespace" {
  count     = length(data.kubectl_path_documents.devsky_namespace.documents)
  yaml_body = element(data.kubectl_path_documents.devsky_namespace.documents, count.index)

  depends_on = [
    kubectl_manifest.nginx_ingress
  ]
}

data "kubectl_path_documents" "agecobassessoria_namespace" {
  pattern = "${path.module}/k8s/namespaces/agecobassessoria.yaml"
}

resource "kubectl_manifest" "agecobassessoria_namespace" {
  count     = length(data.kubectl_path_documents.agecobassessoria_namespace.documents)
  yaml_body = element(data.kubectl_path_documents.agecobassessoria_namespace.documents, count.index)

  depends_on = [
    kubectl_manifest.nginx_ingress
  ]
}

data "kubectl_path_documents" "digitaltelevendas_namespace" {
  pattern = "${path.module}/k8s/namespaces/digitaltelevendas.yaml"
}

resource "kubectl_manifest" "digitaltelevendas_namespace" {
  count     = length(data.kubectl_path_documents.digitaltelevendas_namespace.documents)
  yaml_body = element(data.kubectl_path_documents.digitaltelevendas_namespace.documents, count.index)

  depends_on = [
    kubectl_manifest.nginx_ingress
  ]
}

data "kubectl_path_documents" "rnetelecom_namespace" {
  pattern = "${path.module}/k8s/namespaces/rnetelecom.yaml"
}

resource "kubectl_manifest" "rnetelecom_namespace" {
  count     = length(data.kubectl_path_documents.rnetelecom_namespace.documents)
  yaml_body = element(data.kubectl_path_documents.rnetelecom_namespace.documents, count.index)

  depends_on = [
    kubectl_manifest.nginx_ingress
  ]
}

data "kubectl_path_documents" "multifibra_namespace" {
  pattern = "${path.module}/k8s/namespaces/multifibra.yaml"
}

resource "kubectl_manifest" "multifibra_namespace" {
  count     = length(data.kubectl_path_documents.multifibra_namespace.documents)
  yaml_body = element(data.kubectl_path_documents.multifibra_namespace.documents, count.index)

  depends_on = [
    kubectl_manifest.nginx_ingress
  ]
}

data "kubectl_path_documents" "doraealvesturismo_namespace" {
  pattern = "${path.module}/k8s/namespaces/doraealvesturismo.yaml"
}

resource "kubectl_manifest" "doraealvesturismo_namespace" {
  count     = length(data.kubectl_path_documents.doraealvesturismo_namespace.documents)
  yaml_body = element(data.kubectl_path_documents.doraealvesturismo_namespace.documents, count.index)

  depends_on = [
    kubectl_manifest.nginx_ingress
  ]
}

data "kubectl_path_documents" "doispservicos_namespace" {
  pattern = "${path.module}/k8s/namespaces/doispservicos.yaml"
}

resource "kubectl_manifest" "doispservicos_namespace" {
  count     = length(data.kubectl_path_documents.doispservicos_namespace.documents)
  yaml_body = element(data.kubectl_path_documents.doispservicos_namespace.documents, count.index)

  depends_on = [
    kubectl_manifest.nginx_ingress
  ]
}

data "kubectl_path_documents" "commcell_namespace" {
  pattern = "${path.module}/k8s/namespaces/commcell.yaml"
}

resource "kubectl_manifest" "commcell_namespace" {
  count     = length(data.kubectl_path_documents.commcell_namespace.documents)
  yaml_body = element(data.kubectl_path_documents.commcell_namespace.documents, count.index)

  depends_on = [
    kubectl_manifest.nginx_ingress
  ]
}

data "kubectl_path_documents" "visualsuper_namespace" {
  pattern = "${path.module}/k8s/namespaces/visualsuper.yaml"
}

resource "kubectl_manifest" "visualsuper_namespace" {
  count     = length(data.kubectl_path_documents.visualsuper_namespace.documents)
  yaml_body = element(data.kubectl_path_documents.visualsuper_namespace.documents, count.index)

  depends_on = [
    kubectl_manifest.nginx_ingress
  ]
}

data "kubectl_path_documents" "liquidalaces_namespace" {
  pattern = "${path.module}/k8s/namespaces/liquidalaces.yaml"
}

resource "kubectl_manifest" "liquidalaces_namespace" {
  count     = length(data.kubectl_path_documents.liquidalaces_namespace.documents)
  yaml_body = element(data.kubectl_path_documents.liquidalaces_namespace.documents, count.index)

  depends_on = [
    kubectl_manifest.nginx_ingress
  ]
}

data "kubectl_path_documents" "onofreevaladares_namespace" {
  pattern = "${path.module}/k8s/namespaces/onofreevaladares.yaml"
}

resource "kubectl_manifest" "onofreevaladares_namespace" {
  count     = length(data.kubectl_path_documents.onofreevaladares_namespace.documents)
  yaml_body = element(data.kubectl_path_documents.onofreevaladares_namespace.documents, count.index)

  depends_on = [
    kubectl_manifest.nginx_ingress
  ]
}

data "kubectl_path_documents" "onofreevaladares2_namespace" {
  pattern = "${path.module}/k8s/namespaces/onofreevaladares2.yaml"
}

resource "kubectl_manifest" "onofreevaladares2_namespace" {
  count     = length(data.kubectl_path_documents.onofreevaladares2_namespace.documents)
  yaml_body = element(data.kubectl_path_documents.onofreevaladares2_namespace.documents, count.index)

  depends_on = [
    kubectl_manifest.nginx_ingress
  ]
}

data "kubectl_path_documents" "rspiscinas_namespace" {
  pattern = "${path.module}/k8s/namespaces/rspiscinas.yaml"
}

resource "kubectl_manifest" "rspiscinas_namespace" {
  count     = length(data.kubectl_path_documents.rspiscinas_namespace.documents)
  yaml_body = element(data.kubectl_path_documents.rspiscinas_namespace.documents, count.index)

  depends_on = [
    kubectl_manifest.nginx_ingress
  ]
}

data "kubectl_path_documents" "supermarca_namespace" {
  pattern = "${path.module}/k8s/namespaces/supermarca.yaml"
}

resource "kubectl_manifest" "supermarca_namespace" {
  count     = length(data.kubectl_path_documents.supermarca_namespace.documents)
  yaml_body = element(data.kubectl_path_documents.supermarca_namespace.documents, count.index)

  depends_on = [
    kubectl_manifest.nginx_ingress
  ]
}

data "kubectl_path_documents" "cspassos_namespace" {
  pattern = "${path.module}/k8s/namespaces/cspassos.yaml"
}

resource "kubectl_manifest" "cspassos_namespace" {
  count     = length(data.kubectl_path_documents.cspassos_namespace.documents)
  yaml_body = element(data.kubectl_path_documents.cspassos_namespace.documents, count.index)

  depends_on = [
    kubectl_manifest.nginx_ingress
  ]
}

data "kubectl_path_documents" "zlionbrasil_namespace" {
  pattern = "${path.module}/k8s/namespaces/zlionbrasil.yaml"
}

resource "kubectl_manifest" "zlionbrasil_namespace" {
  count     = length(data.kubectl_path_documents.zlionbrasil_namespace.documents)
  yaml_body = element(data.kubectl_path_documents.zlionbrasil_namespace.documents, count.index)

  depends_on = [
    kubectl_manifest.nginx_ingress
  ]
}

data "kubectl_path_documents" "acriacao_namespace" {
  pattern = "${path.module}/k8s/namespaces/acriacao.yaml"
}

resource "kubectl_manifest" "acriacao_namespace" {
  count     = length(data.kubectl_path_documents.acriacao_namespace.documents)
  yaml_body = element(data.kubectl_path_documents.acriacao_namespace.documents, count.index)

  depends_on = [
    kubectl_manifest.nginx_ingress
  ]
}

data "kubectl_path_documents" "quatrogbrasil_namespace" {
  pattern = "${path.module}/k8s/namespaces/quatrogbrasil.yaml"
}

resource "kubectl_manifest" "quatrogbrasil_namespace" {
  count     = length(data.kubectl_path_documents.quatrogbrasil_namespace.documents)
  yaml_body = element(data.kubectl_path_documents.quatrogbrasil_namespace.documents, count.index)

  depends_on = [
    kubectl_manifest.nginx_ingress
  ]
}

data "kubectl_path_documents" "credmaster_namespace" {
  pattern = "${path.module}/k8s/namespaces/credmaster.yaml"
}

resource "kubectl_manifest" "credmaster_namespace" {
  count     = length(data.kubectl_path_documents.credmaster_namespace.documents)
  yaml_body = element(data.kubectl_path_documents.credmaster_namespace.documents, count.index)

  depends_on = [
    kubectl_manifest.nginx_ingress
  ]
}

data "kubectl_path_documents" "easyconnect_namespace" {
  pattern = "${path.module}/k8s/namespaces/easyconnect.yaml"
}

resource "kubectl_manifest" "easyconnect_namespace" {
  count     = length(data.kubectl_path_documents.easyconnect_namespace.documents)
  yaml_body = element(data.kubectl_path_documents.easyconnect_namespace.documents, count.index)

  depends_on = [
    kubectl_manifest.nginx_ingress
  ]
}

data "kubectl_path_documents" "multilub_namespace" {
  pattern = "${path.module}/k8s/namespaces/multilub.yaml"
}

resource "kubectl_manifest" "multilub_namespace" {
  count     = length(data.kubectl_path_documents.multilub_namespace.documents)
  yaml_body = element(data.kubectl_path_documents.multilub_namespace.documents, count.index)

  depends_on = [
    kubectl_manifest.nginx_ingress
  ]
}

data "kubectl_path_documents" "studiohorvat_namespace" {
  pattern = "${path.module}/k8s/namespaces/studiohorvat.yaml"
}

resource "kubectl_manifest" "studiohorvat_namespace" {
  count     = length(data.kubectl_path_documents.studiohorvat_namespace.documents)
  yaml_body = element(data.kubectl_path_documents.studiohorvat_namespace.documents, count.index)

  depends_on = [
    kubectl_manifest.nginx_ingress
  ]
}

data "kubectl_path_documents" "inovartelecom_namespace" {
  pattern = "${path.module}/k8s/namespaces/inovartelecom.yaml"
}

resource "kubectl_manifest" "inovartelecom_namespace" {
  count     = length(data.kubectl_path_documents.inovartelecom_namespace.documents)
  yaml_body = element(data.kubectl_path_documents.inovartelecom_namespace.documents, count.index)

  depends_on = [
    kubectl_manifest.nginx_ingress
  ]
}

data "kubectl_path_documents" "superfittelecom_namespace" {
  pattern = "${path.module}/k8s/namespaces/superfittelecom.yaml"
}

resource "kubectl_manifest" "superfittelecom_namespace" {
  count     = length(data.kubectl_path_documents.superfittelecom_namespace.documents)
  yaml_body = element(data.kubectl_path_documents.superfittelecom_namespace.documents, count.index)

  depends_on = [
    kubectl_manifest.nginx_ingress
  ]
}

data "kubectl_path_documents" "bronzemachine_namespace" {
  pattern = "${path.module}/k8s/namespaces/bronzemachine.yaml"
}

resource "kubectl_manifest" "bronzemachine_namespace" {
  count     = length(data.kubectl_path_documents.bronzemachine_namespace.documents)
  yaml_body = element(data.kubectl_path_documents.bronzemachine_namespace.documents, count.index)

  depends_on = [
    kubectl_manifest.nginx_ingress
  ]
}

data "kubectl_path_documents" "maxxitele_namespace" {
  pattern = "${path.module}/k8s/namespaces/maxxitele.yaml"
}

resource "kubectl_manifest" "maxxitele_namespace" {
  count     = length(data.kubectl_path_documents.maxxitele_namespace.documents)
  yaml_body = element(data.kubectl_path_documents.maxxitele_namespace.documents, count.index)

  depends_on = [
    kubectl_manifest.nginx_ingress
  ]
}

data "kubectl_path_documents" "mgbperfomance_namespace" {
  pattern = "${path.module}/k8s/namespaces/mgbperfomance.yaml"
}

resource "kubectl_manifest" "mgbperfomance_namespace" {
  count     = length(data.kubectl_path_documents.mgbperfomance_namespace.documents)
  yaml_body = element(data.kubectl_path_documents.mgbperfomance_namespace.documents, count.index)

  depends_on = [
    kubectl_manifest.nginx_ingress
  ]
}

data "kubectl_path_documents" "flexwave_namespace" {
  pattern = "${path.module}/k8s/namespaces/flexwave.yaml"
}

resource "kubectl_manifest" "flexwave_namespace" {
  count     = length(data.kubectl_path_documents.flexwave_namespace.documents)
  yaml_body = element(data.kubectl_path_documents.flexwave_namespace.documents, count.index)

  depends_on = [
    kubectl_manifest.nginx_ingress
  ]
}

data "kubectl_path_documents" "trestto_namespace" {
  pattern = "${path.module}/k8s/namespaces/trestto.yaml"
}

resource "kubectl_manifest" "trestto_namespace" {
  count     = length(data.kubectl_path_documents.trestto_namespace.documents)
  yaml_body = element(data.kubectl_path_documents.trestto_namespace.documents, count.index)

  depends_on = [
    kubectl_manifest.nginx_ingress
  ]
}

data "kubectl_path_documents" "portalcenter_namespace" {
  pattern = "${path.module}/k8s/namespaces/portalcenter.yaml"
}

resource "kubectl_manifest" "portalcenter_namespace" {
  count     = length(data.kubectl_path_documents.portalcenter_namespace.documents)
  yaml_body = element(data.kubectl_path_documents.portalcenter_namespace.documents, count.index)

  depends_on = [
    kubectl_manifest.nginx_ingress
  ]
}

data "kubectl_path_documents" "uptelecom_namespace" {
  pattern = "${path.module}/k8s/namespaces/uptelecom.yaml"
}

resource "kubectl_manifest" "uptelecom_namespace" {
  count     = length(data.kubectl_path_documents.uptelecom_namespace.documents)
  yaml_body = element(data.kubectl_path_documents.uptelecom_namespace.documents, count.index)

  depends_on = [
    kubectl_manifest.nginx_ingress
  ]
}

data "kubectl_path_documents" "revnatecnologia_namespace" {
  pattern = "${path.module}/k8s/namespaces/revnatecnologia.yaml"
}

resource "kubectl_manifest" "revnatecnologia_namespace" {
  count     = length(data.kubectl_path_documents.revnatecnologia_namespace.documents)
  yaml_body = element(data.kubectl_path_documents.revnatecnologia_namespace.documents, count.index)

  depends_on = [
    kubectl_manifest.nginx_ingress
  ]
}

data "kubectl_path_documents" "lucasvasconcelos_namespace" {
  pattern = "${path.module}/k8s/namespaces/lucasvasconcelos.yaml"
}

resource "kubectl_manifest" "lucasvasconcelos_namespace" {
  count     = length(data.kubectl_path_documents.lucasvasconcelos_namespace.documents)
  yaml_body = element(data.kubectl_path_documents.lucasvasconcelos_namespace.documents, count.index)

  depends_on = [
    kubectl_manifest.nginx_ingress
  ]
}

data "kubectl_path_documents" "agecobassessoriacobranca_namespace" {
  pattern = "${path.module}/k8s/namespaces/agecobassessoriacobranca.yaml"
}

resource "kubectl_manifest" "agecobassessoriacobranca_namespace" {
  count     = length(data.kubectl_path_documents.agecobassessoriacobranca_namespace.documents)
  yaml_body = element(data.kubectl_path_documents.agecobassessoriacobranca_namespace.documents, count.index)

  depends_on = [
    kubectl_manifest.nginx_ingress
  ]
}

data "kubectl_path_documents" "confiauto_namespace" {
  pattern = "${path.module}/k8s/namespaces/confiauto.yaml"
}

resource "kubectl_manifest" "confiauto_namespace" {
  count     = length(data.kubectl_path_documents.confiauto_namespace.documents)
  yaml_body = element(data.kubectl_path_documents.confiauto_namespace.documents, count.index)

  depends_on = [
    kubectl_manifest.nginx_ingress
  ]
}

data "kubectl_path_documents" "vipseg_namespace" {
  pattern = "${path.module}/k8s/namespaces/vipseg.yaml"
}

resource "kubectl_manifest" "vipseg_namespace" {
  count     = length(data.kubectl_path_documents.vipseg_namespace.documents)
  yaml_body = element(data.kubectl_path_documents.vipseg_namespace.documents, count.index)

  depends_on = [
    kubectl_manifest.nginx_ingress
  ]
}

data "kubectl_path_documents" "lsprojetos_namespace" {
  pattern = "${path.module}/k8s/namespaces/lsprojetos.yaml"
}

resource "kubectl_manifest" "lsprojetos_namespace" {
  count     = length(data.kubectl_path_documents.lsprojetos_namespace.documents)
  yaml_body = element(data.kubectl_path_documents.lsprojetos_namespace.documents, count.index)

  depends_on = [
    kubectl_manifest.nginx_ingress
  ]
}

data "kubectl_path_documents" "litoralquadriciclos_namespace" {
  pattern = "${path.module}/k8s/namespaces/litoralquadriciclos.yaml"
}

resource "kubectl_manifest" "litoralquadriciclos_namespace" {
  count     = length(data.kubectl_path_documents.litoralquadriciclos_namespace.documents)
  yaml_body = element(data.kubectl_path_documents.litoralquadriciclos_namespace.documents, count.index)

  depends_on = [
    kubectl_manifest.nginx_ingress
  ]
}

data "kubectl_path_documents" "liquidalacessac_namespace" {
  pattern = "${path.module}/k8s/namespaces/liquidalacessac.yaml"
}

resource "kubectl_manifest" "liquidalacessac_namespace" {
  count     = length(data.kubectl_path_documents.liquidalacessac_namespace.documents)
  yaml_body = element(data.kubectl_path_documents.liquidalacessac_namespace.documents, count.index)

  depends_on = [
    kubectl_manifest.nginx_ingress
  ]
}