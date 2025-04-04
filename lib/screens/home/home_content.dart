// ignore_for_file: deprecated_member_use

import 'package:fancy/data/shop.dart';
import 'package:fancy/model/shop.dart';
import 'package:fancy/providers/user_provider.dart';
import 'package:fancy/widgets/product_details/product_card.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class HomeContent extends StatefulWidget {
  const HomeContent({super.key});

  @override
  State<HomeContent> createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> {
  String _selectedCategory = 'All';
  List<Product> _displayedProducts = [];
  final TextEditingController _searchController = TextEditingController();
  String _sortOption = 'Newest';

  @override
  void initState() {
    super.initState();
    _displayedProducts = ProductData.getAllProducts();

    _searchController.addListener(() {
      _filterProducts();
    });
  }

  void _filterProducts() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      if (query.isEmpty && _selectedCategory == 'All') {
        _displayedProducts = ProductData.getAllProducts();
      } else if (query.isEmpty) {
        _displayedProducts = ProductData.getProductsByCategory(
          _selectedCategory,
        );
      } else if (_selectedCategory == 'All') {
        _displayedProducts = ProductData.searchProducts(query);
      } else {
        _displayedProducts =
            ProductData.searchProducts(
              query,
            ).where((p) => p.category == _selectedCategory).toList();
      }

      // Apply sorting
      _sortProducts();
    });
  }

  void _sortProducts() {
    switch (_sortOption) {
      case 'Price: Low to High':
        _displayedProducts.sort((a, b) => a.price.compareTo(b.price));
        break;
      case 'Price: High to Low':
        _displayedProducts.sort((a, b) => b.price.compareTo(a.price));
        break;
      case 'Rating':
        _displayedProducts.sort((a, b) => b.rating.compareTo(a.rating));
        break;
      case 'Newest':
      default:
        // Assuming newest is the default order in ProductData
        break;
    }
  }

  void _selectCategory(String category) {
    setState(() {
      _selectedCategory = category;
      _filterProducts();
    });
  }

  void _changeSort(String? value) {
    if (value != null) {
      setState(() {
        _sortOption = value;
        _sortProducts();
      });
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final categories = ['All', ...ProductData.getCategories()];
    return SafeArea(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            color: Colors.white,
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    height: 48,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 240, 240, 240),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: Color.fromARGB(255, 165, 81, 139),
                        width: 2,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: TextField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        hintText: 'Search for clothing...',
                        hintStyle: GoogleFonts.marcellus(color: Colors.black),
                        prefixIcon: Icon(Icons.search, color: Colors.grey[600]),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),

                const SizedBox(width: 16),

                ClipOval(
                  child: Container(
                    height: 50,
                    width: 50,
                    color: Color.fromARGB(255, 165, 81, 139),
                    child: FadeInImage.assetNetwork(
                      placeholder: 'assets/logo_bg.png',
                      image:
                          context.read<UserProvider>().user!.profilePictureURL,
                      fit: BoxFit.cover,
                      imageErrorBuilder: (context, error, stackTrace) {
                        return const Icon(Icons.error);
                      },
                      placeholderFit: BoxFit.cover,
                      fadeInDuration: const Duration(milliseconds: 500),
                      fadeInCurve: Curves.easeIn,
                    ),
                  ),
                ),
              ],
            ),
          ),

          Container(
            height: 50,
            color: Colors.white,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 8),
              itemCount: categories.length,
              itemBuilder: (context, index) {
                final category = categories[index];
                final isSelected = category == _selectedCategory;

                return GestureDetector(
                  onTap: () => _selectCategory(category),
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 8,
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color:
                          isSelected
                              ? Color.fromARGB(255, 165, 81, 139)
                              : Colors.grey[200],
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      category,
                      style: GoogleFonts.marcellus(
                        color: isSelected ? Colors.white : Colors.black,
                        fontWeight:
                            isSelected ? FontWeight.bold : FontWeight.normal,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                SizedBox(
                  child: Text(
                    _selectedCategory == 'All'
                        ? 'All Products'
                        : _selectedCategory,
                    style: GoogleFonts.marcellus(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
                const Spacer(),
                DropdownButton<String>(
                  value: _sortOption,
                  underline: const SizedBox(),
                  hint: Text('Sort by', style: GoogleFonts.marcellus()),
                  items: [
                    DropdownMenuItem(
                      value: 'Newest',
                      child: Text('Newest', style: GoogleFonts.marcellus()),
                    ),
                    DropdownMenuItem(
                      value: 'Price: Low to High',
                      child: Text(
                        'Price: Low to High',
                        style: GoogleFonts.marcellus(),
                      ),
                    ),
                    DropdownMenuItem(
                      value: 'Price: High to Low',
                      child: Text(
                        'Price: High to Low',
                        style: GoogleFonts.marcellus(),
                      ),
                    ),
                    DropdownMenuItem(
                      value: 'Rating',
                      child: Text('Rating', style: GoogleFonts.marcellus()),
                    ),
                  ],
                  onChanged: _changeSort,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${_displayedProducts.length} products found',
                  style: GoogleFonts.marcellus(
                    color: Colors.grey[600],
                    fontSize: 16,
                  ),
                ),
                if (_searchController.text.isNotEmpty ||
                    _selectedCategory != 'All')
                  Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: GestureDetector(
                      onTap: () {
                        _searchController.clear();
                        setState(() {
                          _selectedCategory = 'All';
                          _displayedProducts = ProductData.getAllProducts();
                        });
                      },
                      child: Text(
                        'Clear filters',
                        style: GoogleFonts.marcellus(
                          color: Color.fromARGB(255, 165, 81, 139),
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          Expanded(
            child:
                _displayedProducts.isEmpty
                    ? _buildNoProductsFound()
                    : GridView.builder(
                      padding: const EdgeInsets.all(16),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 0.75,
                            crossAxisSpacing: 16,
                            mainAxisSpacing: 16,
                          ),
                      itemCount: _displayedProducts.length,
                      itemBuilder: (context, index) {
                        final product = _displayedProducts[index];
                        return _buildProductCard(product);
                      },
                    ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductCard(Product product) {
    return ProductCard(product: product);
  }

  Widget _buildNoProductsFound() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.search_off, size: 64, color: Colors.grey[400]),
          const SizedBox(height: 16),
          Text(
            'No products found',
            style: GoogleFonts.marcellus(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.grey[700],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Try different keywords or categories',
            style: GoogleFonts.marcellus(fontSize: 14, color: Colors.grey[600]),
          ),
        ],
      ),
    );
  }
}
