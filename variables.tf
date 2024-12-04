variable "region" {
  default = "us-east-1"
  description = "AWS region to deploy resources"
}

variable "vpc_cidr" {
  default = "10.0.0.0/16"
  description = "CIDR block for the VPC"
}

variable "public_subnet_cidrs" {
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
  description = "CIDR blocks for public subnets"
}

variable "private_app_subnet_cidrs" {
  type        = list(string)
  default     = ["10.0.3.0/24", "10.0.4.0/24"]
  description = "CIDR blocks for private app subnets"
}

variable "private_db_subnet_cidrs" {
  type        = list(string)
  default     = ["10.0.5.0/24", "10.0.6.0/24"]
  description = "CIDR blocks for private database subnets"
}

variable "azs" {
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b"]
  description = "Availability zones"
}
