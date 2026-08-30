output "cluster_name" {
  description = "The name of the EKS cluster."
  value       = aws_eks_cluster.eks.name
}

output "cluster_endpoint" {
  description = "Endpoint for your Kubernetes API server."
  value       = aws_eks_cluster.eks.endpoint
}
output "cluster_certificate_authority_data" {
  description = "Base64 encoded certificate authority data for the EKS cluster."

  value = aws_eks_cluster.eks.certificate_authority[0].data
}
output "cluster_iam_role_name" {
  description = "IAM role name of the EKS cluster."
  value       = aws_iam_role.eks.name
}

output "oidc_provider_arn" {
  description = "The ARN of the OIDC Provider"
  value       = aws_iam_openid_connect_provider.eks.arn
}

output "oidc_provider_url" {
  description = "The URL of the OIDC Provider"
  value       = aws_eks_cluster.eks.identity[0].oidc[0].issuer
}
output "oidc_provider" {
  description = "OIDC provider URL without https prefix"
  value = replace(
    aws_eks_cluster.eks.identity[0].oidc[0].issuer,
    "https://",
    ""
  )
}