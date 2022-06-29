variable "ami_id" {
    type = string
    default = "ami-0c1bc246476a5572b"
}

variable "instance_type" {
    type = string
    default = "t2.micro"
}

variable "associate_public_ip_address" {
    type = bool
    default = true
}

variable "key_name" {
    type = string
    default = "stav_hard_1"
}

variable "app_tag" {
    type = string
    default = "stav_app"
}

variable "instance_port" {
    type = string
    default = "5000"
}

variable "instance_protocol" {
    type = string
    default = "tcp"
}

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

variable "security_group_name" {
    type = string
    default = "stav-terraform-sg"
}

variable "ingress_form_port" {
    type = string
    default = "5000"
}

variable "ingress_to_port" {
    type = string
    default = "5000"
}

variable "ingress_protocol" {
    type = string
    default = "TCP"
}

variable "ingress_ssh_form_port" {
    type = string
    default = "22"
}

variable "ingress_ssh_to_port" {
    type = string
    default = "22"
}

variable "ingress_ssh_protocol" {
    type = string
    default = "TCP"
}

variable "ingress_cidr" {
    type = string
    default = "52.208.130.142/32"
}

variable "aws_region" {
    type = string
    default = "eu-west-1"
}

variable "ecr_name" {
    type = string
    default = "stav-app"
}