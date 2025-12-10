
/// API Endpoints
class ApiEndpoints {
  // Base
  static const String baseUrl = '/api';
  
  // Auth
  static const String login = '/auth/login';
  static const String registerTraveler = '/auth/register/traveler';
  static const String registerProvider = '/auth/register/provider';
  static const String forgotPassword = '/auth/forgot-password';
  static const String resetPassword = '/auth/reset-password';
  static const String refreshToken = '/auth/refresh-token';
  static const String logout = '/auth/logout';
  
  // Provider Auth
  static const String providerLogin = '/provider/login';
  static const String providerRegister = '/provider/register';
  
  // User Profile
  static const String profile = '/user/profile';
  static const String updateProfile = '/user/profile/update';
  static const String changePassword = '/user/change-password';
  
  // Destinations
  static const String destinations = '/destinations';
  static String destinationById(String id) => '/destinations/$id';
  static const String popularDestinations = '/destinations/popular';
  static const String searchDestinations = '/destinations/search';
  
  // Hotels
  static const String hotels = '/hotels';
  static String hotelById(String id) => '/hotels/$id';
  static const String searchHotels = '/hotels/search';
  static const String popularHotels = '/hotels/popular';
  static String hotelsByDestination(String destinationId) => '/hotels/destination/$destinationId';
  
  // Tours
  static const String tours = '/tours';
  static String tourById(String id) => '/tours/$id';
  static const String searchTours = '/tours/search';
  static const String popularTours = '/tours/popular';
  static String toursByDestination(String destinationId) => '/tours/destination/$destinationId';
  
  // Cars
  static const String cars = '/cars';
  static String carById(String id) => '/cars/$id';
  static const String searchCars = '/cars/search';
  static String carsByDestination(String destinationId) => '/cars/destination/$destinationId';
  
  // Taxis
  static const String taxis = '/taxis';
  static String taxiById(String id) => '/taxis/$id';
  static const String searchTaxis = '/taxis/search';
  
  // Walking Tours
  static const String walkingTours = '/walking-tours';
  static String walkingTourById(String id) => '/walking-tours/$id';
  
  // Rentals
  static const String rentals = '/rentals';
  static String rentalById(String id) => '/rentals/$id';
  static const String searchRentals = '/rentals/search';
  
  // Shared Trips
  static const String sharedTrips = '/shared-trips';
  static String sharedTripById(String id) => '/shared-trips/$id';
  static const String searchSharedTrips = '/shared-trips/search';
  static const String createSharedTrip = '/shared-trips/create';
  static String joinSharedTrip(String id) => '/shared-trips/$id/join';
  
  // Bookings
  static const String bookings = '/bookings';
  static String bookingById(String id) => '/bookings/$id';
  static const String createBooking = '/bookings/create';
  static String cancelBooking(String id) => '/bookings/$id/cancel';
  
  // Provider Dashboard
  static const String providerDashboard = '/provider/dashboard';
  static const String providerListings = '/provider/listings';
  static const String providerBookings = '/provider/bookings';
  static const String providerPayments = '/provider/payments';
  static const String providerStats = '/provider/stats';
  
  // AI Travel Planner
  static const String aiPlanTrip = '/ai/plan-trip';
  static const String aiRecommendations = '/ai/recommendations';
  
  // Reviews
  static String reviewsByListing(String listingId, String type) => '/$type/$listingId/reviews';
  static const String createReview = '/reviews/create';
  
  // Favorites
  static const String favorites = '/favorites';
  static const String addFavorite = '/favorites/add';
  static String removeFavorite(String id) => '/favorites/$id/remove';
}
