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

resource "aws_dynamodb_table" "pqs" {
  name           = "pqs"
  billing_mode   = "PROVISIONED"
  read_capacity  = 20
  write_capacity = 20
  hash_key       = "pq-1"
  range_key      = "pqs-2"

  attribute {
    name = "pq-1"
    type = "S"
  }

  attribute {
    name = "pqs-2"
    type = "N"
  }

#   ttl {
#     attribute_name = "TimeToExist"
#     enabled        = false
#   }


  tags = {
    Name        = "Name"
    Environment = "Pqs"
  }
}