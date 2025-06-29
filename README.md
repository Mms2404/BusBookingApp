# 🚌 Bus Booking App [ FLUTTER + SPRINGBOOT ]
This app is designed to offer a seamless experience for passengers to book seats and for admins to manage buses and schedules. All data is securely stored in **Supabase (PostgreSQL)** 

## 🌟 Features

### 👤 User Side
- Browse available buses and schedules
- Select your seat with an interactive **Seat Plan UI**
- Book using your phone number — **no login required**
- See instant booking confirmation

### 🛠️ Admin Panel
- Secure **Json web token (JWT) -based login**
- Add buses and define schedules
- View all reservations

---

## 🧠 Tech Stack

| Layer       | Tech                |
|-------------|-------------------- |
| Frontend    | Flutter             |
| State Mgmt  | Provider            |
| Backend     | Spring Boot         |
| Database    | Supabase(Postgres)  |
| Auth        | JWT (Admin Only)    |
| API Comm    | REST (via `http`)   |

---

## 🔗 API Endpoints (Spring Boot)

| Method | Endpoint                  | Description              |
|--------|---------------------------|--------------------------|
| POST   | `/api/book`               | Book a seat              |
| GET    | `/api/reservations`       | Get all reservations     |
| POST   | `/api/admin/addBus`       | Add a new bus            |
| POST   | `/api/admin/addSchedule`  | Add a schedule           |
| POST   | `/login`                  | Admin login (returns JWT)|

> 🛡️ Admin routes require a valid JWT token in the `Authorization` header.

---

## Flutter Structure :

lib/
├── core/
│ ├── buttons.dart
│ ├── constants.dart
│ ├── colors.dart
│ ├── loaders.dart
│ └── helper_functions.dart
├── data/
│ ├── api_service.dart # Real HTTP logic
│ └── token_storage.dart # Base URLs and endpoints
├── datasource/
│ ├── data_source.dart 
│ └── remote_data_source.dart 
├── domain/
│ └── models/ # Bus, Schedule, Reservation models and other models requires as per the backend entities
├── presentation/
│ ├── pages/ # Screens: Booking, AdminPanel, Login
│ ├── widgets/ # SeatPlanView and UI components
│ └── providers/ # Provider state management
└── main.dart # App entry point

## Springboot Stucture :

src/
└── main/
├── java/com/example/booking/
│ ├── controller/ # BookingController, AdminController ,AuthController 
│ ├── model/ # JPA entities: Bus, Schedule, Reservation , Admin
│ ├── repository/ # Spring Data JPA interfaces
│ ├── service/ # Core business logic
│ └── BookingApplication.java
└── resources/
└── application.properties # Supabase DB config

## 🚀 Getting Started !!

1. Clone the repo:
```bash
git clone https://github.com/yourusername/bus-booking-app.git
cd bus-booking-app
flutter pub get
```
 - My database is live , try it and then create one of your own and when you do that , Configure Supabase credentials in src/main/resources/application.properties .
 - Go to demo directory and run :
    ``` bash
      mvn spring-boot:run
    ```
 - Now run flutter

### Future Enhancements - ( will get it soon doneee )
 - ✉️ **Twilio integration** – send SMS/WhatsApp confirmations after booking
 - 💳 **Stripe integration** – enable secure online payments for ticket booking




