import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/product_provider.dart';
import '../../widgets/product_card.dart';
import 'product_detail_screen.dart';

/// ProductsScreen - Displays list of products from API
///
/// This screen demonstrates:
/// - Beautiful modern UI with Thai language support
/// - Fetching data from an API
/// - Displaying data in a responsive grid
/// - Loading and error states with elegant animations
/// - Navigation to detail screen
class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen>
    with TickerProviderStateMixin {
  String _selectedCategory = 'ทั้งหมด';
  late PageController _bannerPageController;
  late Timer _bannerTimer;
  int _currentBannerIndex = 0;
  final int _bannerCount = 3;

  // Helper function to translate categories to Thai
  String _translateCategory(String category) {
    switch (category.toLowerCase()) {
      case 'electronics':
        return 'อิเล็กทรอนิกส์';
      case 'jewelery':
        return 'เครื่องประดับ';
      case "men's clothing":
        return 'เสื้อผ้าผู้ชาย';
      case "women's clothing":
        return 'เสื้อผ้าผู้หญิง';
      default:
        return category;
    }
  }

  // Build quick category icon
  Widget _buildQuickCategoryIcon(IconData icon, String label, Color color) {
    return GestureDetector(
      onTap: () {
        if (label != 'SALE') {
          setState(() {
            _selectedCategory = label;
          });
        }
      },
      child: Column(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: _selectedCategory == label ? color : Colors.transparent,
                width: 2,
              ),
            ),
            child: Icon(icon, color: color, size: 28),
          ),
          const SizedBox(height: 8),
          Text(
            label == 'เสื้อผ้าผู้ชาย'
                ? 'ผู้ชาย'
                : label == 'อิเล็กทรอนิกส์'
                ? 'อีเล็ค'
                : label,
            style: TextStyle(
              fontSize: 12,
              fontFamily: 'Kanit',
              fontWeight: FontWeight.w500,
              color: _selectedCategory == label ? color : Colors.grey[600],
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _bannerPageController = PageController();
    _startBannerTimer();
  }

  @override
  void dispose() {
    _bannerTimer.cancel();
    _bannerPageController.dispose();
    super.dispose();
  }

  void _startBannerTimer() {
    _bannerTimer = Timer.periodic(const Duration(seconds: 4), (timer) {
      if (mounted) {
        _currentBannerIndex = (_currentBannerIndex + 1) % _bannerCount;
        _bannerPageController.animateToPage(
          _currentBannerIndex,
          duration: const Duration(milliseconds: 800),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  /// Build promotion banner widget
  Widget _buildPromotionBanner({
    required String title,
    required String subtitle,
    required String description,
    required List<Color> gradientColors,
    required IconData icon,
    Color? accentColor,
  }) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: gradientColors,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Stack(
        children: [
          // Background decorative elements
          Positioned(
            right: -30,
            top: -30,
            child: Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color:
                    accentColor?.withOpacity(0.2) ??
                    Colors.white.withOpacity(0.1),
              ),
            ),
          ),
          Positioned(
            right: 20,
            bottom: -20,
            child: Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color:
                    accentColor?.withOpacity(0.15) ??
                    Colors.white.withOpacity(0.08),
              ),
            ),
          ),

          // Main content
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Row(
                      children: [
                        Icon(icon, color: Colors.white, size: 20),
                        const SizedBox(width: 8),
                        Text(
                          'เปิด $title',
                          style: const TextStyle(
                            fontFamily: 'Kanit',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    backgroundColor: gradientColors.first,
                    behavior: SnackBarBehavior.floating,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                );
              },
              borderRadius: BorderRadius.circular(20),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    // Icon section
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Icon(icon, size: 32, color: Colors.white),
                    ),
                    const SizedBox(width: 20),

                    // Text content
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            title,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontFamily: 'Kanit',
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            subtitle,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                              fontFamily: 'Kanit',
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            description,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white.withOpacity(0.9),
                              fontFamily: 'Kanit',
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Arrow icon
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(
                        Icons.arrow_forward_ios_rounded,
                        size: 16,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductProvider>(
      builder: (context, productProvider, child) {
        // Show loading indicator while fetching data
        if (productProvider.isLoading && productProvider.products.isEmpty) {
          return Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Theme.of(context).colorScheme.primary.withOpacity(0.1),
                  Colors.white,
                ],
              ),
            ),
            child: const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 16),
                  Text(
                    'กำลังโหลดสินค้า...',
                    style: TextStyle(
                      fontFamily: 'Kanit',
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          );
        }

        // Show error message if fetch failed
        if (productProvider.error != null && productProvider.products.isEmpty) {
          return Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.red.withOpacity(0.1), Colors.white],
              ),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.red.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: const Icon(
                      Icons.error_outline,
                      size: 64,
                      color: Colors.red,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'เกิดข้อผิดพลาด',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Kanit',
                      color: Colors.red,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'ไม่สามารถโหลดข้อมูลสินค้าได้',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 16,
                      fontFamily: 'Kanit',
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton.icon(
                    onPressed: () => productProvider.fetchProducts(),
                    icon: const Icon(Icons.refresh),
                    label: const Text(
                      'ลองใหม่',
                      style: TextStyle(fontFamily: 'Kanit', fontSize: 16),
                    ),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 12,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }

        // Show products in a grid
        final allProducts = productProvider.products;
        final products = _selectedCategory == 'ทั้งหมด'
            ? allProducts
            : allProducts
                  .where(
                    (product) =>
                        _translateCategory(product.category) ==
                        _selectedCategory,
                  )
                  .toList();

        if (products.isEmpty && allProducts.isNotEmpty) {
          return Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Theme.of(context).colorScheme.primary.withOpacity(0.1),
                  Colors.white,
                ],
              ),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.search_off, size: 80, color: Colors.grey),
                  const SizedBox(height: 16),
                  Text(
                    'ไม่พบสินค้าในหมวด "$_selectedCategory"',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Kanit',
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _selectedCategory = 'ทั้งหมด';
                      });
                    },
                    child: const Text(
                      'ดูสินค้าทั้งหมด',
                      style: TextStyle(fontFamily: 'Kanit'),
                    ),
                  ),
                ],
              ),
            ),
          );
        }

        if (products.isEmpty) {
          return Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Theme.of(context).colorScheme.primary.withOpacity(0.1),
                  Colors.white,
                ],
              ),
            ),
            child: const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.shopping_bag_outlined,
                    size: 80,
                    color: Colors.grey,
                  ),
                  SizedBox(height: 16),
                  Text(
                    'ไม่พบสินค้า',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Kanit',
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          );
        }

        return RefreshIndicator(
          onRefresh: () => productProvider.fetchProducts(),
          child: CustomScrollView(
            slivers: [
              // Modern App bar
              SliverAppBar(
                expandedHeight: 200,
                floating: false,
                pinned: true,
                backgroundColor: Colors.white,
                elevation: 0,
                flexibleSpace: FlexibleSpaceBar(
                  background: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [Colors.pink[400]!, Colors.purple[400]!],
                      ),
                    ),
                    child: Stack(
                      children: [
                        // Background pattern
                        Positioned(
                          right: -50,
                          top: -50,
                          child: Container(
                            width: 200,
                            height: 200,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white.withOpacity(0.1),
                            ),
                          ),
                        ),
                        // Hero content
                        Positioned(
                          left: 20,
                          bottom: 80,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'DISCOVER',
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 14,
                                  fontFamily: 'Kanit',
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const Text(
                                'FASHION',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 32,
                                  fontFamily: 'Kanit',
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const Text(
                                'COLLECTION',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 24,
                                  fontFamily: 'Kanit',
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 8,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: const Text(
                                  'SHOP NOW',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 12,
                                    fontFamily: 'Kanit',
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  title: _selectedCategory != 'ทั้งหมด'
                      ? Text(
                          '$_selectedCategory (${products.length})',
                          style: const TextStyle(
                            fontFamily: 'Kanit',
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: 18,
                          ),
                        )
                      : null,
                ),
              ),

              // Quick category icons
              SliverToBoxAdapter(
                child: Container(
                  margin: const EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildQuickCategoryIcon(
                        Icons.phone_android,
                        'อิเล็กทรอนิกส์',
                        Colors.blue,
                      ),
                      _buildQuickCategoryIcon(
                        Icons.diamond,
                        'เครื่องประดับ',
                        Colors.purple,
                      ),
                      _buildQuickCategoryIcon(
                        Icons.checkroom,
                        'เสื้อผ้าผู้ชาย',
                        Colors.orange,
                      ),
                      _buildQuickCategoryIcon(
                        Icons.local_offer,
                        'SALE',
                        Colors.red,
                      ),
                    ],
                  ),
                ),
              ),

              // Category filter section
              SliverToBoxAdapter(
                child: Container(
                  height: 70,
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        spreadRadius: 1,
                        blurRadius: 3,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    children: [
                      _CategoryChip(
                        label: 'ทั้งหมด',
                        isSelected: _selectedCategory == 'ทั้งหมด',
                        onTap: () {
                          setState(() {
                            _selectedCategory = 'ทั้งหมด';
                          });
                        },
                      ),
                      ...productProvider.getCategories().map((category) {
                        final translatedCategory = _translateCategory(category);
                        return _CategoryChip(
                          label: translatedCategory,
                          isSelected: _selectedCategory == translatedCategory,
                          onTap: () {
                            setState(() {
                              _selectedCategory = translatedCategory;
                            });
                          },
                        );
                      }),
                    ],
                  ),
                ),
              ),

              // Enhanced Promotion Banner Section with Auto-Slide
              SliverToBoxAdapter(
                child: Container(
                  margin: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                  child: Column(
                    children: [
                      // Banner carousel
                      Container(
                        height: 180,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              spreadRadius: 0,
                              blurRadius: 15,
                              offset: const Offset(0, 5),
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: PageView(
                            controller: _bannerPageController,
                            onPageChanged: (index) {
                              setState(() {
                                _currentBannerIndex = index;
                              });
                            },
                            children: [
                              // Banner 1 - Flash Sale
                              _buildPromotionBanner(
                                title: 'FLASH SALE',
                                subtitle: 'ลดสูงสุด 70%',
                                description: 'เฉพาะวันนี้เท่านั้น! ⚡',
                                gradientColors: [
                                  const Color(0xFFFF6B6B),
                                  const Color(0xFFFF8E53),
                                ],
                                icon: Icons.flash_on_rounded,
                                accentColor: Colors.orange.shade100,
                              ),

                              // Banner 2 - New Arrival
                              _buildPromotionBanner(
                                title: 'NEW ARRIVAL',
                                subtitle: 'สินค้าใหม่มาแล้ว',
                                description: 'อัปเดตทุกวัน ✨',
                                gradientColors: [
                                  const Color(0xFF667EEA),
                                  const Color(0xFF764BA2),
                                ],
                                icon: Icons.new_releases_rounded,
                                accentColor: Colors.blue.shade100,
                              ),

                              // Banner 3 - Free Shipping
                              _buildPromotionBanner(
                                title: 'FREE SHIPPING',
                                subtitle: 'ส่งฟรีทุกออเดอร์',
                                description: 'เมื่อซื้อครับ ฿999 🚚',
                                gradientColors: [
                                  const Color(0xFF11998E),
                                  const Color(0xFF38EF7D),
                                ],
                                icon: Icons.local_shipping_rounded,
                                accentColor: Colors.green.shade100,
                              ),
                            ],
                          ),
                        ),
                      ),

                      // Page indicators
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          _bannerCount,
                          (index) => AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            margin: const EdgeInsets.symmetric(horizontal: 4),
                            width: _currentBannerIndex == index ? 24 : 8,
                            height: 8,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              gradient: _currentBannerIndex == index
                                  ? const LinearGradient(
                                      colors: [Colors.pink, Colors.purple],
                                    )
                                  : null,
                              color: _currentBannerIndex == index
                                  ? null
                                  : Colors.grey.shade300,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Products grid
              SliverPadding(
                padding: const EdgeInsets.all(16),
                sliver: SliverGrid(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.75, // Better ratio to prevent overflow
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                  ),
                  delegate: SliverChildBuilderDelegate((context, index) {
                    final product = products[index];
                    return ProductCard(
                      product: product,
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) =>
                                ProductDetailScreen(product: product),
                          ),
                        );
                      },
                    );
                  }, childCount: products.length),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

/// Category chip widget for filtering
class _CategoryChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _CategoryChip({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 12),
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(
            gradient: isSelected
                ? LinearGradient(
                    colors: [
                      Theme.of(context).colorScheme.primary,
                      Theme.of(context).colorScheme.primary.withOpacity(0.8),
                    ],
                  )
                : null,
            color: isSelected ? null : Colors.grey[100],
            borderRadius: BorderRadius.circular(25),
            border: Border.all(
              color: isSelected
                  ? Theme.of(context).colorScheme.primary
                  : Colors.grey[300]!,
              width: 1.5,
            ),
            boxShadow: isSelected
                ? [
                    BoxShadow(
                      color: Theme.of(
                        context,
                      ).colorScheme.primary.withOpacity(0.3),
                      spreadRadius: 1,
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ]
                : null,
          ),
          child: Text(
            label,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.grey[700],
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
              fontSize: 14,
              fontFamily: 'Kanit',
            ),
          ),
        ),
      ),
    );
  }
}
