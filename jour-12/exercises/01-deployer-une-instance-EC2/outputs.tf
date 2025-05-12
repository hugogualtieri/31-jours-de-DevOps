output "instance_id" {
  description = "ID de l'instance EC2"
  value       = aws_instance.web_server.id
}

output "instance_arn" {
  description = "ARN complet de l'instance EC2"
  value       = aws_instance.web_server.arn
}

output "instance_name" {
  description = "Nom de l'instance (tag Name)"
  value       = aws_instance.web_server.tags["Name"]
}

output "instance_public_ip" {
  description = "Adresse IPv4 publique de l'instance"
  value       = aws_instance.web_server.public_ip
}
