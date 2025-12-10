import 'package:flutter/material.dart';
import '../../core/theme/bedbees_colors.dart';
import '../../core/theme/bedbees_text_styles.dart';
import '../../core/widgets/bedbees_components.dart';

class ExplorePage extends StatefulWidget {
  const ExplorePage({super.key});

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> with SingleTickerProviderStateMixin {
  String _selectedCategory = 'All';
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BedbeesColors.screenBackground,
      body: SafeArea(
        child: Column(
          children: [
            // Header with gradient
            Container(
              decoration: BoxDecoration(
                gradient: BedbeesColors.blueGradient,
                boxShadow: BedbeesColors.softShadow,
              ),
              child: Column(
                children: [
                  // App Bar
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Explore World',
                          style: BedbeesTextStyles.h1.copyWith(
                            color: BedbeesColors.white,
                          ),
                        ),
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Icon(
                                Icons.filter_list_rounded,
                                color: BedbeesColors.white,
                                size: 20,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Icon(
                                Icons.notifications_outlined,
                                color: BedbeesColors.white,
                                size: 20,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  // Search Bar
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                      decoration: BoxDecoration(
                        color: BedbeesColors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: BedbeesColors.mediumShadow,
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.search,
                            color: BedbeesColors.primaryBlue,
                            size: 24,
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              'Search destinations, hotels...',
                              style: BedbeesTextStyles.bodyMedium.copyWith(
                                color: BedbeesColors.greyText,
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: BedbeesColors.coral,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Icon(
                              Icons.mic_rounded,
                              color: BedbeesColors.white,
                              size: 18,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Tabs
            Container(
              color: BedbeesColors.white,
              child: TabBar(
                controller: _tabController,
                labelColor: BedbeesColors.primaryBlue,
                unselectedLabelColor: BedbeesColors.greyText,
                indicatorColor: BedbeesColors.primaryBlue,
                indicatorWeight: 3,
                labelStyle: BedbeesTextStyles.label.copyWith(fontWeight: FontWeight.w600),
                unselectedLabelStyle: BedbeesTextStyles.label,
                tabs: const [
                  Tab(text: 'Trending'),
                  Tab(text: 'Popular'),
                  Tab(text: 'Nearby'),
                  Tab(text: 'Budget'),
                ],
              ),
            ),

            // Tab Content
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  _buildExploreContent('Trending'),
                  _buildExploreContent('Popular'),
                  _buildExploreContent('Nearby'),
                  _buildExploreContent('Budget'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildExploreContent(String type) {
    return CustomScrollView(
      slivers: [
        const SliverToBoxAdapter(child: SizedBox(height: 20)),

        // Categories
        SliverToBoxAdapter(
          child: SizedBox(
            height: 48,
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              scrollDirection: Axis.horizontal,
              children: [
                _buildCategoryChip('All'),
                const SizedBox(width: 10),
                _buildCategoryChip('Beach'),
                const SizedBox(width: 10),
                _buildCategoryChip('Mountain'),
                const SizedBox(width: 10),
                _buildCategoryChip('City'),
                const SizedBox(width: 10),
                _buildCategoryChip('Adventure'),
                const SizedBox(width: 10),
                _buildCategoryChip('Cultural'),
              ],
            ),
          ),
        ),

        const SliverToBoxAdapter(child: SizedBox(height: 20)),

        // Featured Destination
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '$type Destinations',
                      style: BedbeesTextStyles.h2,
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        'See All',
                        style: BedbeesTextStyles.link,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                _buildFeaturedCard(),
              ],
            ),
          ),
        ),

        const SliverToBoxAdapter(child: SizedBox(height: 24)),

        // Destinations Grid
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          sliver: SliverGrid(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              childAspectRatio: 0.75,
            ),
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return _buildDestinationCard(
                  'Destination ${index + 1}',
                  'Country',
                  4.5 + (index % 5) * 0.1,
                  '\$${299 + index * 100}',
                  index == 0 ? 'Hot Deal' : null,
                );
              },
              childCount: 12,
            ),
          ),
        ),

        const SliverToBoxAdapter(child: SizedBox(height: 100)),
      ],
    );
  }

  Widget _buildFeaturedCard() {
    return Container(
      height: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: BedbeesColors.mediumShadow,
      ),
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: BedbeesColors.sunsetGradient,
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  Colors.black.withOpacity(0.7),
                ],
              ),
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          const Positioned(
            top: 16,
            left: 16,
            child: BedbeesBadge(
              text: '50% OFF',
              backgroundColor: BedbeesColors.sunshineYellow,
              textColor: BedbeesColors.darkText,
            ),
          ),
          Positioned(
            top: 16,
            right: 16,
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.3),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.favorite_border,
                color: BedbeesColors.white,
                size: 20,
              ),
            ),
          ),
          Positioned(
            bottom: 16,
            left: 16,
            right: 16,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Maldives Paradise',
                  style: BedbeesTextStyles.h2.copyWith(
                    color: BedbeesColors.white,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '7 nights • All Inclusive',
                  style: BedbeesTextStyles.bodyMedium.copyWith(
                    color: BedbeesColors.white.withOpacity(0.9),
                  ),
                ),
                const SizedBox(height: 8),
                const Row(
                  children: [
                    BedbeesRating(rating: 4.9),
                    Spacer(),
                    BedbeesPriceTag(price: '\$2,499'),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryChip(String label) {
    final isSelected = _selectedCategory == label;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedCategory = label;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? BedbeesColors.primaryBlue : BedbeesColors.white,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: isSelected ? BedbeesColors.primaryBlue : BedbeesColors.lightGrey,
          ),
        ),
        child: Text(
          label,
          style: BedbeesTextStyles.label.copyWith(
            color: isSelected ? BedbeesColors.white : BedbeesColors.darkText,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Widget _buildDestinationCard(
    String name,
    String imageUrl,
    double rating,
    String price,
    String? badge,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: BedbeesColors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: BedbeesColors.softShadow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image
          Expanded(
            child: Stack(
              children: [
                Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                    gradient: BedbeesColors.blueGradient,
                  ),
                ),
                if (badge != null)
                  Positioned(
                    top: 12,
                    left: 12,
                    child: BedbeesBadge(
                      text: badge,
                      backgroundColor: BedbeesColors.coral,
                    ),
                  ),
                Positioned(
                  top: 12,
                  right: 12,
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.3),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.favorite_border,
                      color: BedbeesColors.white,
                      size: 18,
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Info
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: BedbeesTextStyles.h4,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    BedbeesRating(rating: rating),
                    const Spacer(),
                    BedbeesPriceTag(price: price),
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
