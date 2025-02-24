import 'package:flutter/material.dart';
import 'package:pseudo_json/models/auth_user.dart';
import 'package:pseudo_json/models/products.dart';
import 'package:pseudo_json/widgets/drawer.dart';
import 'package:pseudo_json/widgets/product_card.dart';
import 'package:pseudo_json/services/api_services.dart';

class HomePage extends StatefulWidget {
  final AuthUser user;

  const HomePage({super.key, required this.user});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<Product>?> _productsFuture;
  bool isSearching = false;
  TextEditingController searchController = TextEditingController();
  String _selectedSortBy = 'price';
  String _selectedOrder = 'asc';

  @override
  void initState() {
    super.initState();
    _productsFuture = fetchProductInfo();
  }

  Future<List<Product>?> fetchProductInfo() async {
    try {
      final products = await getProductInfo();
      return products;
    } catch (e) {
      return null;
    }
  }

  Future<void> searchProducts(String keyword) async {
    setState(() {
      _productsFuture = getSearchProduct(keyword);
    });
  }

  // Update sorting and refresh products
  void updateSorting(String sortBy, String order) {
    setState(() {
      _selectedSortBy = sortBy;
      _selectedOrder = order;
      _productsFuture = getSortProducts(_selectedSortBy, _selectedOrder);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Welcome ${widget.user.firstName}"),
      ),
      drawer: CustomDrawer(user: widget.user),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search, color: Colors.grey[600]),
                hintText: 'Search Products',
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
              ),
              onChanged: (value) {
                if (value.isNotEmpty) {
                  searchProducts(value);
                } else {
                  setState(() {
                    _productsFuture = fetchProductInfo();
                  });
                }
              },
            ),
          ),
          Expanded(
            child: FutureBuilder<List<Product>?>(
              future: _productsFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }
                if (snapshot.data == null || snapshot.data!.isEmpty) {
                  return const Center(child: Text('No products found'));
                }
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 5.0,
                      mainAxisSpacing: 5.0,
                      childAspectRatio: 1.4,
                    ),
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      final product = snapshot.data![index];
                      return Transform.scale(
                        scale: 1.0,
                        child: ProductCard(
                          imageUrl: product.images[0],
                          title: product.title,
                          category: product.category,
                          price: product.price,
                          discountPercentage: product.discountPercentage,
                          brand: product.brand,
                          sku: product.sku,
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.small(
        onPressed: () {},
        shape: const CircleBorder(),
        backgroundColor: Colors.white,
        child: PopupMenuButton<String>(
          icon: const Icon(Icons.filter_list, color: Colors.black),
          elevation: 0,
          color: Colors.transparent,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          onSelected: (String value) {
            if (value == 'asc' || value == 'desc') {
              updateSorting(_selectedSortBy, value);
            } else {
              updateSorting(value, _selectedOrder);
            }
          },
          itemBuilder: (context) => [
            _buildPopupMenuItem('price', 'Price'),
            _buildPopupMenuItem('rating', 'Rating'),
            _buildPopupMenuItem('discountPercentage', 'Discount'),
            const PopupMenuDivider(),
            _buildPopupMenuItem('asc', 'Ascending Order'),
            _buildPopupMenuItem('desc', 'Descending Order'),
          ],
        ),
      ),
    );
  }

  PopupMenuItem<String> _buildPopupMenuItem(String value, String text) {
    return PopupMenuItem(
      value: value,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        decoration: BoxDecoration(
          color: Colors.white, // White background for items
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1), // Soft shadow
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Text(
          text,
          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}
