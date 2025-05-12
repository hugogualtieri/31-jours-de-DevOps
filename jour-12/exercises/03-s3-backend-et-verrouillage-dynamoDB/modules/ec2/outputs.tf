output "instance_ids" {
  value = aws_instance.web[*].id
}

output "instance_arns" {
  value = aws_instance.web[*].arn
}

output "instance_names" {
  value = aws_instance.web[*].tags["Name"]
}

output "instance_public_ips" {
  value = aws_instance.web[*].public_ip
}
