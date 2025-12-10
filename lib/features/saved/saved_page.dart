import 'package:flutter/material.dart';
import '../../core/theme/bedbees_colors.dart';
import '../../core/theme/bedbees_text_styles.dart';
import '../../core/widgets/bedbees_components.dart';

class SavedPage extends StatefulWidget {
  const SavedPage({super.key});

  @override
  State<SavedPage> createState() => _SavedPageState();
}

class _SavedPageState extends State<SavedPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool _isGridView = false;

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
            // Header
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: BedbeesColors.white,
                boxShadow: BedbeesColors.softShadow,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'My Favorites',
                        style: BedbeesTextStyles.h1.copyWith(
                          color: BedbeesColors.darkText,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '24 saved items',
                        style: BedbeesTextStyles.bodySmall.copyWith(
                          color: BedbeesColors.greyText,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(
                          _isGridView ? Icons.list_rounded : Icons.grid_view_rounded,
                          color: BedbeesColors.primaryBlue,
                        ),
                        onPressed: () {
                          setState(() {
                            _isGridView = !_isGridView;
                          });
                        },
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.search,
                          color: BedbeesColors.primaryBlue,
                        ),
                        onPressed: () {},
                      ),
                    ],
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
                  Tab(text: 'All'),
                  Tab(text: 'Destinations'),
                  Tab(text: 'Hotels'),
                  Tab(text: 'Tours'),
                ],
              ),
            ),

            // Content
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  _buildSavedList(),
                  _buildSavedList(),
                  _buildSavedList(),
                  _buildSavedList(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSavedList() {
    if (_isGridView) {
      return GridView.builder(
        padding: const EdgeInsets.all(20),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          childAspectRatio: 0.75,
        ),
        itemCount: 12,
        itemBuilder: (context, index) {
          return _buildGridCard(
            'Santorini ${index + 1}',
            'Greece',
            4.9,
            '\$${1299 + index * 100}',
          );
        },
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.all(20),
      itemCount: 12,
      separatorBuilder: (context, index) => const SizedBox(height: 16),
      itemBuilder: (context, index) {
        return _buildSavedCard(
          'Santorini ${index + 1}',
          'Beautiful island with white houses and blue domes',
          4.9,
          '\$${1299 + index * 100}',
          'image',
        );
      },
    );
  }

  Widget _buildGridCard(
    String title,
    String location,
    double rating,
    String price,
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
                    gradient: BedbeesColors.coralGradient,
                  ),
                ),
                Positioned(
                  top: 12,
                  right: 12,
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: const BoxDecoration(
                      color: BedbeesColors.white,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.favorite,
                      color: BedbeesColors.coral,
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
                  title,
                  style: BedbeesTextStyles.h4,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                Text(
                  location,
                  style: BedbeesTextStyles.caption.copyWith(
                    color: BedbeesColors.greyText,
                  ),
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

  Widget _buildSavedCard(
    String title,
    String description,
    double rating,
    String price,
    String imageUrl,
  ) {
    return Container(
      height: 120,
      decoration: BoxDecoration(
        color: BedbeesColors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: BedbeesColors.softShadow,
      ),
      child: Row(
        children: [
          // Image
          Container(
            width: 120,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.horizontal(left: Radius.circular(16)),
              gradient: BedbeesColors.blueGradient,
            ),
          ),
          // Content
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          title,
                          style: BedbeesTextStyles.h4,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.favorite,
                          color: BedbeesColors.coral,
                          size: 20,
                        ),
                        onPressed: () {},
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    description,
                    style: BedbeesTextStyles.bodySmall.copyWith(
                      color: BedbeesColors.greyText,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const Spacer(),
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
          ),
        ],
      ),
    );
  }
}
