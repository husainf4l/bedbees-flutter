import 'package:flutter/material.dart';
import '../../core/theme/bedbees_colors.dart';

class TaxiServicesPage extends StatefulWidget {
  const TaxiServicesPage({super.key});

  @override
  State<TaxiServicesPage> createState() => _TaxiServicesPageState();
}

class _TaxiServicesPageState extends State<TaxiServicesPage> {
  String _selectedService = 'Standard';
  String _searchQuery = '';
  final TextEditingController _searchController = TextEditingController();

  final List<Map<String, dynamic>> _services = [
    {
      'name': 'Standard',
      'icon': Icons.local_taxi,
      'price': '\$10',
      'color': Color(0xFF0EA5E9)
    },
    {
      'name': 'Premium',
      'icon': Icons.directions_car,
      'price': '\$20',
      'color': Color(0xFF8B5CF6)
    },
    {
      'name': 'SUV',
      'icon': Icons.airport_shuttle,
      'price': '\$30',
      'color': Color(0xFF10B981)
    },
    {
      'name': 'Luxury',
      'icon': Icons.emoji_transportation,
      'price': '\$50',
      'color': Color(0xFFF9C94C)
    },
  ];

  final List<Map<String, String>> _allRides = [
    {
      'destination': 'Dubai Mall',
      'pickup': 'Business Bay',
      'service': 'Standard',
      'price': '\$12',
      'distance': '5.2 km',
      'time': '15 min'
    },
    {
      'destination': 'Dubai Marina',
      'pickup': 'Downtown Dubai',
      'service': 'Premium',
      'price': '\$25',
      'distance': '12.5 km',
      'time': '22 min'
    },
    {
      'destination': 'Burj Al Arab',
      'pickup': 'Palm Jumeirah',
      'service': 'Luxury',
      'price': '\$55',
      'distance': '8.3 km',
      'time': '18 min'
    },
    {
      'destination': 'Airport Terminal 3',
      'pickup': 'Deira',
      'service': 'SUV',
      'price': '\$35',
      'distance': '18.7 km',
      'time': '28 min'
    },
    {
      'destination': 'JBR Beach',
      'pickup': 'Dubai Marina',
      'service': 'Standard',
      'price': '\$8',
      'distance': '3.1 km',
      'time': '10 min'
    },
    {
      'destination': 'Global Village',
      'pickup': 'Silicon Oasis',
      'service': 'Premium',
      'price': '\$28',
      'distance': '15.4 km',
      'time': '25 min'
    },
    {
      'destination': 'Dubai Festival City',
      'pickup': 'Mirdif',
      'service': 'Standard',
      'price': '\$15',
      'distance': '7.8 km',
      'time': '16 min'
    },
    {
      'destination': 'City Walk',
      'pickup': 'Al Quoz',
      'service': 'Premium',
      'price': '\$18',
      'distance': '6.5 km',
      'time': '14 min'
    },
  ];

