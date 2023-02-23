module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "cpuc-terraform_vpc"
  cidr = var.vpc_cidr

  azs                      = ["${data.aws_region.current.name}b", "${data.aws_region.current.name}c"]  # removed "${data.aws_region.current.name}a", for us-west-1
  private_subnets          = var.private_subnets
  public_subnets           = var.public_subnets
  default_route_table_tags = { DefaultRouteTable = true }

  enable_dns_hostnames   = true
  enable_dns_support     = true
  enable_nat_gateway     = true
  enable_vpn_gateway     = true
  single_nat_gateway     = true
  one_nat_gateway_per_az = false


  tags = {
    Name        = "Cpuc-Terraform-UAT-VPC"
    Terraform   = "true"
    Environment = "dev"
  }
}
