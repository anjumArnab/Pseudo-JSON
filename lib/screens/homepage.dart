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
      print('Error fetching products: $e');
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Welcome ${widget.user.firstName}"),
      ),
      drawer: CustomDrawer(user: widget.user),
      body: FutureBuilder<List<Product>?> (
        future: _productsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (snapshot.data == null || snapshot.data!.isEmpty) {
            return Center(child: Text('No products found'));
          }

          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
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
                  catagory: product.category,
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
