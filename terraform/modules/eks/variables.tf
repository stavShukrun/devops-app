variable "aws_region" {
  type        = string
  default     = "eu-west-1"
}

variable "instance_types" {
  type        = string
  default     = "t2.micro"
}

variable "ami_id" {
    type = string
    default = "ami-0c1bc246476a5572b"
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
    default = "80"
}

variable "instance_protocol" {
    type = string
    default = "tcp"
}

variable "security_group_name" {
    type = string
    default = "stav-terraform-sg"
}

variable "ingress_form_port" {
    type = string
    default = "80"
}

variable "ingress_to_port" {
    type = string
    default = "80"
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

variable "vpc_id" {
    type = string
    description = "The vpc ID from the network module"
}

variable "subnet_ids" {
    type = list
    description = "The subnets ID from the network module"
}