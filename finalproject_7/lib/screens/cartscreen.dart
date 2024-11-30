// file: lib/screens/cartscreen.dart
// Author : Viren Pandya
// Description: This will be cart page where user would be able to add items and order!
import 'package:flutter/material.dart';
import 'package:finalproject_7/models/products.dart';

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
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Order Completed', style: TextStyle(color: Colors.deepOrange)),
          content: const Text('Thank you, your order is completed!', style: TextStyle(color: Colors.deepOrange)),
          backgroundColor: Colors.blueGrey,
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(ctx).pop();
                Navigator.of(context).pop(); // Go back to home screen
                resetQuantities();
              },
              child: const Text('Back to Home', style: TextStyle(color: Colors.deepOrange)),
            ),
          ],
        ),
      );
    }
  }

  void removeFromCart(Product product) {
    cartItems.remove(product);
  }

  @override
  Widget build(BuildContext context) {
    final double totalAmount = cartItems.fold(0.0, (sum, item) => sum + item.price * item.quantity);
    return Scaffold(
      backgroundColor: Colors.blueGrey[50],
      appBar: AppBar(
        title: const Text('Grab&GoGoods', style: TextStyle(color: Colors.red, fontSize: 28)),
        backgroundColor: Colors.blueGrey,
      ),
      body: Container(
        color: Colors.blueGrey,
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: cartItems.length,
                itemBuilder: (ctx, i) => Container(
                  color: Colors.blueGrey,
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.blueGrey,
                      child: Text('${cartItems[i].quantity}x', style: const TextStyle(color: Colors.deepOrange)),
                    ),
                    title: Text(cartItems[i].title, style: const TextStyle(color: Colors.deepOrange)),
                    subtitle: Text('\$${cartItems[i].price * cartItems[i].quantity}', style: const TextStyle(color: Colors.deepOrange)),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.deepOrange),
                      onPressed: () {
                        // Handle item removal
                        removeFromCart(cartItems[i]);
                        (context as Element).markNeedsBuild();
                      },
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total: \$${totalAmount.toStringAsFixed(2)}',
                    style: const TextStyle(fontSize: 20, color: Colors.deepOrange),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      textStyle: const TextStyle(fontSize: 20),
                      foregroundColor: Colors.black,
                    ),
                    onPressed: () => placeOrder(context),
                    child: const Text('Order Now', style: TextStyle(color: Colors.black)),
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
