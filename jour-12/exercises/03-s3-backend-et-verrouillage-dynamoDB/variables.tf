variable "aws_region" {
  description = "Région AWS où déployer"
  type        = string
  default     = "eu-west-3"
}

variable "instance_type" {
  description = "Type d’instance EC2"
  type        = string
  default     = "t3.micro"
}

variable "instance_ami" {
  description = "AMI ID à utiliser"
  type        = string
}

variable "instance_names" {
  description = "Liste des noms pour les instances"
  type        = list(string)
}

variable "key_name" {
  description = "Nom de la Key Pair AWS"
  type        = string
}

variable "public_key_path" {
  description = "Chemin absolu vers la clé publique SSH"
  type        = string
}
