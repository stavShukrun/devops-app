variable "vpc_cidr" {
    type = string
    default = "10.0.0.0/16"
}

variable "subnet_cidr" {
    type = string
    default = "10.0.0.0/28"
}

variable "subnet_az" {
    type = string
    default = "eu-west-1a"
}

variable "vpc_tag_name" {
    type = string
    default = "stav-terraform-vpc"
}

variable "subnet_tag_name" {
    type = string
    default = "stav-subnet"
}

variable "aws_region" {
  type        = string
  default     = "eu-west-1"
}