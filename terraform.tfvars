region                  = "us-east-1"
vpc_cidr               = "10.0.0.0/16"
public_subnet_cidrs    = ["10.0.1.0/24", "10.0.2.0/24"]
private_app_subnet_cidrs = ["10.0.3.0/24", "10.0.4.0/24"]
private_db_subnet_cidrs = ["10.0.5.0/24", "10.0.6.0/24"]
azs                    = ["us-east-1a", "us-east-1b"]