  List<Map<String, String>> get _filteredRides {
    return _allRides.where((ride) {
      final matchesSearch = ride['destination']!
              .toLowerCase()
              .contains(_searchQuery.toLowerCase()) ||
          ride['pickup']!.toLowerCase().contains(_searchQuery.toLowerCase());
      final matchesService =
          _selectedService == 'Standard' || ride['service'] == _selectedService;
      return matchesSearch && matchesService;
    }).toList();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BedbeesColors.screenBackground,
      body: CustomScrollView(
        slivers: [
          // App Bar
          SliverAppBar(
            expandedHeight: 200,
            pinned: true,
            backgroundColor: const Color(0xFFF9C94C),
            flexibleSpace: FlexibleSpaceBar(
              title: const Text(
                'Taxi Services',
                style: TextStyle(
                  color: Color(0xFF1A1A1A),
                  fontWeight: FontWeight.bold,
                ),
              ),
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Color(0xFFF9C94C),
                          Color(0xFFF59E0B),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    right: -60,
                    top: 60,
                    child: Container(
                      width: 200,
                      height: 200,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white.withOpacity(0.2),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Search Bar
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: TextField(
                  controller: _searchController,
                  onChanged: (value) {
                    setState(() {
                      _searchQuery = value;
                    });
                  },
                  decoration: InputDecoration(
                    hintText: 'Search destinations...',
                    hintStyle: TextStyle(color: Colors.grey[400]),
                    prefixIcon:
                        const Icon(Icons.search, color: Color(0xFFF9C94C)),
                    suffixIcon: _searchQuery.isNotEmpty
                        ? IconButton(
                            icon: const Icon(Icons.clear, color: Colors.grey),
                            onPressed: () {
                              setState(() {
                                _searchController.clear();
                                _searchQuery = '';
                              });
                            },
                          )
                        : null,
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 16,
                    ),
                  ),
                ),
              ),
            ),
          ),

          // Ride Booking Card
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.08),
                      blurRadius: 20,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Book a Ride',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1A1A1A),
                      ),
                    ),
                    const SizedBox(height: 20),
                    _buildLocationField('Pick-up Location', Icons.my_location),
                    const SizedBox(height: 16),
                    _buildLocationField('Drop-off Location', Icons.location_on),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                          child: _buildTimeField('Date', Icons.calendar_today),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _buildTimeField('Time', Icons.access_time),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFF9C94C),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text(
                          'Find Taxi',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1A1A1A),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Service Types
          const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'Choose Service Type',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1A1A1A),
                ),
              ),
            ),
          ),

          const SliverToBoxAdapter(child: SizedBox(height: 16)),

          // Service Cards
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 1.2,
              ),
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final service = _services[index];
                  final isSelected = _selectedService == service['name'];
                  return GestureDetector(
                    onTap: () {
                      setState(() => _selectedService = service['name']);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: isSelected
                              ? service['color']
                              : Colors.transparent,
                          width: 2,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: service['color'].withOpacity(0.1),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              service['icon'],
                              size: 32,
                              color: service['color'],
                            ),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            service['name'],
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF1A1A1A),
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '${service['price']}/km',
                            style: TextStyle(
                              fontSize: 14,
                              color: service['color'],
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
                childCount: _services.length,
              ),
            ),
          ),

          const SliverToBoxAdapter(child: SizedBox(height: 24)),

          // Available Rides
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'Available Rides (${_filteredRides.length})',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1A1A1A),
                ),
              ),
            ),
          ),

          const SliverToBoxAdapter(child: SizedBox(height: 16)),

          // Rides List or Empty State
          if (_filteredRides.isEmpty)
            SliverFillRemaining(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.search_off,
                      size: 80,
                      color: Colors.grey[400],
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'No rides found',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey[700],
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Try adjusting your search',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[500],
                      ),
                    ),
                  ],
                ),
              ),
            )
          else
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final ride = _filteredRides[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: _buildRideCard(ride),
                    );
                  },
                  childCount: _filteredRides.length,
                ),
              ),
            ),

          const SliverToBoxAdapter(child: SizedBox(height: 80)),
        ],
      ),
    );
  }

  Widget _buildRideCard(Map<String, String> ride) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.my_location,
                          size: 16,
                          color: Color(0xFF0EA5E9),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            ride['pickup']!,
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Icon(
                          Icons.location_on,
                          size: 16,
                          color: Color(0xFFF9C94C),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            ride['destination']!,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF1A1A1A),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    ride['price']!,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFF9C94C),
                    ),
                  ),
                  Text(
                    ride['service']!,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              _buildRideInfo(Icons.route, ride['distance']!),
              const SizedBox(width: 16),
              _buildRideInfo(Icons.access_time, ride['time']!),
              const Spacer(),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFF9C94C),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 8,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'Book',
                  style: TextStyle(
                    color: Color(0xFF1A1A1A),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRideInfo(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 16, color: Colors.grey),
        const SizedBox(width: 4),
        Text(
          text,
          style: const TextStyle(
            fontSize: 12,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }

  Widget _buildLocationField(String hint, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: BedbeesColors.screenBackground,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(icon, color: const Color(0xFFF9C94C)),
          const SizedBox(width: 12),
          Text(
            hint,
            style: const TextStyle(
              fontSize: 14,
              color: BedbeesColors.greyText,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimeField(String hint, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: BedbeesColors.screenBackground,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: const Color(0xFFF9C94C), size: 18),
          const SizedBox(width: 8),
          Text(
            hint,
            style: const TextStyle(
              fontSize: 13,
              color: BedbeesColors.greyText,
            ),
          ),
        ],
      ),
    );
  }
}
