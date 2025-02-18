import 'package:flutter/material.dart';
import 'package:pseudo_json/models/auth_user.dart';
import 'package:pseudo_json/models/products.dart';
import 'package:pseudo_json/widgets/drawer.dart';
import 'package:pseudo_json/widgets/product_card.dart';

class HomePage extends StatefulWidget {
  final AuthUser user;
  final Product product;

  const HomePage({super.key, required this.user, required this.product});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Welcome ${widget.user.firstName}"),
      ),
      drawer: CustomDrawer(user: widget.user),
      body: ProductCard(
        imageUrl: widget.product.images[0],
        title: widget.product.title,
        catagory: widget.product.category,
        price: widget.product.price,
        discountPercentage: widget.product.discountPercentage,
        brand: widget.product.brand,
        sku: widget.product.sku,
      ),
    );
  }
}
