# 🚌 Bus Booking App [ FLUTTER + SPRINGBOOT ]
This app is designed to offer a seamless experience for passengers to book seats and for admins to manage buses and schedules. All data is securely stored in **Supabase (PostgreSQL)** 

## 🌟 Features

### 👤 User Side

- Browse available buses and schedules
- Select your seat with an interactive **Seat Plan UI**
- Book using your phone number — **no login required**
- See instant booking confirmation

<img src = "https://github.com/user-attachments/assets/37eb99ec-9f79-47d4-b6c0-15022deb80e9" height ="600" width ="300"/>
<img src = "https://github.com/user-attachments/assets/eb29eb2c-44b3-445d-bf08-35bd32f10bd3" height ="600" width ="300"/>
<img src = "https://github.com/user-attachments/assets/ece3af88-1289-43cc-88ba-48dfdf24b9de" height ="600" width ="300"/>
<img src = "https://github.com/user-attachments/assets/08012f53-6564-40ec-b4c8-03d659f8a022" height ="600" width ="300"/>
<img src = "https://github.com/user-attachments/assets/0bdc9f23-6ef5-4976-9237-a77906bbde60" height ="600" width ="300"/>
<img src = "https://github.com/user-attachments/assets/d5cd94f2-0ab6-499b-801c-879f7d1b9241" height ="600" width ="300"/>


### 🛠️ Admin Side

- Secure **Json web token (JWT) -based login**
- Add buses and define schedules
- View all reservations

<img src = "https://github.com/user-attachments/assets/31e32703-2023-44c1-ac62-df26c59ec1c1" height = "600" width = "300"/>
<img src = "https://github.com/user-attachments/assets/5966dd92-dbd3-4b7d-8782-fe28fc19a2e1" height = "600" width = "300"/>


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

--
<img src= "https://github.com/user-attachments/assets/a2f6cb64-a677-4696-b56e-0a502c0ca0e3" height = "1500" width = "600"/>
---


## Flutter Structure :
```
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
```
## Springboot Stucture :
```
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
```
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




