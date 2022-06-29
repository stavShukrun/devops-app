module "network" {
  source = "./modules/network"
  vpc_cidr = var.vpc_cidr
  subnet_cidr = var.subnet_cidr
  subnet_az = var.subnet_az
  vpc_tag_name = var.vpc_tag_name
  subnet_tag_name = var.subnet_tag_name
}

module "eks" {
  source = "./modules/eks"
  vpc_id     = module.network.output_vpc_id
  subnet_ids = [module.network.private_subnet_1_id,
                module.network.private_subnet_2_id,
                module.network.public_subnet_1_id,
                module.network.public_subnet_2_id]
  aws_region = var.aws_region

}