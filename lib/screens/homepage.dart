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
  // ignore: library_private_types_in_public_api
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
        title: isSearching
            ? TextField(
                controller: searchController,
                autofocus: true,
                decoration: const InputDecoration(
                  hintText: 'Search by title...',
                  hintStyle: TextStyle(color: Colors.black),
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
              )
            : Text("Welcome ${widget.user.firstName}"),
        actions: [
          IconButton(
            icon: Icon(isSearching ? Icons.close : Icons.search),
            onPressed: () {
              setState(() {
                isSearching = !isSearching;
                if (!isSearching) {
                  searchController.clear();
                  _productsFuture = fetchProductInfo();
                }
              });
            },
          ),
          DropdownButton<String>(
            value: _selectedSortBy,
            icon: const Icon(Icons.sort, color: Colors.black),
            dropdownColor: Colors.white,
            onChanged: (String? newValue) {
              if (newValue != null) {
                updateSorting(newValue, _selectedOrder);
              }
            },
            items: const [
              DropdownMenuItem(
                value: 'price',
                child: Text(
                  'Price',
                  style: TextStyle(color: Colors.black),
                ),
              ),
              DropdownMenuItem(
                value: 'rating',
                child: Text(
                  'Rating',
                  style: TextStyle(color: Colors.black),
                ),
              ),
              DropdownMenuItem(
                value: 'discountPercentage',
                child: Text(
                  'Discount',
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ],
          ),
          DropdownButton<String>(
            value: _selectedOrder,
            icon: const Icon(Icons.arrow_downward, color: Colors.black),
            dropdownColor: Colors.white,
            onChanged: (String? newValue) {
              if (newValue != null) {
                updateSorting(_selectedSortBy, newValue);
              }
            },
            items: const [
              DropdownMenuItem(
                value: 'asc',
                child: Text(
                  'Ascending',
                  style: TextStyle(color: Colors.black),
                ),
              ),
              DropdownMenuItem(
                value: 'desc',
                child: Text(
                  'Descending',
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ],
          ),
        ],
      ),
      drawer: CustomDrawer(user: widget.user),
      body: FutureBuilder<List<Product>?>(
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
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
                childAspectRatio: 0.7,
              ),
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final product = snapshot.data![index];
                return ProductCard(
                  imageUrl: product.images[0],
                  title: product.title,
                  category: product.category,
                  price: product.price,
                  discountPercentage: product.discountPercentage,
                  brand: product.brand,
                  sku: product.sku,
                );
              },
            ),
          );
        },
      ),
    );
  }
}
