import 'package:flutter/material.dart';
import '../../core/theme/bedbees_colors.dart';

class SharedToursPage extends StatefulWidget {
  const SharedToursPage({super.key});

  @override
  State<SharedToursPage> createState() => _SharedToursPageState();
}

class _SharedToursPageState extends State<SharedToursPage> {
  String _selectedFilter = 'Upcoming';
  String _searchQuery = '';
  final TextEditingController _searchController = TextEditingController();

  final List<String> _filters = [
    'Upcoming',
    'This Week',
    'This Month',
    'Popular'
  ];

  final List<Map<String, dynamic>> _allSharedTours = [
    {
      'destination': 'Dubai Desert Safari',
      'date': 'Dec 15, 2025',
      'filter': 'This Week',
      'spotsLeft': 3,
      'totalSpots': 12,
      'sharedPrice': '\$85',
      'regularPrice': '\$140',
      'organizer': 'Sarah Ahmed',
      'savings': '39%',
    },
    {
      'destination': 'Abu Dhabi City Tour',
      'date': 'Dec 18, 2025',
      'filter': 'This Week',
      'spotsLeft': 6,
      'totalSpots': 15,
      'sharedPrice': '\$65',
      'regularPrice': '\$110',
      'organizer': 'Mohammed Ali',
      'savings': '41%',
    },
    {
      'destination': 'Mountain Hiking Trek',
      'date': 'Dec 22, 2025',
      'filter': 'This Month',
      'spotsLeft': 2,
      'totalSpots': 8,
      'sharedPrice': '\$95',
      'regularPrice': '\$150',
      'organizer': 'Lisa Parker',
      'savings': '37%',
    },
    {
      'destination': 'Food Walking Tour',
      'date': 'Dec 12, 2025',
      'filter': 'Upcoming',
      'spotsLeft': 8,
      'totalSpots': 20,
      'sharedPrice': '\$45',
      'regularPrice': '\$75',
      'organizer': 'Ahmed Hassan',
      'savings': '40%',
    },
    {
      'destination': 'Museum & Heritage Tour',
      'date': 'Dec 14, 2025',
      'filter': 'This Week',
      'spotsLeft': 4,
      'totalSpots': 10,
      'sharedPrice': '\$55',
      'regularPrice': '\$90',
      'organizer': 'Fatima Ali',
      'savings': '39%',
    },
    {
      'destination': 'Yacht Cruise Experience',
      'date': 'Dec 25, 2025',
      'filter': 'This Month',
      'spotsLeft': 1,
      'totalSpots': 12,
      'sharedPrice': '\$180',
      'regularPrice': '\$300',
      'organizer': 'John Smith',
      'savings': '40%',
    },
    {
      'destination': 'Beach & Water Sports',
      'date': 'Dec 16, 2025',
      'filter': 'This Week',
      'spotsLeft': 7,
      'totalSpots': 16,
      'sharedPrice': '\$120',
      'regularPrice': '\$190',
      'organizer': 'Maria Garcia',
      'savings': '37%',
    },
    {
      'destination': 'Art Gallery Tour',
      'date': 'Dec 20, 2025',
      'filter': 'This Month',
      'spotsLeft': 5,
      'totalSpots': 12,
      'sharedPrice': '\$40',
      'regularPrice': '\$65',
      'organizer': 'Sophie Laurent',
      'savings': '38%',
    },
  ];

  List<Map<String, dynamic>> get _filteredTours {
    return _allSharedTours.where((tour) {
      final matchesSearch = tour['destination']
              .toString()
              .toLowerCase()
              .contains(_searchQuery.toLowerCase()) ||
          tour['organizer']
              .toString()
              .toLowerCase()
              .contains(_searchQuery.toLowerCase());
      final matchesFilter =
          _selectedFilter == 'Popular' || tour['filter'] == _selectedFilter;
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
            backgroundColor: BedbeesColors.primaryBlue,
            flexibleSpace: FlexibleSpaceBar(
              title: const Text(
                'Shared Tours',
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
                          Color(0xFF0EA5E9),
                          Color(0xFF0284C7),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    left: -60,
                    top: -60,
                    child: Container(
                      width: 250,
                      height: 250,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white.withOpacity(0.1),
                      ),
                    ),
                  ),
                  Positioned(
                    right: -40,
                    bottom: -40,
                    child: Container(
                      width: 180,
                      height: 180,
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

          // Info Banner
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      BedbeesColors.primaryBlue.withOpacity(0.1),
                      BedbeesColors.primaryBlue.withOpacity(0.05),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: BedbeesColors.primaryBlue.withOpacity(0.3),
                    width: 1,
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: BedbeesColors.primaryBlue,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(
                        Icons.people_alt_rounded,
                        color: Colors.white,
                        size: 24,
                      ),
                    ),
                    const SizedBox(width: 16),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Join & Save!',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF1A1A1A),
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'Share tours with other travelers and save up to 40%',
                            style: TextStyle(
                              fontSize: 12,
                              color: BedbeesColors.greyText,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Search Bar
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
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
                    hintText: 'Search shared tours...',
                    hintStyle: TextStyle(color: Colors.grey[400]),
                    prefixIcon: const Icon(Icons.search,
                        color: BedbeesColors.primaryBlue),
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
                      selectedColor: BedbeesColors.primaryBlue,
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

          // Available Tours Header
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'Available Shared Tours (${_filteredTours.length})',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1A1A1A),
                ),
              ),
            ),
          ),

