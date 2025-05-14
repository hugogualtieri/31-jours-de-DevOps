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

  subnet_ids         = module.networking.public_subnet_ids
  security_group_ids = [module.networking.allow_ssh_sg_id, module.networking.allow_http_sg_id]
}

locals {
  ansible_inventory = templatefile("${path.module}/../ansible/inventory/inventory.tpl", {
    public_ips = module.ec2.instance_public_ips
  })
}

resource "local_file" "ansible_inventory" {
  content  = local.ansible_inventory
  filename = "${path.module}/../ansible/inventory/hosts.ini"
}

resource "null_resource" "run_ansible" {
  depends_on = [module.ec2.aws_instance]

  provisioner "local-exec" {
    command = <<EOT
      echo "Attente de 60 secondes pour permettre aux instances de démarrer..."
      sleep 60
      ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i ./../ansible/inventory/hosts.ini ./../ansible/site.yml --private-key ~/.ssh/id_rsa
    EOT
  }
}

resource "aws_lb" "nginx_alb" {
  name               = "nginx-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [module.networking.allow_http_sg_id]
  subnets            = module.networking.public_subnet_ids
}

resource "aws_lb_target_group" "nginx_tg" {
  name     = "nginx-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = module.networking.vpc_id
}

resource "aws_lb_listener" "nginx_listener" {
  load_balancer_arn = aws_lb.nginx_alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.nginx_tg.arn
  }
}

resource "aws_lb_target_group_attachment" "tg_attachment" {
  for_each         = { for idx, instance in module.ec2.instances : idx => instance }
  target_group_arn = aws_lb_target_group.nginx_tg.arn
  target_id        = each.value.id
  port             = 80
}
