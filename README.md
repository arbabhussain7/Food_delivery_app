# 🍔 Foodies - Food Delivery App

<img width="1376" height="768" alt="WhatsApp Image 2026-05-12 at 11 03 42 AM" src="https://github.com/user-attachments/assets/58f40271-a127-42f6-8726-c81ec4d1b5f6" />
<br><br>

<p>
<img src="https://github.com/user-attachments/assets/b60732c7-c155-4120-8c3a-3c1f385096c5" alt="Image 1" style="margin-right: 10px; margin-bottom: 10px;" width="20%">
<img  src="https://github.com/user-attachments/assets/fc7c2701-8974-457a-8a6c-6a209022791d" alt="Image 1" style="margin-right: 10px; margin-bottom: 10px;" width="20%">
<img src="https://github.com/user-attachments/assets/550fb3b8-0b13-4a8e-ad8f-4df8eec6aece" alt="Image 1" style="margin-right: 10px; margin-bottom: 10px;" width="20%">
  <img  src="https://github.com/user-attachments/assets/f5410c04-47ae-4ac1-9579-7381196ad0ea"  alt="Image 1" style="margin-right: 10px; margin-bottom: 10px;" width="20%">
</p>


<p>
<img src="https://github.com/user-attachments/assets/9630cc9b-7566-4a6b-a589-6d5e732787f3" alt="Image 1" style="margin-right: 10px; margin-bottom: 10px;" width="20%">
<img  src="https://github.com/user-attachments/assets/8103a52c-87d3-4d4d-9621-cffe05993ec1" alt="Image 1" style="margin-right: 10px; margin-bottom: 10px;" width="20%">
<img src="https://github.com/user-attachments/assets/0ad04a84-6005-45a4-95e6-79e33c1b0a20" alt="Image 1" style="margin-right: 10px; margin-bottom: 10px;" width="20%">
  <img  src="https://github.com/user-attachments/assets/d4b99317-def9-46d6-95ef-9d5b8016b399"  alt="Image 1" style="margin-right: 10px; margin-bottom: 10px;" width="20%">
</p>


<p>
<img src="https://github.com/user-attachments/assets/946983cf-27d9-4b09-9742-5341e3a79c6c" alt="Image 1" style="margin-right: 10px; margin-bottom: 10px;" width="20%">
<img  src="https://github.com/user-attachments/assets/a568d541-71ca-4703-b49a-f30268b9b16a" alt="Image 1" style="margin-right: 10px; margin-bottom: 10px;" width="20%">
<img src="https://github.com/user-attachments/assets/6f2e9ed7-f7ab-4bc5-a011-bd15ca5192b2" alt="Image 1" style="margin-right: 10px; margin-bottom: 10px;" width="20%">
  <img  src="https://github.com/user-attachments/assets/c379e08f-73b3-4b7c-b2e0-505297774992"  alt="Image 1" style="margin-right: 10px; margin-bottom: 10px;" width="20%">
</p>

<p>
<img src="https://github.com/user-attachments/assets/71d47468-ee6e-46e7-9216-54017ae9efc6" alt="Image 1" style="margin-right: 10px; margin-bottom: 10px;" width="20%">
<img  src="https://github.com/user-attachments/assets/b478e1e4-48d8-45cd-ad50-6b537a928957" alt="Image 1" style="margin-right: 10px; margin-bottom: 10px;" width="20%">
<img src="https://github.com/user-attachments/assets/5f5e9f38-ece9-40d7-8104-e06334c7afe9" alt="Image 1" style="margin-right: 10px; margin-bottom: 10px;" width="20%">
  <img  src="https://github.com/user-attachments/assets/2d51a7cc-7287-4953-bd3a-31d6472300ba"  alt="Image 1" style="margin-right: 10px; margin-bottom: 10px;" width="20%">
</p>


A scalable and high-performance food delivery application built with Flutter using **Clean Architecture** and **BLoC State Management**. The application allows users to browse food items, add products to the cart, place orders, make secure payments through Stripe, and track their orders in real-time.

---

# 📱 Overview

Foodies is a modern food ordering platform designed with maintainability, scalability, and performance in mind. The app follows Clean Architecture principles to ensure a clear separation of concerns and easier future enhancements.

Users can:

* Browse food items fetched from Firebase.
* View food details.
* Add items to the cart.
* Place food orders.
* Make secure online payments via Stripe.
* Track order status in real-time.
* Receive push notifications about order updates.
* Use their current location for delivery services.

---

# ✨ Features

## 🔐 Authentication

* User Registration
* User Login
* Secure Authentication with Firebase

## 🍕 Food Management

* Fetch food products from Firebase Firestore
* Food Categories
* Product Details Screen
* Search and Filter Functionality
* Real-time Data Updates

## 🛒 Cart System

* Add to Cart
* Remove from Cart
* Update Item Quantity
* Dynamic Price Calculation

## 💳 Payment Integration

* Stripe Payment Gateway Integration
* Secure Online Transactions
* Payment Verification

## 📦 Order Management

* Place Orders
* Order History
* Real-Time Order Status Tracking

Order Flow:

```text
Order Placed
      ↓
Prepared
      ↓
Out For Delivery
      ↓
Delivered
```

## 📍 Location Services

* Current Location Detection
* Address Conversion using Geocoding
* Delivery Address Selection
* Location Permission Handling

## 🔔 Push Notifications

