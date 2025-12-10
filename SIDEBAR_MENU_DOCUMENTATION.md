# Bedbees Sidebar Menu - Complete Documentation

## Overview
The Bedbees Travel Super-App features a comprehensive sidebar menu (drawer) that supports **two distinct modes**:
- **Traveler Mode** 🏖️ - For users browsing and booking travel services
- **Provider Mode** 🏢 - For businesses managing their listings and bookings

## Features

### ⭐ Profile Section (Top)
Located at the top of the drawer with a beautiful teal gradient background:
- **User Avatar** - Circular profile picture (or default icon)
- **Full Name** - User's display name
- **Email** - User's email address
- **"View Profile" Button** - White outlined button to access profile settings

### 🎯 Mode Toggle
Intelligent toggle between Traveler and Provider modes:
- **Traveler Button** - Teal background when active, with flight icon
- **Provider Button** - Orange background when active, with business icon
- Seamlessly switches menu items based on selected mode

### 📱 Bottom Actions
Quick access to essential functions:
- **Settings** ⚙️ - App configuration
- **Help & Support** 🆘 - Customer assistance
- **Logout** 🚪 - Secure logout with confirmation dialog

---

## Traveler Mode Navigation

### 🏠 Home
**Dashboard & Search**
- Quick access to main dashboard
- Search functionality
- Popular destinations overview
- Recommended trips
- Trending hotels & tours
- Continue trip planning

### 🌍 Destinations
**Explore Travel Guides**
Expandable menu with sub-items:
- **Popular Cities** - Top tourist destinations worldwide
- **All Countries** - Complete country directory
- **Beaches** 🏖️ - Coastal and island destinations
- **Mountains** ⛰️ - Highland and alpine regions
- **Culture** 🏛️ - Historical and cultural sites
- **Adventure** 🎿 - Extreme sports and activities

**Destination Details Include:**
- Highlights and must-see attractions
- Interactive maps
- Weather forecasts
- Local tips and guides
- Safety information
- Available hotels, tours & activities

### 🏨 Hotels
**Search & Book Hotels**
Expandable menu with:
- **Search Hotels** - Main search interface with filters
- **Map View** - Geographic hotel browsing
- **Top Rated** - Highest-rated properties

**Features:**
- Advanced filters (price, reviews, stars, distance)
- Detailed hotel pages with:
  - Photo galleries
  - Room options and pricing
  - Amenities list
  - Guest reviews
  - Location and directions

### 🗺️ Tours & Activities
**Walking Tours, Attractions & Tickets**
Comprehensive tour booking:
- **All Tours** - Browse all available tours
- **Walking Tours** - Guided city walks
- **City Tours** - Bus and guided city experiences
- **Attractions** - Theme parks, zoos, museums
- **Tickets & Museums** - Skip-the-line tickets

**Tour Details Include:**
- Complete itinerary
- Duration and schedule
- Meeting point information
- Guide details
- Customer reviews
- Pricing and group options

### 🚗 Cars & Transport
**Rentals & Transfers**
Complete transportation solutions:
- **Car Rentals** - Self-drive vehicle rentals
- **Airport Transfers** - Private airport pickups
- **Daily Drivers** - Chauffeur services

**Details Include:**
- Vehicle specifications
- Pricing and conditions
- Insurance options
- Pickup/dropoff locations
- Driver ratings (for transfers)

### 👥 Shared Trips
**Share & Join Trips**
Social travel features:
- **Find Shared Trips** - Browse available group trips
- **Create Shared Trip** - Start a new shared journey
- **Join Requests** - Manage incoming requests

**Shared Trip Features:**
- View trip members
- Complete itinerary
- Automatic cost splitting
- Group chat
- Shared expense tracking

### 🤖 AI Trip Planner
**Smart Travel Assistant** (Highlighted in orange)
AI-powered trip planning:
- **"Plan My Trip" Wizard** - Step-by-step trip creation
- **Auto Itinerary Generation** - Smart schedule creation
- **Day-by-Day Schedule** - Detailed daily plans
- **Budget Planner** - Cost estimation and tracking
- **Weather-Aware Suggestions** - Climate-optimized activities
- **Smart Rearranging** - Automatic optimization
- **Export to PDF** - Downloadable itineraries

