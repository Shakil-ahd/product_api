import 'package:flutter/material.dart';
import 'package:product_api/model/api_product_model.dart';

class ProductDetailPage extends StatelessWidget {
  final Product product;
  final Function(Product) onAddToCart;

  const ProductDetailPage({super.key, required this.product, required this.onAddToCart});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(product.title)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(child: Image.network(product.image, fit: BoxFit.contain)),
            const SizedBox(height: 16),
            Text(product.title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text("\$${product.price}", style: const TextStyle(fontSize: 18, color: Colors.deepPurple)),
            const SizedBox(height: 8),
            Text(product.description),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                onAddToCart(product);
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Added to Cart")));
              },
              child: const Text("Add to Cart"),
            ),
          ],
        ),
      ),
    );
  }
}
