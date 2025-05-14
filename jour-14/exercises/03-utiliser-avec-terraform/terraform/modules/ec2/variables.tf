variable "instance_names" {
  description = "Liste des noms d'instance"
  type        = list(string)
}

variable "instance_ami" {
  description = "AMI ID"
  type        = string
}

variable "instance_type" {
  description = "Type d’instance"
  type        = string
  default     = "t3.micro"
}

variable "key_name" {
  description = "Nom de la Key Pair AWS"
  type        = string
}

variable "public_key_path" {
  description = "Chemin absolu vers la clé publique SSH"
  type        = string
}

variable "subnet_ids" {
  description = "Liste des IDs de sous-réseaux publics"
  type        = list(string)
}

variable "security_group_ids" {
  description = "Liste des SG à appliquer"
  type        = list(string)
}