* Firebase Cloud Messaging (FCM)
* Order Status Notifications
* Promotional Notifications

## 🚀 Performance Optimization

* Clean Architecture
* BLoC State Management
* Dependency Injection using GetIt
* Repository Pattern
* Route Observer for Navigation Tracking
* Optimized API Calls
* Scalable Project Structure

---

# 🏗️ Architecture

The application follows **Clean Architecture** principles.

```text
lib/
│
├── core/
│   ├── constants/
│   │   ├── app_colors.dart         # Hex colors (e.g., primaryColor)
│   │   └── firebase_constants.dart # Firestore collection names ("users", "products")
│   ├── errors/
│   │   ├── failures.dart           # App failures (e.g., ServerFailure, AuthFailure)
│   │   └── exceptions.dart         # Firebase exceptions handle karne ke liye
│   ├── network/
│   │   └── connection_checker.dart # Internet check karne ke liye (InternetConnectionChecker)
│   ├── theme/
│   │   └── app_theme.dart          # Light and Dark theme configuration
│   └── usecases/
│       └── usecase.dart            # Standard UseCase template/interface
│
├── features/
│   ├── auth/
│   │   ├── data/
│   │   │   ├── datasources/
│   │   │   │   ├── auth_remote_data_source.dart     # Firebase Auth code calls wrapper
│   │   │   │   └── auth_remote_data_source_impl.dart# Actual implementation with FirebaseAuth instance
│   │   │   ├── models/
│   │   │   │   └── user_model.dart                 # fromJson/toJson mappings, extends UserEntity
│   │   │   └── repositories/
│   │   │       └── auth_repository_impl.dart       # Network check + try/catch over data source
│   │   │
│   │   ├── domain/
│   │   │   ├── entities/
│   │   │   │   └── user_entity.dart                # Pure Dart class with core fields (uid, email, name)
│   │   │   ├── repositories/
│   │   │   │   └── auth_repository.dart            # Abstract class defining login/signup methods
│   │   │   └── usecases/
│   │   │       ├── user_login.dart                 # Calls repository.login()
│   │   │       └── user_sign_up.dart               # Calls repository.signUp()
│   │   │
│   │   └── presentation/
│   │       ├── bloc/
│   │       │   ├── auth_bloc.dart                  # Handles business logic for presentation
│   │       │   ├── auth_event.dart                 # AuthLoginRequested, AuthSignUpRequested events
│   │       │   └── auth_state.dart                 # AuthInitial, AuthLoading, AuthSuccess, AuthFailure states
│   │       ├── pages/
│   │       │   ├── login_page.dart                 # Login Screen UI
│   │       └── widgets/
│   │           ├── auth_gradient_button.dart       # Custom Button for auth screens
│   │           └── auth_field.dart                 # Custom Text Field
│   │
│   ├── home/
│   │   ├── data/
│   │   ├── domain/
│   │   └── presentation/
│   │
│   └── profile/
│       ├── data/
│       ├── domain/
│       └── presentation/
│
├── init_dependencies.dart          # Service Locator initialization via GetIt package
└── main.dart                       # Initializes Firebase and calls initDependencies()
```

### Layer Structure

#### Presentation Layer

* Flutter UI
* BLoC State Management
* Screens
* Widgets

#### Domain Layer

* Entities
* Use Cases
* Repository Contracts

#### Data Layer

* Firebase Services
* Repository Implementations
* Models
* Data Sources

---

# 🛠️ Tech Stack

### Frontend

* Flutter
* Dart

### State Management

* Flutter BLoC

### Backend & Database

* Firebase Authentication
* Cloud Firestore
* Firebase Cloud Messaging

### Payment Gateway

* Stripe

### Location Services

* Geolocator
* Geocoding

### Dependency Injection

* GetIt

### Architecture

* Clean Architecture
* Repository Pattern


---

# 🔄 State Management

The application uses **Flutter BLoC** for predictable and scalable state management.

Benefits:

* Separation of Business Logic
* Testable Code
* Maintainable Structure
* Scalable Feature Development
* Improved Performance

---

# 🔔 Notification Flow

```text
Admin Updates Order Status
            ↓
Firebase Firestore Updated
            ↓
FCM Push Notification Triggered
            ↓
User Receives Notification
            ↓
Order Tracking Screen Updated
```

---

# 📍 Location Flow

```text
User Opens App
        ↓
Request Location Permission
        ↓
Get Current Coordinates
        ↓
Convert Coordinates to Address
        ↓
Display Delivery Location
```

---

# 🚀 Scalability Features

* Feature-Based Folder Structure
* Clean Architecture
* BLoC State Management
* Dependency Injection with GetIt
* Reusable Widgets
* Repository Pattern
* Firebase Integration
* Modular Feature Development
* Easy Testing & Maintenance

---

# ⚙️ Installation

```bash
# Clone Repository
git clone https://github.com/your-username/foodies-app.git

# Navigate to Project
cd foodies-app

# Install Dependencies
flutter pub get

# Run Project
flutter run
```

```text
android/app/
```

7. Configure Firebase in Flutter:

```bash
flutterfire configure
```


# 👨‍💻 Developer

**Arbab Hussain**

Flutter Developer | Firebase | Clean Architecture | BLoC | Stripe Integration 


---
## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Contact

For questions or feedback, feel free to reach out at [arbabhussain414@gmail.com](arbabhussain414@gmail.com).
