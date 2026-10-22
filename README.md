# AWS 3-Tier Web Application with Terraform

This project provisions a learning/demo 3-tier architecture in AWS:

- **Web tier:** internet-facing Application Load Balancer in 2 public subnets
- **Application tier:** 2 EC2 instances in private subnets, managed by an Auto Scaling Group, running Flask
- **Database tier:** private Amazon RDS for MySQL in dedicated private DB subnets
- **Networking:** VPC, Internet Gateway, one NAT Gateway, route tables, and security groups

## Prerequisites

- Terraform >= 1.5
- AWS CLI configured (`aws configure`) with permission to create VPC, EC2, ELB, Auto Scaling, RDS, IAM-independent resources, and Elastic IPs
- AWS account quota allowing the selected resources

## Deploy (PowerShell)

From this directory:

```powershell
terraform init
$env:TF_VAR_db_password = "Choose-A-Strong-Password-Here!"
terraform fmt -recursive
terraform validate
terraform plan -out=tfplan
terraform apply tfplan
terraform output
```

Open the `application_url` output in your browser. Also open `application_process_url`, `application_health_url`, and `database_health_url`.

The ALB can take several minutes to mark both instances healthy. If the page does not load immediately, wait 3–5 minutes and refresh.

## Deploy (Linux/macOS)

```bash
terraform init
export TF_VAR_db_password='Choose-A-Strong-Password-Here!'
terraform fmt -recursive
terraform validate
terraform plan -out=tfplan
terraform apply tfplan
terraform output
```

## Inspect progress and troubleshoot

```bash
terraform output
terraform state list
aws elbv2 describe-target-health --target-group-arn "$(terraform output -raw target_group_arn)"
```

The target group ARN is not currently exported as an output in this starter. To inspect it without adding an output, use the AWS Console: EC2 → Target Groups → `three-tier-demo-tg` → Targets.

For an instance's user-data logs, connect using AWS Systems Manager if you configure SSM permissions/agent access, or use approved administrative access. This demo does not open SSH to the internet.

## Cleanup

Destroy the resources when finished to avoid ongoing charges:

```bash
terraform destroy
```

## Important security and cost notes

- This creates billable resources, including a NAT Gateway, ALB, and RDS. Charges can accrue even when traffic is low. Check current AWS pricing and free-tier eligibility first.
- This is a learning project, not production-ready. It uses HTTP, not HTTPS.
- Terraform state contains the RDS password and rendered user data. Keep state private; do not commit state files or real credentials.
- For production, use AWS Secrets Manager, TLS/ACM, least-privilege IAM, logging/monitoring, encrypted state, tighter egress rules, and Multi-AZ database deployment.
- The app's database health endpoint reports database connection errors if the database is still starting or credentials/networking are wrong.
