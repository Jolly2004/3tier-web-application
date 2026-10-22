output "application_url" {
  description = "Open this URL after the ALB target group becomes healthy"
  value       = "http://${aws_lb.main.dns_name}"
}

output "application_process_url" {
  description = "Page describing the deployment workflow"
  value       = "http://${aws_lb.main.dns_name}/process"
}

output "application_health_url" {
  description = "Application health check"
  value       = "http://${aws_lb.main.dns_name}/health"
}

output "database_health_url" {
  description = "Database connectivity health check"
  value       = "http://${aws_lb.main.dns_name}/health/db"
}

output "load_balancer_dns" {
  value = aws_lb.main.dns_name
}

output "vpc_id" {
  value = aws_vpc.main.id
}

output "public_subnet_ids" {
  value = aws_subnet.public[*].id
}

output "private_app_subnet_ids" {
  value = aws_subnet.private_app[*].id
}

output "private_db_subnet_ids" {
  value = aws_subnet.private_db[*].id
}

output "rds_endpoint" {
  description = "Private endpoint; reachable only from the application security group"
  value       = aws_db_instance.mysql.address
}

output "deployment_summary" {
  value = <<-EOT
  3-TIER TERRAFORM DEPLOYMENT
  1. Created VPC and Internet Gateway.
  2. Created 2 public, 2 private application, and 2 private database subnets.
  3. Configured public and private route tables plus a NAT Gateway.
  4. Created security groups for ALB, application EC2, and RDS.
  5. Created private Amazon RDS MySQL database.
  6. Created an Application Load Balancer and HTTP listener.
  7. Created a Launch Template and 2-instance Auto Scaling Group.
  8. Bootstrapped Flask application on EC2 using EC2 user data.
  9. Application dashboard and /process page show the deployment details.
  IMPORTANT: wait for EC2 user data and ALB target health checks to finish.
  EOT
}
