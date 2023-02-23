provider "aws" {
    region = "us-east-1"
    secret_key = ""
    access_key = ""
}

terraform {
  backend "s3" {
     encrypt = false
     bucket = "tf-state-s3"
     dynamodb_table = "tf-state-lock-dynamo"
     key = "path/path/terraform-tfstate"
     region = "us-east-1"
  }
}

resource "aws_vpc" "ntf_test" {
    cidr_block = "10.0.0.0/16"
    instance_tenancy = "default"
    enable_dns_support = true
    tags = {
        Name = "tf_test"
    }
}  

resource "aws_subnet" "Subnet-tf_test" {
    vpc_id = aws_vpc.tf_test.id
    cidr_block = "10.0.1.0/24"
    availability_zone = "us-east-1a"
    tags = {
        "Name" = "Subnet-tf_test"
    }
}

resource "aws_subnet" "Subnet-tf_test" {
    vpc_id = aws_vpc.tf_test.id
    cidr_block = "10.0.2.0/24"
    availability_zone = "us-east-1b"
    tags = {
        "Name" = "Subnet-tf_test"
    }
}