          const SliverToBoxAdapter(child: SizedBox(height: 16)),

          // Shared Tours List or Empty State
          if (_filteredTours.isEmpty)
            SliverFillRemaining(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.people_outline,
                      size: 80,
                      color: Colors.grey[400],
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'No shared tours found',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey[700],
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Try adjusting your search or filters',
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
                    final tour = _filteredTours[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: _buildSharedTourCard(
                        tour['destination'].toString(),
                        tour['date'].toString(),
                        tour['sharedPrice'].toString(),
                        tour['regularPrice'].toString(),
                        tour['spotsLeft'].toString(),
                        tour['totalSpots'].toString(),
                        tour['organizer'].toString(),
                        tour['savings'].toString(),
                      ),
                    );
                  },
                  childCount: _filteredTours.length,
                ),
              ),
            ),

          const SliverToBoxAdapter(child: SizedBox(height: 40)),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        backgroundColor: BedbeesColors.primaryBlue,
        icon: const Icon(Icons.add, color: Colors.white),
        label: const Text(
          'Create Tour',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildSharedTourCard(
    String destination,
    String date,
    String sharedPrice,
    String regularPrice,
    String spotsLeft,
    String totalSpots,
    String organizer,
    String savings,
  ) {
    final int spots = int.parse(spotsLeft);
    final bool isAlmostFull = spots <= 3;

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
                Container(
                  height: 160,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        BedbeesColors.primaryBlue.withOpacity(0.2),
                        BedbeesColors.primaryBlue.withOpacity(0.1),
                      ],
                    ),
                  ),
                  child: const Icon(Icons.people_alt,
                      size: 60, color: BedbeesColors.primaryBlue),
                ),
                if (isAlmostFull)
                  Positioned(
                    top: 12,
                    left: 12,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 6),
                      decoration: BoxDecoration(
                        color: BedbeesColors.coral,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Row(
                        children: [
                          Icon(Icons.local_fire_department,
                              color: Colors.white, size: 14),
                          SizedBox(width: 4),
                          Text(
                            'Almost Full',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
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
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        destination,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1A1A1A),
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 6),
                      decoration: BoxDecoration(
                        color: BedbeesColors.primaryBlue.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.people,
                            size: 14,
                            color: BedbeesColors.primaryBlue,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '$spotsLeft/$totalSpots',
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: BedbeesColors.primaryBlue,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.person_outline,
                        size: 14, color: BedbeesColors.greyText),
                    const SizedBox(width: 4),
                    Text(
                      'by $organizer',
                      style: const TextStyle(
                        fontSize: 13,
                        color: BedbeesColors.greyText,
                      ),
                    ),
                    const SizedBox(width: 16),
                    const Icon(Icons.calendar_today,
                        size: 14, color: BedbeesColors.greyText),
                    const SizedBox(width: 4),
                    Text(
                      date,
                      style: const TextStyle(
                        fontSize: 13,
                        color: BedbeesColors.greyText,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Shared Price',
                          style: TextStyle(
                            fontSize: 11,
                            color: BedbeesColors.greyText,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            Text(
                              sharedPrice,
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: BedbeesColors.primaryBlue,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              regularPrice,
                              style: const TextStyle(
                                fontSize: 14,
                                decoration: TextDecoration.lineThrough,
                                color: BedbeesColors.greyText,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const Spacer(),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: BedbeesColors.primaryBlue,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text(
                        'Join Tour',
                        style: TextStyle(
                          color: Colors.white,
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
    );
  }
}
