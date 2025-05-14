# Exercices

## Exercice 1: Déploiement d’un serveur web sur 3 machines

Objectif: Installer et configurer un serveur Nginx sur plusieurs machines.

Tâches:

- Installer le serveur web.
- Déployer une page d’accueil personnalisée.
- S’assurer que le service est activé et en cours d’exécution.
- Mettre en œuvre de l’idempotence

## Exercice 2: Déploiement dynamique d'un serveur web

Tâches:

- Créer un rôle ansible pour le déploiement de webserveur
- Utilisez un template pour la page html:

```html
<!DOCTYPE html>
<html lang="fr">
  <head>
    <meta charset="UTF-8" />
    <title>{{ page_title }}</title>
  </head>
  <body>
    <h1>{{ welcome_message }}</h1>
    <p><strong>Nom d'hôte :</strong> {{ inventory_hostname }}</p>
    <p><strong>Adresse IP :</strong> {{ ansible_default_ipv4.address }}</p>
    <p>
      <strong>Date :</strong> {{ ansible_date_time.date }} {{
      ansible_date_time.time }}
    </p>
    <p><em>Contact administrateur : {{ admin_contact }}</em></p>
  </body>
</html>
```

- Créer et utiliser des variables (page_title, welcome_message, admin_contact)

## Exercice 3: Automatiser le provisionnement des 3 machines et la configuration des webserveurs

Objectif: Utiliser Ansible pour configurer les webserveurs lors du provisionnement avec Terraform et exposer les avec un ALB (Application Load Balancer).
