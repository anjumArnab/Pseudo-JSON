import 'package:flutter/material.dart';
import 'package:pseudo_json/models/products.dart';
import 'package:pseudo_json/widgets/custom_button.dart';
import 'package:pseudo_json/widgets/custom_text_field.dart';

class ProductDetail extends StatefulWidget {
  final Product product;

  const ProductDetail({super.key, required this.product});

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  late TextEditingController titleController;
  late TextEditingController descriptionController;
  late TextEditingController categoryController;
  late TextEditingController priceController;
  late TextEditingController discountPercentageController;
  late TextEditingController ratingController;
  late TextEditingController stockController;
  late TextEditingController brandController;
  late TextEditingController skuController;
  late TextEditingController weightController;
  late TextEditingController warrantyInformationController;
  late TextEditingController shippingInformationController;
  late TextEditingController availabilityStatusController;
  late TextEditingController returnPolicyController;
  late TextEditingController minimumOrderQuantityController;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: widget.product.title);
    descriptionController = TextEditingController(text: widget.product.description);
    categoryController = TextEditingController(text: widget.product.category);
    priceController = TextEditingController(text: widget.product.price.toString());
    discountPercentageController = TextEditingController(text: widget.product.discountPercentage.toString());
    ratingController = TextEditingController(text: widget.product.rating.toString());
    stockController = TextEditingController(text: widget.product.stock.toString());
    brandController = TextEditingController(text: widget.product.brand);
    skuController = TextEditingController(text: widget.product.sku);
    weightController = TextEditingController(text: widget.product.weight.toString());
    warrantyInformationController = TextEditingController(text: widget.product.warrantyInformation);
    shippingInformationController = TextEditingController(text: widget.product.shippingInformation);
    availabilityStatusController = TextEditingController(text: widget.product.availabilityStatus);
    returnPolicyController = TextEditingController(text: widget.product.returnPolicy);
    minimumOrderQuantityController = TextEditingController(text: widget.product.minimumOrderQuantity.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Product Detail')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              CustomTextField(controller: titleController, hintText: "Add a title"),
              const SizedBox(height: 5),
              CustomTextField(controller: descriptionController, hintText: "Write a detailed description", maxLines: 3),
              const SizedBox(height: 5),
              CustomTextField(controller: categoryController, hintText: "What is the category"),
              const SizedBox(height: 5),
              Row(
                children: [
                  Expanded(child: CustomTextField(controller: priceController, hintText: "Add price")),
                  const SizedBox(width: 5),
                  Expanded(child: CustomTextField(controller: discountPercentageController, hintText: "Add discount percentage")),
                ],
              ),
              const SizedBox(height: 5),
              Row(
                children: [
                  Expanded(child: CustomTextField(controller: brandController, hintText: "Add brand")),
                  const SizedBox(width: 5),
                  Expanded(child: CustomTextField(controller: stockController, hintText: "Add available stock")),
                  Expanded(child: CustomTextField(controller: skuController, hintText: "Add SKU")),
                  Expanded(child: CustomTextField(controller: weightController, hintText: "Add weight")),
                ],
              ),
              const SizedBox(height: 5),
              CustomTextField(controller: warrantyInformationController, hintText: "Write warranty information"),
              const SizedBox(height: 5),
              CustomTextField(controller: shippingInformationController, hintText: "Write shipping information"),
              const SizedBox(height: 5),
              CustomTextField(controller: availabilityStatusController, hintText: "Write availability status"),
              const SizedBox(height: 5),
              CustomTextField(controller: returnPolicyController, hintText: "What is the return policy"),
              const SizedBox(height: 5),
              CustomTextField(controller: minimumOrderQuantityController, hintText: "What is the minimum order quantity"),
              const SizedBox(height: 10),
              CustomButton(onPressed: () {}, text: "Done"),
            ],
          ),
        ),
      ),
    );
  }
}
