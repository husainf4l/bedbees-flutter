import 'package:flutter/material.dart';
import '../../core/theme/bedbees_colors.dart';

class TourGuidesPage extends StatefulWidget {
  const TourGuidesPage({super.key});

  @override
  State<TourGuidesPage> createState() => _TourGuidesPageState();
}

class _TourGuidesPageState extends State<TourGuidesPage> {
  String _selectedLanguage = 'All';
  String _searchQuery = '';
  final TextEditingController _searchController = TextEditingController();

  final List<String> _languages = [
    'All',
    'English',
    'Spanish',
    'French',
    'Arabic'
  ];

  final List<Map<String, dynamic>> _allGuides = [
    {
      'name': 'Ahmed Hassan',
      'specialty': 'History Expert',
      'price': '\$150',
      'rating': '4.9',
      'tours': '250+ tours',
      'languages': ['English', 'Arabic', 'French'],
      'location': 'Dubai',
    },
    {
      'name': 'Maria Rodriguez',
      'specialty': 'Adventure Specialist',
      'price': '\$175',
      'rating': '4.8',
      'tours': '180+ tours',
      'languages': ['English', 'Spanish'],
      'location': 'Barcelona',
    },
    {
      'name': 'John Smith',
      'specialty': 'Cultural Tours',
      'price': '\$200',
      'rating': '4.9',
      'tours': '320+ tours',
      'languages': ['English', 'French'],
      'location': 'Paris',
    },
    {
      'name': 'Fatima Al-Said',
      'specialty': 'Food & Culinary',
      'price': '\$125',
      'rating': '4.7',
      'tours': '150+ tours',
      'languages': ['English', 'Arabic'],
      'location': 'Istanbul',
    },
    {
      'name': 'Carlos Martinez',
      'specialty': 'Nature Explorer',
      'price': '\$190',
      'rating': '4.8',
      'tours': '210+ tours',
      'languages': ['English', 'Spanish', 'French'],
      'location': 'Costa Rica',
    },
    {
      'name': 'Sophie Laurent',
      'specialty': 'Art & Museums',
      'price': '\$165',
      'rating': '4.9',
      'tours': '280+ tours',
      'languages': ['English', 'French'],
      'location': 'Rome',
    },
    {
      'name': 'Hassan Al-Rashid',
      'specialty': 'Desert Adventures',
      'price': '\$185',
      'rating': '4.8',
      'tours': '190+ tours',
      'languages': ['English', 'Arabic'],
      'location': 'Abu Dhabi',
    },
    {
      'name': 'Elena Popova',
      'specialty': 'Architecture Tours',
      'price': '\$155',
      'rating': '4.7',
      'tours': '170+ tours',
      'languages': ['English', 'French', 'Spanish'],
      'location': 'Prague',
    },
  ];

  List<Map<String, dynamic>> get _filteredGuides {
    return _allGuides.where((guide) {
      final matchesSearch = guide['name']
              .toString()
              .toLowerCase()
              .contains(_searchQuery.toLowerCase()) ||
          guide['specialty']
              .toString()
              .toLowerCase()
              .contains(_searchQuery.toLowerCase()) ||
          guide['location']
              .toString()
              .toLowerCase()
              .contains(_searchQuery.toLowerCase());
      final matchesLanguage = _selectedLanguage == 'All' ||
          (guide['languages'] as List).contains(_selectedLanguage);
      return matchesSearch && matchesLanguage;
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
            backgroundColor: const Color(0xFF8B5CF6),
            flexibleSpace: FlexibleSpaceBar(
              title: const Text(
                'Tour Guides',
                style: TextStyle(
                  color: Colors.white,
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
                          Color(0xFF8B5CF6),
                          Color(0xFF7C3AED),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    left: -70,
                    bottom: -70,
                    child: Container(
                      width: 250,
                      height: 250,
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
                    hintText: 'Search tour guides...',
                    hintStyle: TextStyle(color: Colors.grey[400]),
                    prefixIcon:
                        const Icon(Icons.search, color: Color(0xFF8B5CF6)),
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
                        horizontal: 20, vertical: 16),
                  ),
                ),
              ),
            ),
          ),

          // Language Filters
          SliverToBoxAdapter(
            child: SizedBox(
              height: 50,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                itemCount: _languages.length,
                itemBuilder: (context, index) {
                  final language = _languages[index];
                  final isSelected = _selectedLanguage == language;
                  return Padding(
                    padding: const EdgeInsets.only(right: 12),
                    child: ChoiceChip(
                      label: Text(language),
                      selected: isSelected,
                      onSelected: (selected) {
                        setState(() => _selectedLanguage = language);
                      },
                      backgroundColor: Colors.white,
                      selectedColor: const Color(0xFF8B5CF6),
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

          const SliverToBoxAdapter(child: SizedBox(height: 20)),

          // Top Rated Section
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  const Icon(Icons.star, color: Color(0xFFF9C94C), size: 20),
                  const SizedBox(width: 8),
                  Text(
                    'Available Guides (${_filteredGuides.length})',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1A1A1A),
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SliverToBoxAdapter(child: SizedBox(height: 16)),

          // Tour Guides List or Empty State
          if (_filteredGuides.isEmpty)
            SliverFillRemaining(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.person_search,
                      size: 80,
                      color: Colors.grey[400],
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'No guides found',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey[700],
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Try adjusting your filters',
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
                    final guide = _filteredGuides[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: _buildGuideCard(
                        guide['name'],
                        guide['specialty'],
                        guide['price'],
                        guide['rating'],
                        guide['tours'],
                        guide['languages'],
                        guide['location'],
                      ),
                    );
                  },
                  childCount: _filteredGuides.length,
                ),
              ),
            ),

          const SliverToBoxAdapter(child: SizedBox(height: 20)),
        ],
      ),
    );
  }

  Widget _buildGuideCard(
    String name,
    String specialty,
    String price,
    String rating,
    String tours,
    List<dynamic> languages,
    String location,
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
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            // Profile Image
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF8B5CF6).withOpacity(0.2),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  color: const Color(0xFF8B5CF6).withOpacity(0.1),
                  child: const Icon(Icons.person,
                      size: 40, color: Color(0xFF8B5CF6)),
                ),
              ),
            ),
            const SizedBox(width: 16),
            // Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          name,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1A1A1A),
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF9C94C).withOpacity(0.2),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.star,
                                size: 14, color: Color(0xFFF9C94C)),
                            const SizedBox(width: 4),
                            Text(
                              rating,
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF1A1A1A),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(
                    specialty,
                    style: const TextStyle(
                      fontSize: 13,
                      color: Color(0xFF8B5CF6),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.tour,
                          size: 14, color: BedbeesColors.greyText),
                      const SizedBox(width: 4),
                      Text(
                        tours,
                        style: const TextStyle(
                          fontSize: 12,
                          color: BedbeesColors.greyText,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 6,
                    children: languages.map((lang) {
                      return Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: const Color(0xFF8B5CF6).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          lang,
                          style: const TextStyle(
                            fontSize: 10,
                            color: Color(0xFF8B5CF6),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '\$$price/day',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF8B5CF6),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF8B5CF6),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text(
                          'Book',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
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
    );
  }
}