### ⭐ Wishlists
**Saved Items**
Organize favorites:
- **Saved Hotels** - Favorite accommodations
- **Saved Tours** - Bookmarked activities
- **Saved Destinations** - Dream locations
- **Saved Cars** - Preferred vehicles
- **All Lists** - Custom wishlist management

**Features:**
- Multiple custom lists
- Share lists with friends
- Price tracking
- Availability alerts

### 📅 My Bookings
**All Reservations**
Complete booking management:
- **All Bookings** - Unified booking view
- **Hotels** - Hotel reservations
- **Tours** - Activity bookings
- **Cars** - Vehicle rentals
- **Shared Trips** - Group travel bookings

**Each Booking Includes:**
- QR code for check-in
- Payment receipt
- Cancellation options
- Modification requests
- Support chat
- Status tracking

### 💳 Payments
**Cards & Wallet**
Financial management:
- **Saved Cards** - Stored payment methods
- **Payment History** - Transaction records
- **Refund Status** - Track refunds
- **Wallet** - Digital wallet (future-ready)

**Features:**
- Secure card storage
- Transaction details
- Refund tracking
- Invoice downloads

---

## Provider Mode Navigation

### 📊 Dashboard
**Overview & Analytics**
Business control center:
- Revenue overview
- Booking statistics
- Performance metrics
- Quick actions

### 🏢 My Listings
**Manage Properties**
Complete inventory management:
- **All Listings** - View all properties
- **Hotels** - Hotel listings
- **Tours** - Tour offerings
- **Cars** - Vehicle fleet
- **Add New** - Create new listing

**Listing Management:**
- Edit details and pricing
- Upload photos
- Set availability
- Manage amenities
- Update policies

### 📋 Bookings & Reservations
**Manage Reservations**
Booking workflow:
- **All Bookings** - Complete booking list
- **Pending** - Awaiting confirmation
- **Confirmed** - Accepted reservations
- **Completed** - Past bookings
- **Cancelled** - Rejected/cancelled

**Actions:**
- Accept/reject bookings
- Modify reservations
- Contact customers
- Generate reports

### 💰 Earnings
**Revenue & Payouts**
Financial dashboard:
- **Overview** - Earnings summary
- **Transactions** - Detailed transaction log
- **Payout History** - Payment records
- **Tax Documents** - Tax forms and reports

**Features:**
- Revenue charts
- Payout schedules
- Tax reporting
- Bank account management

### 📊 Analytics
**Performance Insights**
Business intelligence:
- Booking trends
- Revenue analysis
- Customer demographics
- Performance comparisons
- Seasonal patterns

### ⭐ Reviews
**Customer Feedback**
Reputation management:
- View all reviews
- Respond to feedback
- Rating analytics
- Review trends

### 💬 Messages
**Customer Inquiries**
Communication hub:
- Inbox with unread badge
- Customer conversations
- Quick replies
- Automated responses

### 📅 Availability Calendar
**Manage Availability**
Schedule control:
- Block dates
- Set pricing
- Manage capacity
- Seasonal rates

### ⚙️ Settings
**Business Preferences**
Configuration options:
- **Business Profile** - Company information
- **Policies** - Cancellation & terms
- **Payment Methods** - Bank details
- **Notifications** - Alert preferences

---

## Technical Implementation

### File Location
```
lib/features/navigation/app_drawer.dart
```

### Key Components

#### 1. Profile Section
```dart
_buildProfileSection(BuildContext context)
```
- Displays user avatar, name, email
- Teal gradient background
- "View Profile" button

#### 2. Menu Items
```dart
_buildMenuItem(...)           // Standard menu item
_buildExpandableMenuItem(...) // Expandable with children
_buildSubMenuItem(...)        // Child menu item
```

#### 3. Mode Toggle
```dart
_buildModeToggle()
```
- Switches between Traveler/Provider
- Visual feedback with colors
- Icon changes

#### 4. Bottom Actions
```dart
_buildBottomActions(BuildContext context)
```
- Settings, Help, Logout
- Logout confirmation dialog

