# Exercices

## Exercice 1: Pipeline multi-stages simple

Créer un pipeline CI/CD basique comportant trois stages :

1. **test**  
2. **build**  
3. **deploy**

Chaque job doit simplement afficher un message spécifique :

- `test` : affiche « Hello test job »
- `build` : affiche « Hello build job »
- `deploy` : affiche « Hello deploy job »

## Exercice 2: Pipeline CI/CD pour un projet ReactJS

Mettre en place un pipeline GitLab CI/CD complet pour un projet ReactJS, comprenant :

1. **Tests unitaires** avec couverture  
2. **Build** de l’application  
3. **Déploiement** sur Netlify en réutilisant les artefacts du build

## Exercice 3: Gérer plusieurs environnements (dev & prod)