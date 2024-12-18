// file: lib/screens/cartscreen.dart
// Author : Viren Pandya
// Description: This will be the cart page where user would be able to add items and order!
import 'package:finalproject_7/screens/PaymentScreen.dart';
import 'package:flutter/material.dart';
import 'package:finalproject_7/models/products.dart';
import 'package:finalproject_7/screens/homescreen.dart';

class CartScreen extends StatelessWidget {
  final List<Product> cartItems;
  final VoidCallback resetQuantities;

  const CartScreen({super.key, required this.cartItems, required this.resetQuantities});

  void placeOrder(BuildContext context) {
    if (cartItems.isEmpty) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Oops!', style: TextStyle(color: Colors.deepOrange)),
          content: const Text('Your cart seems to be empty!', style: TextStyle(color: Colors.deepOrange)),
          backgroundColor: Colors.blueGrey,
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(ctx).pop();
              },
              child: const Text('Ok', style: TextStyle(color: Colors.deepOrange)),
            ),
          ],
        ),
      );
    } else {
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => PaymentScreen(
          cartItems: cartItems,
          resetQuantities: resetQuantities,
        ),
      ));
    }
  }

  void removeFromCart(Product product) {
    cartItems.remove(product);
  }
  @override
  Widget build(BuildContext context) {
    final double totalAmount = cartItems.fold(0.0, (sum, item) => sum + item.price * item.quantity);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back), //back button
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Grab&GoGoods',
          style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.orange, Colors.red],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart, color: Colors.white),
            onPressed: () {
              // Navigate to CartScreen
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => CartScreen(cartItems: cartItems, resetQuantities: resetQuantities),
              ));
            },
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blueGrey, Colors.black87],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          children: [
            // If cart is empty, show message and button
            if (cartItems.isEmpty) 
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Once you add products, your cart will appear here',
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                      const SizedBox(height: 20),
                      TextButton(
                        onPressed: () {
                          // Navigate back to HomeScreen
                          Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => const Homescreen()),
                          );
                        },
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.orange,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                        ),
                        child: const Text(
                          'Start Shopping',
                          style: TextStyle(color: Colors.black, fontSize: 18),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            else
              Expanded(
                child: ListView.builder(
                  itemCount: cartItems.length,
                  itemBuilder: (ctx, i) => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      elevation: 5,
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.orange,
                          child: Text(
                            '${cartItems[i].quantity}x',
                            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                          ),
                        ),
                        title: Text(
                          cartItems[i].title,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(
                          '\$${(cartItems[i].price * cartItems[i].quantity).toStringAsFixed(2)}',
                        ),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            removeFromCart(cartItems[i]);
                            (context as Element).markNeedsBuild();
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            // Display the total and "Order Now" button when cart is not empty
            if (cartItems.isNotEmpty)
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total: \$${totalAmount.toStringAsFixed(2)}',
                      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        backgroundColor: Colors.red,
                      ),
                      onPressed: () => placeOrder(context),
                      child: const Text(
                        'Order Now',
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
