import 'package:flutter/material.dart';
import '../../core/theme/bedbees_colors.dart';

class AITripPlannerPage extends StatefulWidget {
  const AITripPlannerPage({super.key});

  @override
  State<AITripPlannerPage> createState() => _AITripPlannerPageState();
}

class _AITripPlannerPageState extends State<AITripPlannerPage> {
  final TextEditingController _destinationController = TextEditingController();
  DateTime? _startDate;
  DateTime? _endDate;
  String _selectedDuration = '1 Week';
  int _travelersCount = 1;
  double _budgetValue = 2000;

  // Trip Style
  String _tripStyle = 'Moderate';
  String _travelPurpose = 'Vacation';

  // Preferences
  String _destinationType = 'Beach';
  String _accommodationLevel = 'Mid-range';
  String _transportationPref = 'Car Rental';
  final Set<String> _mustHaveActivities = {};

  // Food & Comfort
  final Set<String> _dietaryPrefs = {};
  final Set<String> _comfortPrefs = {};

  // AI Optimization
  bool _includeSharedTrips = false;
  bool _weatherOptimized = true;
  String _itineraryStyle = 'Best Value';

  @override
  void dispose() {
    _destinationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          // Hero Section with Image
          SliverToBoxAdapter(
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.5,
              child: Stack(
                children: [
                  // Hero Background Image
                  Positioned.fill(
                    child: Image.asset(
                      'assets/images/aihero.webp',
                      fit: BoxFit.cover,
                    ),
                  ),

                  // Decorative circles overlay (no gradient, just circles)
                  Positioned(
                    top: -60,
                    right: -60,
                    child: Container(
                      width: 200,
                      height: 200,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white.withOpacity(0.1),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 100,
                    left: -50,
                    child: Container(
                      width: 150,
                      height: 150,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white.withOpacity(0.08),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: -80,
                    left: -40,
                    child: Container(
                      width: 180,
                      height: 180,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white.withOpacity(0.05),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 50,
                    right: -30,
                    child: Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: const Color(0xFFF9D162).withOpacity(0.15),
                      ),
                    ),
                  ),

                  // Top Bar with Back Button
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    child: SafeArea(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 8),
                        child: Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.2),
                                shape: BoxShape.circle,
                              ),
                              child: IconButton(
                                icon: const Icon(Icons.arrow_back,
                                    color: Colors.white, size: 28),
                                onPressed: () => Navigator.pop(context),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  // Destination Input Overlay
                  Positioned(
                    top: MediaQuery.of(context).padding.top + 60,
                    left: 20,
                    right: 20,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.15),
                            blurRadius: 20,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: TextField(
                        controller: _destinationController,
                        decoration: const InputDecoration(
                          hintText: 'Where do you want to go?',
                          hintStyle: TextStyle(
                            color: Color(0xFF777777),
                            fontSize: 16,
                          ),
                          prefixIcon: Icon(Icons.location_on,
                              color: Color(0xFF0EA5E9), size: 24),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 18),
                        ),
                      ),
                    ),
                  ),

                  // Hero Title
                  Positioned(
                    bottom: 40,
                    left: 20,
                    right: 20,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Icon(
                                Icons.auto_awesome,
                                color: Colors.white,
                                size: 28,
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'AI Trip Planner',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 28,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: -0.5,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    'Let AI create your perfect journey',
                                    style: TextStyle(
                                      color: Colors.white.withOpacity(0.9),
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SliverToBoxAdapter(child: SizedBox(height: 32)),

          // Customize Your Trip - Modern Header
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: const Color(0xFF0EA5E9).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(
                          Icons.tune,
                          color: Color(0xFF0EA5E9),
                          size: 24,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Customize Your Trip',
                              style: TextStyle(
                                color: const Color(0xFF1A1A1A),
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                letterSpacing: -0.5,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              'Personalize every detail',
                              style: TextStyle(
                                color: const Color(0xFF777777),
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Container(
                    height: 4,
                    width: 60,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFF0EA5E9), Color(0xFFFF8C32)],
                      ),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SliverToBoxAdapter(child: SizedBox(height: 24)),

          // 🟦 TRIP BASICS
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSectionHeader('Trip Basics', Icons.info_outline,
                      const Color(0xFF0EA5E9)),
                  const SizedBox(height: 16),

                  // Destination (already in hero)

                  // Travel Dates
                  _buildModernSection(
                    'Travel Dates',
                    Icons.event_outlined,
                    Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () async {
                              final picked = await showDatePicker(
                                context: context,
                                initialDate: _startDate ?? DateTime.now(),
                                firstDate: DateTime.now(),
                                lastDate: DateTime.now()
                                    .add(const Duration(days: 365)),
                              );
                              if (picked != null)
                                setState(() => _startDate = picked);
                            },
                            child: Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: const Color(0xFFF5F5F5),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Start Date',
                                      style: TextStyle(
                                          color: Colors.grey[600],
                                          fontSize: 12)),
                                  const SizedBox(height: 4),
                                  Text(
                                    _startDate != null
                                        ? '${_startDate!.toString().split(' ')[0]}'
                                        : 'Select date',
                                    style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: GestureDetector(
                            onTap: () async {
                              final picked = await showDatePicker(
                                context: context,
                                initialDate: _endDate ??
                                    (_startDate ?? DateTime.now())
                                        .add(const Duration(days: 7)),
                                firstDate: _startDate ?? DateTime.now(),
                                lastDate: DateTime.now()
                                    .add(const Duration(days: 365)),
                              );
                              if (picked != null)
                                setState(() => _endDate = picked);
                            },
                            child: Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: const Color(0xFFF5F5F5),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('End Date',
                                      style: TextStyle(
                                          color: Colors.grey[600],
                                          fontSize: 12)),
                                  const SizedBox(height: 4),
                                  Text(
                                    _endDate != null
                                        ? '${_endDate!.toString().split(' ')[0]}'
                                        : 'Select date',
                                    style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Trip Duration
                  _buildModernSection(
                    'Trip Duration',
                    Icons.calendar_today_outlined,
                    Wrap(
                      spacing: 12,
                      runSpacing: 12,
                      children: ['Weekend', '1 Week', '2 Weeks', 'Month+']
                          .map((duration) => _buildChip(
                              duration,
                              _selectedDuration == duration,
                              () =>
                                  setState(() => _selectedDuration = duration)))
                          .toList(),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Travelers
                  _buildModernSection(
                    'Number of Travelers',
                    Icons.group_outlined,
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            if (_travelersCount > 1)
                              setState(() => _travelersCount--);
                          },
                          icon: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: const Color(0xFF0EA5E9).withOpacity(0.1),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(Icons.remove,
                                color: Color(0xFF0EA5E9)),
                          ),
                        ),
                        Expanded(
                          child: Center(
                            child: Text(
                              '$_travelersCount',
                              style: const TextStyle(
                                color: Color(0xFF0EA5E9),
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            if (_travelersCount < 20)
                              setState(() => _travelersCount++);
                          },
                          icon: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: const Color(0xFF0EA5E9).withOpacity(0.1),
                              shape: BoxShape.circle,
                            ),
                            child:
                                const Icon(Icons.add, color: Color(0xFF0EA5E9)),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Budget
                  _buildModernSection(
                    'Budget per Person',
                    Icons.attach_money,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '\$${_budgetValue.toInt()}',
                          style: const TextStyle(
                            color: Color(0xFF0EA5E9),
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Slider(
                          value: _budgetValue,
                          min: 500,
                          max: 10000,
                          divisions: 95,
                          activeColor: const Color(0xFF0EA5E9),
                          onChanged: (value) =>
                              setState(() => _budgetValue = value),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),

                  // 🟧 TRIP STYLE
                  _buildSectionHeader('Trip Style', Icons.style_outlined,
                      const Color(0xFFFF6F4E)),
                  const SizedBox(height: 16),

                  _buildModernSection(
                    'Trip Type',
                    Icons.hiking_outlined,
                    Wrap(
                      spacing: 12,
                      runSpacing: 12,
                      children: ['Relaxed', 'Moderate', 'Adventure']
                          .map((type) => _buildChip(type, _tripStyle == type,
                              () => setState(() => _tripStyle = type)))
                          .toList(),
                    ),
                  ),
                  const SizedBox(height: 16),

                  _buildModernSection(
                    'Travel Purpose',
                    Icons.favorite_outline,
                    Wrap(
                      spacing: 12,
                      runSpacing: 12,
                      children: [
                        'Vacation',
                        'Family Trip',
                        'Adventure',
                        'Shopping',
                        'Romantic',
                        'Culture',
                        'Food & Dining'
                      ]
                          .map((purpose) => _buildChip(
                              purpose,
                              _travelPurpose == purpose,
                              () => setState(() => _travelPurpose = purpose)))
                          .toList(),
                    ),
                  ),
                  const SizedBox(height: 32),

                  // 🟨 PREFERENCES
                  _buildSectionHeader(
                      'Preferences', Icons.tune, const Color(0xFFF9C94C)),
                  const SizedBox(height: 16),

                  _buildModernSection(
                    'Destination Type',
                    Icons.landscape_outlined,
                    Wrap(
                      spacing: 12,
                      runSpacing: 12,
                      children: [
                        'Beach',
                        'City',
                        'Nature',
                        'Mountains',
                        'Desert',
                        'Islands'
                      ]
                          .map((type) => _buildChip(
                              type,
                              _destinationType == type,
                              () => setState(() => _destinationType = type)))
                          .toList(),
                    ),
                  ),
                  const SizedBox(height: 16),

                  _buildModernSection(
                    'Accommodation Level',
                    Icons.hotel_outlined,
                    Wrap(
                      spacing: 12,
                      runSpacing: 12,
                      children: ['Luxury', 'Mid-range', 'Budget']
                          .map((level) => _buildChip(
                              level,
                              _accommodationLevel == level,
                              () =>
                                  setState(() => _accommodationLevel = level)))
                          .toList(),
                    ),
                  ),
                  const SizedBox(height: 16),

                  _buildModernSection(
                    'Transportation Preference',
                    Icons.directions_car_outlined,
                    Wrap(
                      spacing: 12,
                      runSpacing: 12,
                      children: [
                        'Car Rental',
                        'Public Transport',
                        'Taxi/Uber',
                        'Walking'
                      ]
                          .map((trans) => _buildChip(
                              trans,
                              _transportationPref == trans,
                              () =>
                                  setState(() => _transportationPref = trans)))
                          .toList(),
                    ),
                  ),
                  const SizedBox(height: 16),

                  _buildModernSection(
                    'Must-Have Activities',
                    Icons.local_activity_outlined,
                    Wrap(
                      spacing: 12,
                      runSpacing: 12,
                      children: [
                        'Landmarks',
                        'Museums',
                        'Beaches',
                        'Adventure',
                        'Food Tours',
                        'Shopping',
                        'Nightlife'
                      ]
                          .map((activity) => _buildMultiChip(activity,
                                  _mustHaveActivities.contains(activity), () {
                                setState(() {
                                  if (_mustHaveActivities.contains(activity)) {
                                    _mustHaveActivities.remove(activity);
                                  } else {
                                    _mustHaveActivities.add(activity);
                                  }
                                });
                              }))
                          .toList(),
                    ),
                  ),
                  const SizedBox(height: 32),

                  // 🟩 FOOD & COMFORT
                  _buildSectionHeader('Food & Comfort',
                      Icons.restaurant_outlined, const Color(0xFF10B981)),
                  const SizedBox(height: 16),

                  _buildModernSection(
                    'Dietary Preferences',
                    Icons.fastfood_outlined,
                    Wrap(
                      spacing: 12,
                      runSpacing: 12,
                      children: [
                        'Vegetarian',
                        'Halal',
                        'Gluten-free',
                        'No seafood',
                        'Local food'
                      ]
                          .map((diet) => _buildMultiChip(
                                  diet, _dietaryPrefs.contains(diet), () {
                                setState(() {
                                  if (_dietaryPrefs.contains(diet)) {
                                    _dietaryPrefs.remove(diet);
                                  } else {
                                    _dietaryPrefs.add(diet);
                                  }
                                });
                              }))
                          .toList(),
                    ),
                  ),
                  const SizedBox(height: 16),

                  _buildModernSection(
                    'Comfort & Safety',
                    Icons.shield_outlined,
                    Wrap(
                      spacing: 12,
                      runSpacing: 12,
                      children: [
                        'Safe areas',
                        'Avoid crowds',
                        'Family-friendly',
                        'Accessible travel'
                      ]
                          .map((comfort) => _buildMultiChip(
                                  comfort, _comfortPrefs.contains(comfort), () {
                                setState(() {
                                  if (_comfortPrefs.contains(comfort)) {
                                    _comfortPrefs.remove(comfort);
                                  } else {
                                    _comfortPrefs.add(comfort);
                                  }
                                });
                              }))
                          .toList(),
                    ),
                  ),
                  const SizedBox(height: 32),

                  // 🤖 AI OPTIMIZATION
                  _buildSectionHeader('AI Optimization', Icons.auto_awesome,
                      const Color(0xFF8B5CF6)),
                  const SizedBox(height: 16),

                  _buildModernSection(
                    'Include Shared Trips',
                    Icons.people_alt_outlined,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Find group travel options',
                            style: TextStyle(fontSize: 14)),
                        Switch(
                          value: _includeSharedTrips,
                          activeColor: const Color(0xFF0EA5E9),
                          onChanged: (value) =>
                              setState(() => _includeSharedTrips = value),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),

                  _buildModernSection(
                    'Weather-Optimized Schedule',
                    Icons.wb_sunny_outlined,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Plan around best weather',
                            style: TextStyle(fontSize: 14)),
                        Switch(
                          value: _weatherOptimized,
                          activeColor: const Color(0xFF0EA5E9),
                          onChanged: (value) =>
                              setState(() => _weatherOptimized = value),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),

                  _buildModernSection(
                    'Preferred Itinerary Style',
                    Icons.auto_graph,
                    Wrap(
                      spacing: 12,
                      runSpacing: 12,
                      children: ['Cheapest', 'Best Value', 'Luxury']
                          .map((style) => _buildChip(
                              style,
                              _itineraryStyle == style,
                              () => setState(() => _itineraryStyle = style)))
                          .toList(),
                    ),
                  ),
                  const SizedBox(height: 32),

                  // GENERATE BUTTON
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _generateTrip,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFFF6F4E),
                        padding: const EdgeInsets.symmetric(vertical: 18),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.auto_awesome,
                              color: Colors.white, size: 24),
                          SizedBox(width: 12),
                          Text(
                            'Generate My Perfect Trip',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title, IconData icon, Color color) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: color, size: 20),
        ),
        const SizedBox(width: 12),
        Text(
          title,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ],
    );
  }

  Widget _buildMultiChip(String label, bool isSelected, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF0EA5E9) : const Color(0xFFF5F5F5),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? const Color(0xFF0EA5E9) : Colors.transparent,
            width: 2,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: const Color(0xFF0EA5E9).withOpacity(0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ]
              : null,
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : const Color(0xFF1A1A1A),
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
            fontSize: 13,
          ),
        ),
      ),
    );
  }

  Widget _buildModernSection(String title, IconData icon, Widget child) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE5E5E5), width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: const Color(0xFF0EA5E9), size: 20),
              const SizedBox(width: 8),
              Text(
                title,
                style: TextStyle(
                  color: const Color(0xFF1A1A1A),
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          child,
        ],
      ),
    );
  }

  Widget _buildChip(String label, bool isSelected, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF0EA5E9) : const Color(0xFFF5F5F5),
          borderRadius: BorderRadius.circular(25),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: const Color(0xFF0EA5E9).withOpacity(0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ]
              : null,
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : const Color(0xFF1A1A1A),
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
            fontSize: 14,
          ),
        ),
      ),
    );
  }

  void _generateTrip() {
    if (_destinationController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter a destination'),
          backgroundColor: BedbeesColors.coral,
        ),
      );
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Generating trip to ${_destinationController.text}...'),
        backgroundColor: BedbeesColors.successGreen,
      ),
    );
  }
}
