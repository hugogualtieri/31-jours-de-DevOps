output "vpc_id" {
  value = aws_vpc.main.id
}

output "public_subnet_id" {
  value = aws_subnet.public_a.id
}

output "public_subnet_ids" {
  value = [aws_subnet.public_a.id, aws_subnet.public_b.id]
}

output "allow_ssh_sg_id" {
  value = aws_security_group.allow_ssh.id
}

output "allow_http_sg_id" {
  value = aws_security_group.allow_http.id
}
