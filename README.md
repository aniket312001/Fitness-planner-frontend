# 🏋️ Fitness Planner App (Flutter Frontend)

A scalable **Flutter mobile application** built using **Clean Architecture + Feature-first design**, supporting coaches and clients for fitness plan management.

---

## 🚀 Backend API

- 🔗 Base URL: https://fitness-planner-backend-vtk7.onrender.com/
- 📘 Swagger Docs: https://fitness-planner-backend-vtk7.onrender.com/api-docs

---

## 📱 Features

### 🔐 Auth Module
- Login
- Register
- JWT authentication

### 🏋️ Workout Plan Module (Coach)
- Create workout plans
- Assign plans to clients
- View plan details

### 🏃 Exercise Module
- Manage exercises
- Select exercises while creating plans

### 👤 Users Module (Coach)
- View list of clients
- Assign workout plans

### 🏠 Home Module
- Role-based dashboard (Coach / Client)

---

## 🏗️ Architecture

This project follows **Clean Architecture + Feature-based modular structure**

```
counter_app/
│
├── lib/
│   ├── core/
│   │   ├── constants/
│   │   │     app_constants.dart
│   │   ├── di/
│   │   │     injector.dart
│   │   ├── error/
│   │   │     exceptions.dart
│   │   ├── network/
│   │   │     dio_client.dart
│   │   ├── storage/
│   │   │     token_storage.dart
│   │   └── utils/
│   │         logger.dart
│
│   ├── features/
│   │   ├── auth/
│   │   │   ├── data/
│   │   │   ├── domain/
│   │   │   └── presentation/
│   │
│   │   ├── exercise/
│   │   ├── home/
│   │   ├── users/
│   │   └── workout_plan/
│
│   ├── app.dart
│   └── main.dart
│
├── test/
└── pubspec.yaml
```

---

## 🧠 Architecture Style

- Feature-first modular structure
- Clean Architecture (Data → Domain → Presentation)
- Bloc state management
- Dependency Injection (GetIt)
- Repository pattern

---

## ⚙️ Tech Stack

- Flutter
- Dart
- Bloc (State Management)
- Dio (Networking)
- GetIt (DI)
- REST API Backend (Node.js + PostgreSQL)

---

## 📂 Features Breakdown

### 🧑‍🏫 Coach Flow
- Create workout plans
- Assign plans to multiple clients
- Manage exercises
- View assigned users

### 🧑‍💼 Client Flow
- View assigned workout plans
- Track assigned exercises
- Mark completion

---

## 🚀 Getting Started

```bash id="flt2"
git clone https://github.com/your-username/fitness-planner-flutter.git
cd fitness-planner-flutter
flutter pub get
flutter run
```

---

## 🔐 Environment Setup

Create `.env` or config inside:

```dart id="flt3"
BASE_URL = https://fitness-planner-backend-vtk7.onrender.com/
```

---

## 📦 Project Highlights

- Clean Architecture implementation
- Scalable feature-based structure
- Role-based app design (Coach / Client)
- Production-ready backend integration
- Secure authentication system

---

## 👨‍💻 Author

Aniket Chavan  
Flutter Developer | Backend Enthusiast
