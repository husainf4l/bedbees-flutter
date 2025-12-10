import 'package:flutter/material.dart';
import '../../core/theme/bedbees_colors.dart';

class ApartmentsPage extends StatefulWidget {
  const ApartmentsPage({super.key});

  @override
  State<ApartmentsPage> createState() => _ApartmentsPageState();
}

class _ApartmentsPageState extends State<ApartmentsPage> {
  String _selectedFilter = 'All';
  String _searchQuery = '';
  final TextEditingController _searchController = TextEditingController();
  final List<String> _filters = [
    'All',
    'Studio',
    '1 Bedroom',
    '2 Bedroom',
    'Penthouse'
  ];

  final List<Map<String, String>> _allApartments = [
    {
      'name': 'Modern Studio Loft',
      'location': 'City Center',
      'price': '80',
      'bedrooms': '0',
      'bathrooms': '1',
      'type': 'Studio'
    },
    {
      'name': 'Cozy 1BR Apartment',
      'location': 'Downtown',
      'price': '100',
      'bedrooms': '1',
      'bathrooms': '1',
      'type': '1 Bedroom'
    },
    {
      'name': 'Spacious 2BR Suite',
      'location': 'Uptown',
      'price': '150',
      'bedrooms': '2',
      'bathrooms': '2',
      'type': '2 Bedroom'
    },
    {
      'name': 'Luxury Penthouse',
      'location': 'Skyline View',
      'price': '350',
      'bedrooms': '3',
      'bathrooms': '3',
      'type': 'Penthouse'
    },
    {
      'name': 'Downtown Studio',
      'location': 'Business District',
      'price': '75',
      'bedrooms': '0',
      'bathrooms': '1',
      'type': 'Studio'
    },
    {
      'name': 'Family 2BR Home',
      'location': 'Suburban Area',
      'price': '140',
      'bedrooms': '2',
      'bathrooms': '2',
      'type': '2 Bedroom'
    },
    {
      'name': 'Urban 1BR Flat',
      'location': 'Old Town',
      'price': '95',
      'bedrooms': '1',
      'bathrooms': '1',
      'type': '1 Bedroom'
    },
    {
      'name': 'Premium Penthouse Suite',
      'location': 'Marina Bay',
      'price': '400',
      'bedrooms': '4',
      'bathrooms': '3',
      'type': 'Penthouse'
    },
  ];

  List<Map<String, String>> get _filteredApartments {
    return _allApartments.where((apt) {
      final matchesSearch = apt['name']!
              .toLowerCase()
              .contains(_searchQuery.toLowerCase()) ||
          apt['location']!.toLowerCase().contains(_searchQuery.toLowerCase());
      final matchesFilter =
          _selectedFilter == 'All' || apt['type'] == _selectedFilter;
      return matchesSearch && matchesFilter;
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
            backgroundColor: BedbeesColors.coral,
            flexibleSpace: FlexibleSpaceBar(
              title: const Text(
                'Apartments',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          BedbeesColors.coral,
                          BedbeesColors.coral.withOpacity(0.8),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    right: -50,
                    bottom: -50,
                    child: Container(
                      width: 200,
                      height: 200,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white.withOpacity(0.1),
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
              padding: const EdgeInsets.all(20),
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
                    hintText: 'Search apartments...',
                    prefixIcon:
                        const Icon(Icons.search, color: BedbeesColors.coral),
                    suffixIcon: _searchQuery.isNotEmpty
                        ? IconButton(
                            icon: const Icon(Icons.clear,
                                color: BedbeesColors.coral),
                            onPressed: () {
                              setState(() {
                                _searchController.clear();
                                _searchQuery = '';
                              });
                            },
                          )
                        : IconButton(
                            icon: const Icon(Icons.tune,
                                color: BedbeesColors.coral),
                            onPressed: () {},
                          ),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 16),
                  ),
                ),
              ),
            ),
          ),

          // Filter Chips
          SliverToBoxAdapter(
            child: SizedBox(
              height: 50,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                itemCount: _filters.length,
                itemBuilder: (context, index) {
                  final filter = _filters[index];
                  final isSelected = _selectedFilter == filter;
                  return Padding(
                    padding: const EdgeInsets.only(right: 12),
                    child: ChoiceChip(
                      label: Text(filter),
                      selected: isSelected,
                      onSelected: (selected) {
                        setState(() => _selectedFilter = filter);
                      },
                      backgroundColor: Colors.white,
                      selectedColor: BedbeesColors.coral,
                      labelStyle: TextStyle(
                        color:
                            isSelected ? Colors.white : BedbeesColors.greyText,
                        fontWeight:
                            isSelected ? FontWeight.bold : FontWeight.normal,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),

          // Apartments List
          _filteredApartments.isEmpty
              ? SliverFillRemaining(
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
                          'No apartments found',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              : SliverPadding(
                  padding: const EdgeInsets.all(20),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        final apt = _filteredApartments[index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 16),
                          child: _buildApartmentCard(
                            apt['name']!,
                            apt['location']!,
                            '\$${apt['price']}',
                            apt['bedrooms']!,
                            apt['bathrooms']!,
                            'https://images.unsplash.com/photo-1522708323590-d24dbb6b0267',
                          ),
                        );
                      },
                      childCount: _filteredApartments.length,
                    ),
                  ),
                ),
        ],
      ),
    );
  }

  Widget _buildApartmentCard(
    String name,
    String location,
    String price,
    String bedrooms,
    String bathrooms,
    String imageUrl,
  ) {
    return Container(
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
          // Image
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
            child: Stack(
              children: [
                Image.network(
                  imageUrl,
                  height: 180,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    height: 180,
                    color: Colors.grey[200],
                    child: const Icon(Icons.apartment,
                        size: 60, color: Colors.grey),
                  ),
                ),
                Positioned(
                  top: 12,
                  right: 12,
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.favorite_border,
                      color: BedbeesColors.coral,
                      size: 20,
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Details
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1A1A1A),
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.location_on,
                        size: 16, color: BedbeesColors.greyText),
                    const SizedBox(width: 4),
                    Text(
                      location,
                      style: const TextStyle(
                        fontSize: 14,
                        color: BedbeesColors.greyText,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    _buildAmenity(Icons.bed, '$bedrooms Beds'),
                    const SizedBox(width: 16),
                    _buildAmenity(Icons.bathtub, '$bathrooms Baths'),
                    const Spacer(),
                    Text(
                      '$price/night',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: BedbeesColors.coral,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAmenity(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 18, color: BedbeesColors.greyText),
        const SizedBox(width: 6),
        Text(
          text,
          style: const TextStyle(
            fontSize: 13,
            color: BedbeesColors.greyText,
          ),
        ),
      ],
    );
  }
}
