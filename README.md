# Bedbees Flutter App - Production-Ready Foundation

A comprehensive Flutter application for travel booking including hotels, tours, cars, shared trips, and destination exploration.

## Features

### ✅ Dual User System
- **Travelers**: Full account with personalized preferences
- **Providers**: Business accounts with dashboard and listing management

### ✅ Core Features
- 🏨 Hotels booking
- 🎫 Tours & activities
- 🚗 Car rentals
- 🚖 Taxi services
- 🚶 Walking tours
- 🏠 Vacation rentals
- 👥 Shared trips (find travel companions)
- 🗺️ Destination explorer with AI travel planner

### ✅ Technical Stack
- **State Management**: Riverpod
- **Routing**: go_router with guards
- **Networking**: Dio with interceptors
- **Storage**: SharedPreferences + flutter_secure_storage
- **DI**: get_it
- **Architecture**: Clean Architecture with feature modules

## Project Structure

```
lib/
├── config/
│   ├── environment.dart
│   └── locator.dart
├── core/
│   ├── constants/
│   ├── theme/
│   ├── utils/
│   └── widgets/
├── data/
│   └── models/
├── services/
│   ├── api/
│   └── auth/
├── features/
│   ├── auth/
│   ├── home/
│   ├── destinations/
│   ├── hotels/
│   ├── tours/
│   ├── shared_trips/
│   ├── provider/
│   └── splash/
├── routers/
│   └── app_router.dart
└── main.dart
```

## Getting Started

### Prerequisites
- Flutter SDK 3.0+
- Dart 3.0+

### Installation

1. Clone the repository
```bash
git clone <repository-url>
cd bedbees-flutter
```

2. Install dependencies
```bash
flutter pub get
```

3. Run code generation (for JSON serialization)
```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

4. Configure environment
- Update `lib/config/environment.dart` with your API URLs and keys

5. Run the app
```bash
flutter run
```

## Features Detail

### Authentication
- Traveler signup with full profile
- Provider registration with business details
- Secure token-based authentication
- Auto token refresh
- Password recovery

### Provider Dashboard
- Business analytics
- Listing management
- Booking management
- Revenue tracking
- Profile settings

### Destination Explorer
- Browse destinations by category
- Detailed destination information
- Top hotels and tours
- AI-powered trip planning
- Local tips and safety info

### Shared Trips
- Create trip postings
- Find travel companions
- Filter by interests and dates
- Join existing trips

## API Integration

The app is designed to integrate with a NestJS or .NET backend. Update endpoints in:
- `lib/services/api/endpoints.dart`
- `lib/config/environment.dart`

## Architecture

### Clean Architecture Layers
1. **Presentation**: UI components and state management
2. **Domain**: Business logic and entities
3. **Data**: Models, repositories, and data sources

### Key Design Patterns
- Dependency Injection
- Repository Pattern
- Provider/Riverpod for state
- Navigation guards with go_router

## Scalability Features

- Modular feature-based structure
- Lazy loading with get_it
- Optimized network calls with Dio
- Secure token storage
- Clean separation of concerns
- Ready for millions of users

## Next Steps

1. Connect to your backend API
2. Implement actual data fetching
3. Add payment integration
4. Implement real-time chat
5. Add push notifications
6. Integrate maps (Google Maps)
7. Add analytics (Firebase/Mixpanel)
8. Implement offline mode
9. Add unit and integration tests

## Contributing

This is a production-ready foundation. Customize based on your specific requirements.

## License

[Your License Here]
