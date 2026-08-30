resource "helm_release" "argocd" {

  name = var.release_name

  repository = var.repository_url

  chart = var.chart_name

  version = var.chart_version

  namespace = var.namespace

  create_namespace = var.create_namespace

  dynamic "set" {
    for_each = var.set_values

    content {
      name  = set.value.name
      value = set.value.value
    }
  }

}
