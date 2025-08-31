import 'package:flutter/material.dart';
import 'package:product_api/model/api_product_model.dart';

class CartPage extends StatefulWidget {
  final List<Product> cart;
  final Function(List<Product>) onCartUpdated;

  const CartPage({super.key, required this.cart, required this.onCartUpdated});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  late List<Product> cartItems;

  @override
  void initState() {
    super.initState();
    cartItems = List.from(widget.cart);
  }

  void removeItem(int index) {
    setState(() {
      cartItems.removeAt(index);
      widget.onCartUpdated(cartItems);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Cart")),
      body: cartItems.isEmpty
          ? const Center(child: Text("Cart is empty"))
          : ListView.builder(
              itemCount: cartItems.length,
              itemBuilder: (context, index) {
                final product = cartItems[index];
                return ListTile(
                  leading: Image.network(product.image, width: 50, height: 50),
                  title: Text(product.title),
                  subtitle: Text("\$${product.price}"),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.grey),
                    onPressed: () => removeItem(index),
                  ),
                );
              },
            ),
    );
  }
}
