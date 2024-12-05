region                  = "us-west-2"
vpc_cidr               = "10.1.0.0/16"
public_subnet_cidrs    = ["10.1.1.0/24", "10.1.2.0/24"]
private_app_subnet_cidrs = ["10.1.3.0/24", "10.1.4.0/24"]
private_db_subnet_cidrs = ["10.1.5.0/24", "10.1.6.0/24"]
azs                    = ["us-west-2a", "us-west-2b"]
