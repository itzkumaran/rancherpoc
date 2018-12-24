variable "subnet_ids" {
  type = "map"
  default = {
    us-east-1a = "subnet-1234"
    us-east-1b = "subnet-4567"
    us-east-1c = "subnet-4567"
  }
}

variable "availability_zones" {
  type = "list"
}

variable "vpc_id" {
  type = "string"
  default = "vpc-e6173c9f"
}

variable "instance_count" {
  type = "string"
}

variable "ami_id" {
  type = "string"
}

variable "instance_type" {
  type = "string"
}

