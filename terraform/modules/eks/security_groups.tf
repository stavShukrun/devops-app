resource "aws_security_group" "stav_terraform_sg" {
    name = var.security_group_name
    description = "app sg"
    vpc_id = var.vpc_id

    ingress {
        description = "open port 80 for nginx"
        from_port = var.ingress_form_port
        to_port = var.ingress_to_port
        protocol = var.ingress_protocol
        cidr_blocks = ["0.0.0.0/0"]
        ipv6_cidr_blocks = [ "::/0" ]
    }

    ingress {
        description = "ssh from sg"
        from_port = var.ingress_ssh_form_port
        to_port = var.ingress_ssh_to_port
        protocol = var.ingress_ssh_protocol
        cidr_blocks = [var.ingress_cidr]
        ipv6_cidr_blocks = [ "::/0" ]
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
        ipv6_cidr_blocks = [ "::/0" ]
    }

    tags = {
      Name = var.security_group_name
    }
}