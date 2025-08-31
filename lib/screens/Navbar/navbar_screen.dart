import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:product_api/services/product_screen.dart';
import 'package:product_api/screens/Navbar/image_screen.dart';
import 'package:product_api/screens/Navbar/location_screen.dart';
import 'package:product_api/screens/Navbar/profile_screen.dart';
import 'package:product_api/model/api_product_model.dart';
import 'package:product_api/widgets/cartscreen/CartPage.dart';

class BottomnavScreen extends StatefulWidget {
  const BottomnavScreen({super.key});

  @override
  State<BottomnavScreen> createState() => _BottomnavScreenState();
}

class _BottomnavScreenState extends State<BottomnavScreen> {
  int currentIndex = 0;
  List<Product> cart = [];

  late List<Widget> pages;
  final List<String> titles = ["Home", "Location", "Pictures", "Profile"];

  @override 
  void initState() {
    super.initState();
    pages = [
      HomeScreen(cart: cart, onAddToCart: addToCart),
      const LocationButton(),
      const ImagesButton(),
      const ProfileButton(),
    ];
  }

  void addToCart(Product product) {
    setState(() {
      cart.add(product);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text(titles[currentIndex])),
        actions: [
          if (currentIndex == 0)
            IconButton(
              icon: Stack(
                children: [
                  const Icon(Icons.shopping_cart_checkout_sharp),
                  if (cart.isNotEmpty)
                    Positioned(
                      right: 0,
                      child: CircleAvatar(
                        radius: 8,
                        backgroundColor: Colors.red,
                        child: Text("${cart.length}", style: const TextStyle(fontSize: 12, color: Colors.white)),
                      ),
                    ),
                ],
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CartPage(cart: List.from(cart), onCartUpdated: (updatedCart) {
                      setState(() {
                        cart = updatedCart;
                      });
                    }),
                  ),
                );
              },
            ),
        ],
      ),
      body: IndexedStack(index: currentIndex, children: pages),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.black12,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        currentIndex: currentIndex,
        onTap: (value) => setState(() => currentIndex = value),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.house), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.location_on), label: "Location"),
          BottomNavigationBarItem(icon: Icon(Icons.photo_camera), label: "Picture"),
          BottomNavigationBarItem(icon: Icon(CupertinoIcons.person), label: "Profile"),
        ],
      ),
    );
  }
}
