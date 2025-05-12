module "networking" {
  source = "./modules/networking"
}

module "ec2" {
  source = "./modules/ec2"

  instance_names = var.instance_names
  instance_ami   = var.instance_ami
  instance_type  = var.instance_type

  key_name        = var.key_name
  public_key_path = var.public_key_path

  subnet_id          = module.networking.public_subnet_id
  security_group_ids = [module.networking.allow_ssh_sg_id]
}
