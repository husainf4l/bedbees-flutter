import 'package:flutter/material.dart';
import '../../core/theme/bedbees_colors.dart';
import '../../core/widgets/bedbees_components.dart';

class SavedPage extends StatefulWidget {
  const SavedPage({super.key});

  @override
  State<SavedPage> createState() => _SavedPageState();
}

class _SavedPageState extends State<SavedPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool _isGridView = true;
  bool _isSelectionMode = false;
  Set<int> _selectedItems = {};
  String _sortBy = 'recent'; // recent, name, price

  // Sample image URLs for saved items
  final List<String> _imageUrls = [
    'https://images.unsplash.com/photo-1613395877344-13d4a8e0d49e?w=800',
    'https://images.unsplash.com/photo-1533104816931-20fa691ff6ca?w=800',
    'https://images.unsplash.com/photo-1566073771259-6a8506099945?w=800',
    'https://images.unsplash.com/photo-1582719508461-905c673771fd?w=800',
    'https://images.unsplash.com/photo-1571896349842-33c89424de2d?w=800',
    'https://images.unsplash.com/photo-1520250497591-112f2f40a3f4?w=800',
    'https://images.unsplash.com/photo-1542314831-068cd1dbfeeb?w=800',
    'https://images.unsplash.com/photo-1555041469-a586c61ea9bc?w=800',
    'https://images.unsplash.com/photo-1578645510447-e20b4311e3ce?w=800',
    'https://images.unsplash.com/photo-1598970434795-0c54fe7c0648?w=800',
    'https://images.unsplash.com/photo-1551882547-ff40c63fe5fa?w=800',
    'https://images.unsplash.com/photo-1540541338287-41700207dee6?w=800',
  ];

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
      backgroundColor: const Color(0xFFF8F9FA),
      body: Column(
        children: [
          // Header with SafeArea
          SafeArea(
            bottom: false,
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.04),
                    blurRadius: 12,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'My Favorites',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF1A1A1A),
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        '24 saved items',
                        style: TextStyle(
                          fontSize: 14,
                          color: BedbeesColors.greyText.withOpacity(0.8),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  _isSelectionMode
                      ? Row(
                          children: [
                            TextButton(
                              onPressed: () {
                                setState(() {
                                  _isSelectionMode = false;
                                  _selectedItems.clear();
                                });
                              },
                              child: Text(
                                'Cancel',
                                style: TextStyle(
                                  color: BedbeesColors.greyText,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        )
                      : Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.06),
                                    blurRadius: 12,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: IconButton(
                                icon: const Icon(
                                  Icons.filter_list_rounded,
                                  color: BedbeesColors.primaryBlue,
                                  size: 22,
                                ),
                                onPressed: _showSortOptions,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.06),
                                    blurRadius: 12,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: IconButton(
                                icon: const Icon(
                                  Icons.search,
                                  color: BedbeesColors.primaryBlue,
                                  size: 22,
                                ),
                                onPressed: () {},
                              ),
                            ),
                          ],
                        ),
                ],
              ),
            ),
          ),

          // Selection Mode Toolbar
          if (_isSelectionMode)
            Container(
              color: BedbeesColors.coral,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              child: Row(
                children: [
                  Text(
                    '${_selectedItems.length} selected',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                    ),
                  ),
                  const Spacer(),
                  TextButton.icon(
                    onPressed: _selectedItems.isEmpty ? null : _deleteSelected,
                    icon: const Icon(Icons.delete_outline, color: Colors.white, size: 20),
                    label: const Text(
                      'Delete',
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
                    ),
                  ),
                  const SizedBox(width: 8),
                  TextButton.icon(
                    onPressed: () {
                      setState(() {
                        if (_selectedItems.length == 12) {
                          _selectedItems.clear();
                        } else {
                          _selectedItems = Set.from(List.generate(12, (i) => i));
                        }
                      });
                    },
                    icon: Icon(
                      _selectedItems.length == 12 ? Icons.deselect : Icons.select_all,
                      color: Colors.white,
                      size: 20,
                    ),
                    label: Text(
                      _selectedItems.length == 12 ? 'Deselect All' : 'Select All',
                      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
            ),

          // Tabs
          Container(
            color: Colors.white,
            child: TabBar(
              controller: _tabController,
              labelColor: BedbeesColors.primaryBlue,
              unselectedLabelColor: BedbeesColors.greyText,
              indicatorColor: BedbeesColors.primaryBlue,
              indicatorWeight: 3,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              labelStyle: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
              ),
              unselectedLabelStyle: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
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
    );
  }

  Widget _buildSavedList() {
    if (_isGridView) {
      return RefreshIndicator(
        onRefresh: () async {
          await Future.delayed(const Duration(seconds: 1));
        },
        color: BedbeesColors.coral,
        child: GridView.builder(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 100),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            childAspectRatio: 0.72,
          ),
          itemCount: 12,
          itemBuilder: (context, index) {
            return _buildGridCard(
              index,
              'Santorini ${index + 1}',
              'Greece',
              4.9,
              '\$${1299 + index * 100}',
            );
          },
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: () async {
        await Future.delayed(const Duration(seconds: 1));
      },
      color: BedbeesColors.coral,
      child: ListView.separated(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 100),
        itemCount: 12,
        separatorBuilder: (context, index) => const SizedBox(height: 16),
        itemBuilder: (context, index) {
          return _buildSavedCard(
            index,
            'Santorini ${index + 1}',
            'Beautiful island with white houses and blue domes',
            4.9,
            '\$${1299 + index * 100}',
            'image',
          );
        },
      ),
    );
  }

  Widget _buildGridCard(
    int index,
    String title,
    String location,
    double rating,
    String price,
  ) {
    final isSelected = _selectedItems.contains(index);
    final category = ['Destination', 'Hotel', 'Tour'][index % 3];

    return GestureDetector(
      onLongPress: () {
        setState(() {
          _isSelectionMode = true;
          _selectedItems.add(index);
        });
      },
      onTap: _isSelectionMode
          ? () {
              setState(() {
                if (isSelected) {
                  _selectedItems.remove(index);
                  if (_selectedItems.isEmpty) {
                    _isSelectionMode = false;
                  }
                } else {
                  _selectedItems.add(index);
                }
              });
            }
          : null,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          border: isSelected
              ? Border.all(color: BedbeesColors.coral, width: 3)
              : null,
          boxShadow: [
            BoxShadow(
              color: isSelected
                  ? BedbeesColors.coral.withOpacity(0.3)
                  : Colors.black.withOpacity(0.06),
              blurRadius: 16,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image
            Expanded(
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                    child: Image.network(
                      _imageUrls[index % _imageUrls.length],
                      width: double.infinity,
                      height: double.infinity,
                      fit: BoxFit.cover,
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                BedbeesColors.coral.withOpacity(0.3),
                                BedbeesColors.coral.withOpacity(0.5),
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                          ),
                          child: Center(
                            child: CircularProgressIndicator(
                              value: loadingProgress.expectedTotalBytes != null
                                  ? loadingProgress.cumulativeBytesLoaded /
                                      loadingProgress.expectedTotalBytes!
                                  : null,
                              color: Colors.white,
                              strokeWidth: 2,
                            ),
                          ),
                        );
                      },
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                BedbeesColors.coral.withOpacity(0.8),
                                BedbeesColors.coral,
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                          ),
                          child: Center(
                            child: Icon(
                              Icons.image_not_supported_outlined,
                              color: Colors.white.withOpacity(0.6),
                              size: 32,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  // Category Badge
                  Positioned(
                    top: 12,
                    left: 12,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.95),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Text(
                        category,
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                          color: BedbeesColors.coral,
                        ),
                      ),
                    ),
                  ),
                  // Favorite/Selection Icon
                  Positioned(
                    top: 12,
                    right: 12,
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: isSelected ? BedbeesColors.coral : Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Icon(
                        isSelected ? Icons.check : Icons.favorite,
                        color: isSelected ? Colors.white : BedbeesColors.coral,
                        size: 18,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          // Info
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF1A1A1A),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                Text(
                  location,
                  style: TextStyle(
                    fontSize: 11,
                    color: BedbeesColors.greyText,
                    fontWeight: FontWeight.w500,
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
      ),
    );
  }

  Widget _buildSavedCard(
    int index,
    String title,
    String description,
    double rating,
    String price,
    String imageUrl,
  ) {
    final isSelected = _selectedItems.contains(index);

    return GestureDetector(
      onLongPress: () {
        setState(() {
          _isSelectionMode = true;
          _selectedItems.add(index);
        });
      },
      onTap: _isSelectionMode
          ? () {
              setState(() {
                if (isSelected) {
                  _selectedItems.remove(index);
                  if (_selectedItems.isEmpty) {
                    _isSelectionMode = false;
                  }
                } else {
                  _selectedItems.add(index);
                }
              });
            }
          : null,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        height: 130,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: isSelected
              ? Border.all(color: BedbeesColors.coral, width: 3)
              : null,
          boxShadow: [
            BoxShadow(
              color: isSelected
                  ? BedbeesColors.coral.withOpacity(0.3)
                  : Colors.black.withOpacity(0.06),
              blurRadius: 16,
              offset: const Offset(0, 4),
            ),
          ],
        ),
      child: Row(
        children: [
          // Image
          ClipRRect(
            borderRadius: BorderRadius.horizontal(left: Radius.circular(20)),
            child: Image.network(
              _imageUrls[index % _imageUrls.length],
              width: 130,
              height: double.infinity,
              fit: BoxFit.cover,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return Container(
                  width: 130,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        BedbeesColors.primaryBlue.withOpacity(0.3),
                        BedbeesColors.primaryBlue.withOpacity(0.5),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: Center(
                    child: CircularProgressIndicator(
                      value: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded /
                              loadingProgress.expectedTotalBytes!
                          : null,
                      color: Colors.white,
                      strokeWidth: 2,
                    ),
                  ),
                );
              },
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  width: 130,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        BedbeesColors.primaryBlue.withOpacity(0.8),
                        BedbeesColors.primaryBlue,
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: Center(
                    child: Icon(
                      Icons.image_not_supported_outlined,
                      color: Colors.white.withOpacity(0.6),
                      size: 32,
                    ),
                  ),
                );
              },
            ),
          ),
          // Content
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          title,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF1A1A1A),
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? BedbeesColors.coral
                              : BedbeesColors.coral.withOpacity(0.1),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          isSelected ? Icons.check : Icons.favorite,
                          color: isSelected ? Colors.white : BedbeesColors.coral,
                          size: 18,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(
                    description,
                    style: TextStyle(
                      fontSize: 13,
                      color: BedbeesColors.greyText,
                      fontWeight: FontWeight.w400,
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
      ),
    );
  }

  void _showSortOptions() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: BedbeesColors.greyText.withOpacity(0.3),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'Sort By',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF1A1A1A),
                ),
              ),
            ),
            const SizedBox(height: 16),
            _buildSortOption('Recent', 'recent', Icons.access_time),
            _buildSortOption('Name', 'name', Icons.sort_by_alpha),
            _buildSortOption('Price', 'price', Icons.attach_money),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildSortOption(String label, String value, IconData icon) {
    final isSelected = _sortBy == value;
    return ListTile(
      leading: Icon(
        icon,
        color: isSelected ? BedbeesColors.coral : BedbeesColors.greyText,
      ),
      title: Text(
        label,
        style: TextStyle(
          fontSize: 16,
          fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
          color: isSelected ? BedbeesColors.coral : Color(0xFF1A1A1A),
        ),
      ),
      trailing: isSelected
          ? Icon(Icons.check_circle, color: BedbeesColors.coral)
          : null,
      onTap: () {
        setState(() {
          _sortBy = value;
        });
        Navigator.pop(context);
      },
    );
  }

  void _deleteSelected() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text(
          'Delete Items',
          style: TextStyle(
            fontWeight: FontWeight.w700,
            color: Color(0xFF1A1A1A),
          ),
        ),
        content: Text(
          'Are you sure you want to remove ${_selectedItems.length} item(s) from your favorites?',
          style: TextStyle(
            color: BedbeesColors.greyText,
            fontSize: 15,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cancel',
              style: TextStyle(
                color: BedbeesColors.greyText,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                _selectedItems.clear();
                _isSelectionMode = false;
              });
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Items removed from favorites'),
                  backgroundColor: BedbeesColors.coral,
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  action: SnackBarAction(
                    label: 'Undo',
                    textColor: Colors.white,
                    onPressed: () {},
                  ),
                ),
              );
            },
            child: Text(
              'Delete',
              style: TextStyle(
                color: BedbeesColors.coral,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
