# Exercices

## Exercice 1: Déployer une instance EC2

Objectif : Avec Terraform, provisionner une infrastructure AWS complète composée:

- D’un VPC (CIDR 10.0.0.0/16)
- D’un subnet public (CIDR 10.0.1.0/24, map_public_ip_on_launch = true)
- D’une Internet Gateway + Route Table (route 0.0.0.0/0 → IGW)
- D’un groupe de sécurité SSH (ingress TCP 22 depuis 0.0.0.0/0)
- D'une paire de clé avec une clé ssh locale
- D’une instance EC2 dans ce subnet, taggée { Name = var.instance_name }

Variables:

- aws_region (string, default "eu-west-3")
- instance_type (string, default "t3.micro")
- instance_name (string, sans valeur par défaut)
- instance_ami (string, sans valeur par défaut)
- key_name (string, sans valeur par défaut)

Outputs:

- instance_id → aws_instance.web_server.id
- instance_arn → aws_instance.web_server.arn
- instance_name → aws_instance.web_server.tags["Name"]
- instance_public_ip → aws_instance.web_server.public_ip

## Exercice 2: Modulariser l'infrastructure

Objectif: Étendre l’exercice 1 en modulaire pour provisionner via Terraform.

- Un module networking qui crée un VPC dédié, un subnet public, une IGW, une table de routage publique, un SG SSH et une paire de clé avec une clé ssh locale.
- Un module ec2 qui déploie N instances EC2 (paramétrées par count) dans ce réseau.

Paramètres (variables):

- aws_region (string, default "eu-west-3")
- instance_type (string, default "t3.micro")
- instance_ami (string, sans default)
- instance_names (list(string), nom de chaque instance)
- key_name (string)
- public_key_path (string, chemin absolu vers la clé publique SSH)

Fonctionnalités:

- Réutilisation du module networking dans main.tf.
- Déploiement de 3 EC2 (ou plus selon la longueur de instance_names) via le module ec2.
- Association de la Key Pair importée (key_name + public_key_path).
- Accès SSH possible sur chaque instance.

Outputs attendus:

- instance_ids (list)
- instance_arns (list)
- instance_names (list)
- instance_public_ips (list)

## Exercice 3: Centraliser l'état sur S3 et verrouillage avec dynamDB

**Objectif:** Centraliser l’état Terraform dans un bucket S3 et le protéger contre les accès concurrents via le verrouillage DynamoDB.

**Étapes à réaliser:**

1. Créer un bucket S3 versionné et chiffré pour stocker le fichier d’état (terraform.tfstate).
2. Créer une table DynamoDB (LockID en clé primaire) pour gérer le state locking.
3. Définir dans votre code le bloc backend "s3" avec les paramètres :

- bucket (nom du bucket)
- key (chemin/nom du fichier .tfstate)
- region
- dynamodb_table
- encrypt = true

4. Exécuter terraform init pour migrer et valider la configuration du backend.

**Résultat attendu:**

- Votre état Terraform est centralisé dans S3.
- Les opérations plan et apply sont verrouillées via DynamoDB pour éviter toute modification concurrente.
