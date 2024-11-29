//file: lib/screen/cartscreen.dart
//Author : Viren Pandya
//Description: This will be cart page where user would be able to add items and order!
import 'package:finalproject_7/models/products.dart';
import 'package:flutter/material.dart';

class CartScreen extends StatelessWidget {
  final List<Product> cartItems;

  CartScreen({required this.cartItems});

  void placeOrder(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Order Completed'),
        content: Text('Thank you, your order is completed!'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
              Navigator.of(context).pop(); // Go back to home screen
            },
            child: Text('Back to Home'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final double totalAmount = cartItems.fold(0.0, (sum, item) => sum + item.price * item.quantity);
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Cart'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: cartItems.length,
              itemBuilder: (ctx, i) => ListTile(
                leading: CircleAvatar(
                  child: Text('${cartItems[i].quantity}x'),
                ),
                title: Text(cartItems[i].title),
                subtitle: Text('\$${cartItems[i].price * cartItems[i].quantity}'),
                trailing: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    // Handle item removal
                  },
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
                  style: TextStyle(fontSize: 20),
                ),
                ElevatedButton(
                  onPressed: () => placeOrder(context),
                  child: Text('Order Now'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
