import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../config/locator.dart';
import '../features/auth/bedbees_login_page.dart';
import '../features/auth/bedbees_signup_page.dart';
import '../features/auth/modern_signin/modern_signin_page.dart';
import '../features/auth/provider_signup/provider_signup_page.dart';
import '../features/auth/traveler_signup/traveler_signup_page.dart';
import '../features/destinations/destinations_list_page.dart';
import '../features/destinations/destination_details_page.dart';
import '../features/home/home_page.dart';
import '../features/home/bedbees_home_page.dart';
import '../features/auth/new_bedbees_login_page.dart';
import '../features/auth/new_bedbees_signup_page.dart';
import '../features/ai_planner/ai_trip_planner_page.dart';
import '../features/hotels/hotels_list_page.dart';
import '../features/onboarding/modern_welcome_page.dart';
import '../features/onboarding/onboarding_travel_page.dart';
import '../features/onboarding/onboarding_traveler_page.dart';
import '../features/onboarding/onboarding_traveler_page.dart';
import '../features/onboarding/welcome_page.dart';
import '../features/provider/provider_dashboard_page.dart';
import '../features/shared_trips/shared_trips_page.dart';
import '../features/showcase/modern_showcase_page.dart';
import '../features/splash/splash_page.dart';
import '../features/tours/tours_list_page.dart';
import '../services/auth/auth_service.dart';

/// App Router Configuration
final appRouter = GoRouter(
  initialLocation: '/',
  redirect: (context, state) async {
    final authService = getIt<AuthService>();
    final isAuthenticated = await authService.isAuthenticated();
    final userType = await authService.getUserType();

    final isGoingToAuth = state.matchedLocation.startsWith('/auth') ||
        state.matchedLocation.startsWith('/provider/login') ||
        state.matchedLocation.startsWith('/provider/register') ||
        state.matchedLocation.startsWith('/bedbees/login') ||
        state.matchedLocation.startsWith('/bedbees/signup') ||
        state.matchedLocation.startsWith('/onboarding');

    // If not authenticated and not going to auth pages
    if (!isAuthenticated && !isGoingToAuth && state.matchedLocation != '/') {
      return '/auth/login';
    }

    // If authenticated and going to auth pages
    if (isAuthenticated && isGoingToAuth) {
      if (userType == 'provider') {
        return '/provider/dashboard';
      }
      return '/home';
    }

    return null;
  },
  routes: [
    // Splash
    GoRoute(
      path: '/',
      builder: (context, state) => const SplashPage(),
    ),

    // Welcome/Onboarding
    GoRoute(
      path: '/welcome',
      builder: (context, state) => const WelcomePage(),
    ),

    // Bedbees Onboarding
    GoRoute(
      path: '/onboarding/travel',
      builder: (context, state) => const OnboardingTravelPage(),
    ),
    GoRoute(
      path: '/onboarding/traveler',
      builder: (context, state) => const OnboardingTravelerPage(),
    ),

    // Bedbees Login & Signup
    GoRoute(
      path: '/bedbees/login',
      builder: (context, state) => const BedbeesLoginPage(),
    ),
    GoRoute(
      path: '/bedbees/signup',
      builder: (context, state) {
        final isProvider = state.uri.queryParameters['provider'] == 'true';
        return BedbeesSignupPage(isProvider: isProvider);
      },
    ),

    // Modern UI Showcase
    GoRoute(
      path: '/modern-showcase',
      builder: (context, state) => const ModernShowcasePage(),
    ),
    GoRoute(
      path: '/modern-welcome',
      builder: (context, state) => const ModernWelcomePage(),
    ),
    GoRoute(
      path: '/modern-signin',
      builder: (context, state) => const ModernSigninPage(),
    ),

    // Auth Routes
    GoRoute(
      path: '/auth/login',
      builder: (context, state) => const BedbeesLoginPage(),
    ),
    GoRoute(
      path: '/auth/traveler/signup',
      builder: (context, state) => const TravelerSignupPage(),
    ),
    GoRoute(
      path: '/auth/provider/signup',
      builder: (context, state) => const ProviderSignupPage(),
    ),

    // Provider Routes
    GoRoute(
      path: '/provider/login',
      builder: (context, state) => const BedbeesLoginPage(isProvider: true),
    ),
    GoRoute(
      path: '/provider/register',
      builder: (context, state) => const ProviderSignupPage(),
    ),
    GoRoute(
      path: '/provider/dashboard',
      builder: (context, state) => const ProviderDashboardPage(),
    ),

    // Main App Routes
    GoRoute(
      path: '/home',
      builder: (context, state) => const HomePage(),
    ),
    
    // New Bedbees Design System Routes
    GoRoute(
      path: '/bedbees-home',
      builder: (context, state) => const BedbeesHomePage(),
    ),
    GoRoute(
      path: '/bedbees-login-new',
      builder: (context, state) => const NewBedbeesLoginPage(),
    ),
    GoRoute(
      path: '/bedbees-signup-new',
      builder: (context, state) => const NewBedbeesSignupPage(),
    ),
    GoRoute(
      path: '/ai-trip-planner',
      builder: (context, state) => const AITripPlannerPage(),
    ),

    // Destinations
    GoRoute(
      path: '/destinations',
      builder: (context, state) => const DestinationsListPage(),
    ),
    GoRoute(
      path: '/destinations/:id',
      builder: (context, state) {
        final id = state.pathParameters['id']!;
        return DestinationDetailsPage(destinationId: id);
      },
    ),

    // Hotels
    GoRoute(
      path: '/hotels',
      builder: (context, state) => const HotelsListPage(),
    ),

    // Tours
    GoRoute(
      path: '/tours',
      builder: (context, state) => const ToursListPage(),
    ),

    // Shared Trips
    GoRoute(
      path: '/shared-trips',
      builder: (context, state) => const SharedTripsPage(),
    ),
  ],
  errorBuilder: (context, state) => Scaffold(
    body: Center(
      child: Text('Page not found: ${state.matchedLocation}'),
    ),
  ),
);
