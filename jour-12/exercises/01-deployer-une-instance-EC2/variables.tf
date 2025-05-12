variable "aws_region" {
  description = "La région AWS où déployer l'instance"
  type        = string
  default     = "eu-west-3"
}

variable "instance_name" {
  description = "Le nom (tag Name) de l'instance EC2"
  type        = string
}

variable "instance_ami" {
  description = "AMI ID à utiliser pour l'instance"
  type        = string
}

variable "instance_type" {
  description = "Type d'instance EC2"
  type        = string
  default     = "t3.micro"
}

variable "key_name" {
  description = "Nom de la key pair AWS pour SSH"
  type        = string
}

variable "public_key_path" {
  description = "Chemin vers le fichier de clé publique SSH à importer dans AWS"
  type        = string
  default     = "~/.ssh/id_rsa.pub"
}