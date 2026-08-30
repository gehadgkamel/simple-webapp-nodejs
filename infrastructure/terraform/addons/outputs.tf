output "aws_load_balancer_controller_role_arn" {
  description = "IAM role ARN for AWS Load Balancer Controller"

  value = aws_iam_role.aws_load_balancer_controller.arn
}

output "nginx_ingress_status" {
  description = "NGINX Ingress Helm release status"

  value = helm_release.nginx_ingress.status
}

output "metrics_server_status" {
  description = "Metrics Server Helm release status"

  value = helm_release.metrics_server.status
}