### Color Scheme
- **Teal**: `#00C4B3` - Primary/Traveler mode
- **Orange**: `#FF8C32` - Provider mode/Accents
- **Grey**: `#777777` - Secondary text
- **White**: `#FFFFFF` - Backgrounds
- **Red**: `#FF3B30` - Logout/Danger actions

### Navigation
Uses `GoRouter` for navigation:
```dart
context.push('/route');
```

### State Management
- `SharedPreferences` for user data persistence
- Local state for mode toggle
- Loads user data on initialization

### Usage in Home Page
```dart
Scaffold(
  drawer: const AppDrawer(),
  // ... other properties
)
```

Add menu button to AppBar:
```dart
leading: Builder(
  builder: (context) => IconButton(
    icon: const Icon(Icons.menu),
    onPressed: () => Scaffold.of(context).openDrawer(),
  ),
)
```

---

## Route Structure

### Traveler Routes
- `/home` - Dashboard
- `/destinations/*` - Destination browsing
- `/hotels/*` - Hotel search and details
- `/tours/*` - Tour listings
- `/cars/*` - Car rentals
- `/shared-trips/*` - Shared trip features
- `/ai-planner` - AI trip planner
- `/wishlists/*` - Saved items
- `/bookings/*` - User bookings
- `/payments/*` - Payment management

### Provider Routes
- `/provider/dashboard` - Business overview
- `/provider/listings/*` - Property management
- `/provider/bookings/*` - Reservation management
- `/provider/earnings/*` - Financial data
- `/provider/analytics` - Performance metrics
- `/provider/reviews` - Customer feedback
- `/provider/messages` - Communication
- `/provider/calendar` - Availability
- `/provider/settings/*` - Configuration

### Common Routes
- `/profile` - User profile
- `/settings` - App settings
- `/support` - Help center

---

## Customization

### Adding New Menu Items
```dart
_buildMenuItem(
  context,
  icon: Icons.your_icon,
  title: 'Your Title',
  subtitle: 'Description',
  route: '/your-route',
)
```

### Adding Expandable Section
```dart
_buildExpandableMenuItem(
  context,
  icon: Icons.your_icon,
  title: 'Section Title',
  subtitle: 'Description',
  children: [
    _buildSubMenuItem(context, 'Item 1', '/route1'),
    _buildSubMenuItem(context, 'Item 2', '/route2'),
  ],
)
```

### Changing Colors
Edit the color constants in the drawer:
- Profile section background gradient
- Icon background colors
- Mode toggle active states

---

## Best Practices

1. **Keep menu organized** - Group related items
2. **Use clear labels** - Descriptive titles and subtitles
3. **Limit nesting** - Max 2 levels deep
4. **Show badges** - For notifications/counts
5. **Consistent icons** - Material icons throughout
6. **Handle navigation** - Close drawer before navigating
7. **Responsive design** - Test on different screen sizes

---

## Future Enhancements

- [ ] Dark mode support
- [ ] Notification badges with real counts
- [ ] User avatar upload
- [ ] Recent searches section
- [ ] Quick actions toolbar
- [ ] Gesture-based shortcuts
- [ ] Multi-language support
- [ ] Accessibility improvements
- [ ] Analytics tracking
- [ ] A/B testing variants

---

## Testing Checklist

- [ ] Profile section loads user data
- [ ] Mode toggle switches menus
- [ ] All menu items navigate correctly
- [ ] Expandable sections open/close
- [ ] Logout confirmation works
- [ ] Drawer closes on navigation
- [ ] Icons render correctly
- [ ] Text doesn't overflow
- [ ] Scrolling works smoothly
- [ ] Badge numbers display
- [ ] Back button closes drawer

---

## Support

For issues or questions about the sidebar menu:
1. Check route definitions in `app_router.dart`
2. Verify user data in SharedPreferences
3. Test navigation with debug logging
4. Review color theming in `app_theme.dart`

---

**Version**: 1.0.0  
**Last Updated**: December 9, 2025  
**Component**: Bedbees Travel Super-App Sidebar Menu
