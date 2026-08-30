variable "release_name" {
  description = "The name of the Helm release"
  type        = string
  default     = "argocd"
}

variable "chart_name" {
  description = "The name of the Argo CD Helm chart"
  type        = string
  default     = "argo-cd"
}

variable "repository_url" {
  description = "Repository URL for Argo CD Helm chart"
  type        = string
  default     = "https://argoproj.github.io/argo-helm"
}

variable "chart_version" {
  description = "The version of the Helm chart"
  type        = string
}

variable "namespace" {
  description = "The namespace where Argo CD will be installed"
  type        = string
  default     = "argocd"
}

variable "create_namespace" {
  description = "Create the namespace if it does not exist"
  type        = bool
  default     = true
}

variable "set_values" {
  description = "Custom values to set in the Helm release"

  type = list(object({
    name  = string
    value = string
  }))

  default = []
}