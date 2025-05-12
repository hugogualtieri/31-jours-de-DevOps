output "vpc_id" {
  value = aws_vpc.main.id
}

output "public_subnet_id" {
  value = aws_subnet.public.id
}

output "allow_ssh_sg_id" {
  value = aws_security_group.allow_ssh.id
}