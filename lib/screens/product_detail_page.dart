import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pseudo_json/models/products.dart';
import 'package:pseudo_json/screens/product_detail.dart';

class ProductDetailPage extends StatelessWidget {
  final Product product;

  const ProductDetailPage({super.key, required this.product});

    void moveToProductDetail(BuildContext context){
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => ProductDetail(product: product)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product.title),
        actions: [
          IconButton(
            icon: const Icon(Icons.update),
            onPressed: (){
              moveToProductDetail(context);
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.network(
                product.thumbnail,
                height: 200,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              product.title,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              "${product.brand} | SKU: ${product.sku}",
              style: TextStyle(fontSize: 16, color: Colors.grey[700]),
            ),
            const SizedBox(height: 8),
            Text(
              "\$${product.price.toStringAsFixed(2)} (-${product.discountPercentage.toStringAsFixed(2)}%)",
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.green),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Icon(Icons.star, color: Colors.orange[400]),
                Text(" ${product.rating.toStringAsFixed(2)} / 5")
              ],
            ),
            const SizedBox(height: 16),
            Text(
              product.description,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            Text(
              "Availability: ${product.availabilityStatus}",
              style: TextStyle(
                fontSize: 16,
                color: product.stock > 0 ? Colors.green : Colors.red,
              ),
            ),
            const SizedBox(height: 16),
            Divider(color: Colors.grey[400]),
            const SizedBox(height: 16),
            _buildSectionTitle("Warranty & Shipping"),
            Text("Warranty: ${product.warrantyInformation}"),
            Text("Shipping: ${product.shippingInformation}"),
            const SizedBox(height: 16),
            _buildSectionTitle("Return Policy"),
            Text(product.returnPolicy),
            const SizedBox(height: 16),
            _buildSectionTitle("Product Dimensions"),
            Text("${product.dimensions.width} x ${product.dimensions.height} x ${product.dimensions.depth} cm"),
            const SizedBox(height: 16),
            _buildSectionTitle("Reviews"),
            _buildReviewList(),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
    );
  }

  Widget _buildReviewList() {
    if (product.reviews.isEmpty) {
      return const Text("No reviews yet.");
    }
    return Column(
      children: product.reviews.map((review) {
        return Card(
          elevation: 2,
          margin: const EdgeInsets.symmetric(vertical: 8),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.star, color: Colors.orange[400]),
                    Text(" ${review.rating} / 5"),
                  ],
                ),
                const SizedBox(height: 4),
                Text(review.comment, style: const TextStyle(fontSize: 16)),
                const SizedBox(height: 4),
                Text("- ${review.reviewerName}", style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                Text("Reviewed on: ${DateFormat.yMMMd().format(DateTime.parse(review.date))}", style: const TextStyle(fontSize: 12, color: Colors.grey)),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}
