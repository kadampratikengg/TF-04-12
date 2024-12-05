variable "region" {
  description = "AWS region"
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
}

variable "public_subnet_cidrs" {
  type        = list(string)
  description = "CIDR blocks for public subnets"
}


variable "private_app_subnet_cidrs" {
  type        = list(string)
  description = "CIDR blocks for private app subnets"
}

variable "private_db_subnet_cidrs" {
  type        = list(string)
  description = "CIDR blocks for private database subnets"
}

variable "azs" {
  type        = list(string)
  description = "Availability zones"
}
