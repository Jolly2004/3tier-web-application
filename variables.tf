variable "aws_region" {
  description = "AWS region for deployment"
  type        = string
  default     = "ap-south-1"
}

variable "project_name" {
  description = "Prefix used for AWS resource names (lowercase letters, digits, hyphens)"
  type        = string
  default     = "three-tier-demo"
}

variable "app_instance_type" {
  description = "EC2 instance type for each application instance"
  type        = string
  default     = "t3.micro"
}

variable "db_instance_class" {
  description = "RDS MySQL instance class; check current Free Tier eligibility and pricing"
  type        = string
  default     = "db.t3.micro"
}

variable "db_name" {
  type        = string
  default     = "appdb"
}

variable "db_username" {
  type        = string
  default     = "appuser"
}

variable "db_password" {
  description = "Database password. Set via TF_VAR_db_password; Terraform state still contains sensitive values."
  type        = string
  sensitive   = true
}
variable "db_multi_az" {
  description = "Enable RDS Multi-AZ for higher availability (additional cost)"
  type        = bool
  default     = false
}
