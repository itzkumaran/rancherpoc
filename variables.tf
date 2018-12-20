variable "subnet_ids" {
  type = "map"

  default = {
    us-east-1a = "image-1234"
    us-east-1b = "image-4567"
        us-east-1c = "image-4567"
  }
}

variable "zones" {
  type = "list"
  default = ["us-east-1a", "us-east-1b", "us-east-1b"]
}

variable "instance_count" {
  type = "string"
  default = "1"
}

variable "vpc_id" {
  type = "string"
  default = "vpc_ssss"
}
