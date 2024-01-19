# Application de Gestion des Événements Sportifs

## Introduction

Bienvenue dans l'application de gestion des événements sportifs! Cette application offre des fonctionnalités pour créer, promouvoir et gérer des événements sportifs. Elle est développée en utilisant Spring Boot pour le backend, Spring Security pour la sécurité, et Flutter pour le frontend.

## Fonctionnalités

### 1. Création d'Événements

- Créez des événements sportifs en spécifiant le lieu, le type (Marathon, Football, Basketball, etc.) et joignez une carte d'événement avec une photo représentant le type d'événement.

### 2. Promotion d'Événements

- Promouvez vos événements en envoyant des invitations par e-mail à des personnes spécifiques. La fonctionnalité d'envoi d'e-mails est gérée par la bibliothèque email.js.

### 3. Contraintes des Labels

- Le respect des contraintes des labels lors de l'insertion des événements est exigé. Cela garantit une meilleure organisation et classification des événements.

## Technologies Utilisées

- **Backend:**
  - Spring Boot
  - Spring Security
  - Base de données (MySQL)

- **Frontend:**
  - Flutter

## Configuration

### Backend (Spring Boot)

1. Clonez le dépôt depuis (https://github.com/iir-projets/projet-flutter-g7-sas_sayout/tree/main).
2. Configurez votre base de données dans le fichier `application.properties` port 8080.
3. Exécutez l'application Spring Boot.

### Frontend (Flutter)

1. Clonez le dépôt depuis https://github.com/iir-projets/projet-flutter-g7-sas_sayout/tree/main.
2. Configurez l'URL du backend dans le fichier `lib/api.dart`.
3. Exécutez l'application Flutter.

## Capture d'écran

![image](https://github.com/iir-projets/projet-flutter-g7-sas_sayout/assets/101131509/bc0d1627-5ea6-44b0-835b-3475063cb63c)

Login:

![image](https://github.com/iir-projets/projet-flutter-g7-sas_sayout/assets/101131509/284db3eb-97f9-4d89-98c7-1cfacf23d6d6)

Register:

![image](https://github.com/iir-projets/projet-flutter-g7-sas_sayout/assets/101131509/05ac5aa1-cbe6-482a-aa3d-9d26ce59770e)

Listes des evenements :

![image](https://github.com/iir-projets/projet-flutter-g7-sas_sayout/assets/101131509/f55e8138-c387-4bc5-811a-dc87085d8c51)

Filter par bottom navigation bar (icon):

![image](https://github.com/iir-projets/projet-flutter-g7-sas_sayout/assets/101131509/01e53281-313e-479b-9bb6-d6f89ba29c1a)

Information de chaque evenements :

![image](https://github.com/iir-projets/projet-flutter-g7-sas_sayout/assets/101131509/269532fe-bb12-439e-bfc3-687235971fa8)


![image](https://github.com/iir-projets/projet-flutter-g7-sas_sayout/assets/101131509/ca1fed0d-5a55-4565-b7ef-5606831ccd47)

Partie de participer :

![image](https://github.com/iir-projets/projet-flutter-g7-sas_sayout/assets/101131509/b5401710-ea7a-4e2c-b442-ccb2a3a24859)

Promovoir l'evenements :

![image](https://github.com/iir-projets/projet-flutter-g7-sas_sayout/assets/101131509/c60cbb6e-08f4-4329-a0e3-7fd67f2d3362)

Ajouter evenements :

![image](https://github.com/iir-projets/projet-flutter-g7-sas_sayout/assets/101131509/8c597eab-6e64-459c-bbf4-75c76a4d3b1a)

Contrainte de date:

![image](https://github.com/iir-projets/projet-flutter-g7-sas_sayout/assets/101131509/0a996c61-82af-48a7-a5da-f24c0bf0424c)

Information User :

![image](https://github.com/iir-projets/projet-flutter-g7-sas_sayout/assets/101131509/08baf948-009d-407b-86f0-ac2089c6bed7)

## Dépendances

- [Spring Boot](https://spring.io/projects/spring-boot)
- [Spring Security](https://spring.io/projects/spring-security)
- [Flutter](https://flutter.dev/)
- [email.js](https://www.emailjs.com/)

## Contribuer

1. Fork le projet
2. Créez une branche (`git checkout -b feature/nouvelle-fonctionnalite`)
3. Commitez vos modifications (`git commit -am 'Ajout de la nouvelle fonctionnalité'`)
4. Pushez la branche (`git push origin feature/nouvelle-fonctionnalite`)
5. Créez une Pull Request

## Auteurs

- SAS Nabil


