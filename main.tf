terraform {
 required_providers {
   aws = {
     source = "hashicorp/aws"
   }
 }
}
    
provider "aws" {
  region     = var.region
  access_key = var.key
  secret_key = var.sec_key
}

resource "aws_dynamodb_table" "Parsley" {
  name           = "Parsley"
  billing_mode   = "PROVISIONED"
  read_capacity  = 5
  write_capacity = 5
  hash_key       = "Parsley-1"
  range_key      = "Parsley-2"

  attribute {
    name = "Parsley-1"
    type = "S"
  }

  attribute {
    name = "Parsley-2"
    type = "N"
  }

  tags = {
    Name        = "Name"
    Environment = "Parsley"
  }
}