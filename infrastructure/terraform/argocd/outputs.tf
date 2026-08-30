output "name" {
  description = "The name of the Helm release"
  value       = helm_release.argocd.name
}

output "namespace" {
  description = "The namespace where Argo CD is installed"
  value       = helm_release.argocd.namespace
}

output "metadata" {
  description = "Status of the deployed Helm release"
  value       = helm_release.argocd.metadata
}