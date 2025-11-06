# 🌤️ Flutter Weather App – MVVM Architecture  
### Built by **Satya Krishna**

A production-grade **Flutter Weather Application** built using **MVVM Architecture**, integrated with **OpenWeather API**, featuring **real-time weather**, **5-day forecast**, **hourly updates**, **local storage**, and **location-based weather**.

This project is designed as an **internship assignment** but implemented with **industry-level patterns**, showcasing clean architecture, testability, and scalability.

---

## 🚀 Features

| Category | Feature | Status |
|----------|----------|----------|
| Core | Search weather by city | ✅ |
| Core | Current weather conditions (Temp, Humidity, Wind, Feels-like) | ✅ |
| Core | 5-Day Weather Forecast | ✅ |
| Core | Local favorites storage using `shared_preferences` | ✅ |
| Core | Responsive & modern UI | ✅ |
| Bonus | GPS location-based weather | ✅ |
| Bonus | Hourly forecast (next 24h) | ✅ |
| Bonus | Unit conversion (°C/°F & km/h/mph) | ✅ |
| Optional Extensible | Weather-based UI theme & animations | 🔜 (Can be added) |
| Optional Extensible | Firebase sync for favorites | 🔜 (Future upgrade) |

---

## 🧱 **Tech Stack & Tools**

| Layer | Tech |
|--------|--------|
| Framework | Flutter (Dart) |
| Architecture | MVVM + Repository Pattern |
| State Management | Provider |
| Storage | shared_preferences |
| API Client | Dio |
| Location | Geolocator |
| Date Formatting | intl |
| Optional UI Enhancements | Lottie, cached_network_image |

---

## 🧠 **Why MVVM? (Case Study Justification)**

MVVM was chosen to ensure:

### ✅ **Separation of Concerns**
- UI is independent of business logic
- ViewModels expose only required state

### 🧪 **Improved Testability**
- Business logic testable without UI
- Mock Repositories can simulate API responses

### 📦 **Scalability for Future Features**
If later you add:
- Authentication
- Multi-location sync
- Firebase integration  
No rewrite needed — just extend architecture.

---

## 🏛️ **Project Architecture Overview**

lib/
│── core/
│ ├── constants.dart
│ ├── result.dart
│ ├── debouncer.dart
│
│── data/
│ ├── models/
│ ├── api/
│ ├── repositories/
│
│── services/
│ ├── favorites_service.dart
│ ├── settings_service.dart
│
│── viewmodels/
│ ├── home_view_model.dart
│ ├── search_view_model.dart
│ ├── weather_detail_view_model.dart
│ ├── settings_view_model.dart
│
│── ui/
│ ├── screens/
│ ├── widgets/
│
│── app_router.dart
│── main.dart
└── secrets.dart



### 📍 Data Flow (High Level)

**UI → ViewModel → Repository → API/Service → ViewModel → UI**

Each layer communicates only with the immediate next layer (dependency rule).

---

## 📸 Screenshots

> *(Replace these with your actual screenshots once ready)*

| Screen | Placeholder |
|---------|----------------|
| Home Screen | ![Home Screen](aseets/home.jpeg) |
| Search Screen | ![Search Screen](aseets/search.jpeg) |
| Weather Detail Screen | ![Detail Screen](aseets/detail.jpeg) |
| Favorites Screen | ![Favorites](aseets/favorites.jpeg) |


