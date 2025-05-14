output "instance_ids" {
  value = module.ec2.instance_ids
}

output "instance_arns" {
  value = module.ec2.instance_arns
}

output "instance_names" {
  value = module.ec2.instance_names
}

output "instance_public_ips" {
  value = module.ec2.instance_public_ips
}

output "alb_dns_name" {
  description = "DNS name de l'Application Load Balancer pour accéder aux instances EC2"
  value       = aws_lb.nginx_alb.dns_name
}
