# 🚀 Quick Start Guide - Bedbees Flutter App

## ⚡ Get Running in 5 Minutes

### Step 1: Generate JSON Serialization Code

The app uses `json_serializable` for model serialization. Generate the code:

```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

This will create `*.g.dart` files for all models.

### Step 2: Configure Your Backend URL

Open `lib/config/environment.dart` and update:

```dart
static const String _devBaseUrl = 'YOUR_DEV_API_URL';
static const String _prodBaseUrl = 'YOUR_PRODUCTION_API_URL';
```

### Step 3: Run the App

```bash
flutter run
```

Or for specific device:
```bash
flutter run -d chrome      # Web
flutter run -d <device-id>  # Android/iOS
```

---

## 📱 Testing the App

### Test Traveler Flow
1. Launch app → Tap "Sign Up"
2. Fill traveler form
3. Navigate through home, destinations, hotels, tours

### Test Provider Flow
1. Launch app → Tap "Register as Provider"
2. Fill business details
3. Access provider dashboard
4. View listings and bookings

---

## 🔧 Common Issues & Solutions

### Issue: Build Runner Errors
```bash
# Clean and rebuild
flutter clean
flutter pub get
flutter pub run build_runner build --delete-conflicting-outputs
```

### Issue: Dependencies Conflict
```bash
flutter pub upgrade --major-versions
```

### Issue: API Connection Errors
- Check `environment.dart` URL
- Verify backend is running
- Check network permissions in AndroidManifest.xml / Info.plist

---

## 🗂️ File Structure Quick Reference

```
lib/
├── main.dart                     # App entry point
├── config/
│   ├── environment.dart          # ⚙️ Configure URLs here
│   └── locator.dart             # DI setup
├── routers/app_router.dart      # 🧭 All routes
├── features/
│   ├── auth/                    # 🔐 Login/Signup
│   ├── home/                    # 🏠 Main screen
│   ├── destinations/            # 🗺️ Explore destinations
│   ├── hotels/                  # 🏨 Hotels list
│   ├── tours/                   # 🎫 Tours list
│   ├── shared_trips/            # 👥 Shared trips
│   └── provider/                # 💼 Provider dashboard
└── services/
    ├── api/api_service.dart     # 🌐 HTTP client
    └── auth/auth_service.dart   # 🔑 Auth logic
```

---

## 🎨 Customizing the App

### Change Primary Color
`lib/core/theme/app_theme.dart`:
```dart
static const Color primaryColor = Color(0xFFYOURCOLOR);
```

### Change App Name
`pubspec.yaml`:
```yaml
name: your_app_name
```

### Change Fonts
`lib/core/theme/app_theme.dart` - Replace GoogleFonts calls

---

## 🔗 API Integration Checklist

### Required Endpoints

Your backend should implement:

**Auth**
- `POST /auth/login`
- `POST /auth/register/traveler`
- `POST /auth/register/provider`
- `POST /auth/refresh-token`

**Destinations**
- `GET /destinations`
- `GET /destinations/:id`

**Hotels**
- `GET /hotels`
- `GET /hotels/:id`

**Tours**
- `GET /tours`
- `GET /tours/:id`

**Shared Trips**
- `GET /shared-trips`
- `POST /shared-trips/create`
- `POST /shared-trips/:id/join`

**Provider**
- `GET /provider/dashboard`
- `GET /provider/listings`
- `GET /provider/bookings`

See `lib/services/api/endpoints.dart` for complete list.

---

## 🧪 Testing

### Run All Tests
```bash
flutter test
```

### Run Specific Test
```bash
flutter test test/auth_test.dart
```

### Test Coverage
```bash
flutter test --coverage
genhtml coverage/lcov.info -o coverage/html
open coverage/html/index.html
```

---

## 📦 Build for Production

### Android
```bash
flutter build apk --release
flutter build appbundle --release
```

### iOS
```bash
flutter build ios --release
```

### Web
```bash
flutter build web --release
```

---

## 🌐 Environment Variables

For sensitive data, consider using:
- flutter_dotenv
- Or dart-define at build time:

```bash
flutter run --dart-define=API_URL=https://api.bedbees.com
```

---

## 📊 Enable Analytics

### Firebase
```bash
flutter pub add firebase_core firebase_analytics
```

Then initialize in `main.dart`:
```dart
await Firebase.initializeApp();
```

---

## 🔔 Push Notifications

### Add Firebase Cloud Messaging
```bash
flutter pub add firebase_messaging
```

Configure for Android/iOS following official docs.

---

## 🗺️ Google Maps Integration

### Add Package
```bash
flutter pub add google_maps_flutter
```

### Update API Key
`lib/config/environment.dart`:
```dart
static const String googleMapsApiKey = 'YOUR_KEY_HERE';
```

---

## 💳 Payment Integration

### Stripe
```bash
flutter pub add flutter_stripe
```

### PayPal
```bash
flutter pub add flutter_paypal_checkout
```

---

## 🐛 Debugging Tips

### Enable Verbose Logging
In `lib/services/api/api_service.dart`, the LogInterceptor is already enabled in development.

### Inspect Network Calls
Use **Dio** logging or:
- Charles Proxy
- Proxyman
- Flutter DevTools Network tab

### State Debugging
Add Riverpod logger:
```dart
ProviderScope(
  observers: [ProviderLogger()],
  child: BedbessApp(),
)
```

---

## 📱 Device Permissions

### Android (`android/app/src/main/AndroidManifest.xml`)
```xml
<uses-permission android:name="android.permission.INTERNET"/>
<uses-permission android:name="android.permission.ACCESS_NETWORK_STATE"/>
<uses-permission android:name="android.permission.CAMERA"/>
```

### iOS (`ios/Runner/Info.plist`)
```xml
<key>NSCameraUsageDescription</key>
<string>We need camera access for profile photos</string>
<key>NSPhotoLibraryUsageDescription</key>
<string>We need photo library access</string>
```

---

## 🚢 Deployment

### App Store (iOS)
1. Archive in Xcode
2. Upload to App Store Connect
3. Submit for review

### Play Store (Android)
1. Build app bundle: `flutter build appbundle --release`
2. Upload to Google Play Console
3. Submit for review

### Web Hosting
```bash
flutter build web --release
```
Deploy `build/web/` to:
- Firebase Hosting
- Netlify
- Vercel
- AWS S3 + CloudFront

---

## 🎓 Learn More

- [Flutter Documentation](https://docs.flutter.dev/)
- [Riverpod Docs](https://riverpod.dev/)
- [go_router Guide](https://pub.dev/packages/go_router)
- [Dio Package](https://pub.dev/packages/dio)

---

## 💬 Need Help?

Common issues are documented in the main README.md

---

**Happy Coding! 🎉**

Your Bedbees app is ready to scale to millions of users!
