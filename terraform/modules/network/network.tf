resource "aws_vpc" "stav-terraform-vpc" {
    cidr_block = var.vpc_cidr
    tags = {
      Name = var.vpc_tag_name
    }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.stav-terraform-vpc.id

  tags = {
    Name = "igw"
  }
}

resource "aws_subnet" "private_subnet_1" {
  vpc_id            = aws_vpc.stav-terraform-vpc.id
  cidr_block        = "10.0.0.0/19"
  availability_zone = "${var.aws_region}a"

  tags = {
    "Name"                            = "${var.aws_region}a"
    "kubernetes.io/role/internal-elb" = "1"
    "kubernetes.io/cluster/stav-eks"     = "owned"
  }
}

resource "aws_subnet" "private_subnet_2" {
  vpc_id            = aws_vpc.stav-terraform-vpc.id
  cidr_block        = "10.0.32.0/19"
  availability_zone = "${var.aws_region}b"

  tags = {
    "Name"                            = "${var.aws_region}b"
    "kubernetes.io/role/internal-elb" = "1"
    "kubernetes.io/cluster/stav-eks"  = "owned"
  }
}

resource "aws_subnet" "public_subnet_1" {
  vpc_id                  = aws_vpc.stav-terraform-vpc.id
  cidr_block              = "10.0.64.0/19"
  availability_zone       = "${var.aws_region}a"
  map_public_ip_on_launch = true

  tags = {
    "Name"                        = "public-${var.aws_region}a"
    "kubernetes.io/role/elb"      = "1"
    "kubernetes.io/cluster/stav-eks" = "owned"
  }
}

resource "aws_subnet" "public_subnet_2" {
  vpc_id                  = aws_vpc.stav-terraform-vpc.id
  cidr_block              = "10.0.96.0/19"
  availability_zone       = "${var.aws_region}b"
  map_public_ip_on_launch = true

  tags = {
    "Name"                        = "public-${var.aws_region}b"
    "kubernetes.io/role/elb"      = "1"
    "kubernetes.io/cluster/stav-eks" = "owned"
  }
}

resource "aws_eip" "nat" {
  vpc = true

  tags = {
    Name = "nat"
  }
}

resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.public_subnet_1.id

  tags = {
    Name = "nat"
  }

  depends_on = [aws_internet_gateway.igw]
}

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.stav-terraform-vpc.id

  route = [
    {
      cidr_block                 = "0.0.0.0/0"
      nat_gateway_id             = aws_nat_gateway.nat.id
      carrier_gateway_id         = ""
      destination_prefix_list_id = ""
      egress_only_gateway_id     = ""
      gateway_id                 = ""
      instance_id                = ""
      ipv6_cidr_block            = ""
      local_gateway_id           = ""
      network_interface_id       = ""
      transit_gateway_id         = ""
      vpc_endpoint_id            = ""
      vpc_peering_connection_id  = ""
    },
  ]

  tags = {
    Name = "private"
  }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.stav-terraform-vpc.id

  route = [
    {
      cidr_block                 = "0.0.0.0/0"
      gateway_id                 = aws_internet_gateway.igw.id
      nat_gateway_id             = ""
      carrier_gateway_id         = ""
      destination_prefix_list_id = ""
      egress_only_gateway_id     = ""
      instance_id                = ""
      ipv6_cidr_block            = ""
      local_gateway_id           = ""
      network_interface_id       = ""
      transit_gateway_id         = ""
      vpc_endpoint_id            = ""
      vpc_peering_connection_id  = ""
    },
  ]

  tags = {
    Name = "public"
  }
}

resource "aws_route_table_association" "private_rt_1" {
  subnet_id      = aws_subnet.private_subnet_1.id
  route_table_id = aws_route_table.private.id
}

resource "aws_route_table_association" "private_rt_2" {
  subnet_id      = aws_subnet.private_subnet_2.id
  route_table_id = aws_route_table.private.id
}

resource "aws_route_table_association" "public_rt_1" {
  subnet_id      = aws_subnet.public_subnet_1.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "public_rt_2" {
  subnet_id      = aws_subnet.public_subnet_2.id
  route_table_id = aws_route_table.public.id
}