// file: lib/screens/cartscreen.dart
// Author : Ayush Patel
// Description: This will be cart page where user would be pay for the order and get oder confirmation number.
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:finalproject_7/models/products.dart';

class PaymentScreen extends StatelessWidget {
  final List<Product> cartItems;
  final double deliveryCharge = 5.0; 
  final VoidCallback resetQuantities;

  PaymentScreen({super.key, required this.cartItems, required this.resetQuantities});

  @override
  Widget build(BuildContext context) {
    final double totalAmount = cartItems.fold(0.0, (sum, item) => sum + item.price * item.quantity);
    final double finalAmount = totalAmount + deliveryCharge;

    final cardNumberController = TextEditingController();
    final expiryDateController = TextEditingController();
    final cvvController = TextEditingController();

    void confirmPayment() {
      final random = Random();
      final confirmationNumber = random.nextInt(999999).toString().padLeft(6, '0');
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Payment Successful', style: TextStyle(color: Colors.green)),
          content: Text('Your payment of \$${finalAmount.toStringAsFixed(2)} has been completed. '
              '\nConfirmation Number: $confirmationNumber'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(ctx).pop();
                Navigator.of(context).pop(); 
                Navigator.of(context).pop(); 
                resetQuantities();
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }

    void validateAndPay() {
      if (cardNumberController.text.isEmpty ||
          expiryDateController.text.isEmpty ||
          cvvController.text.isEmpty ||
          cardNumberController.text.length != 16 ||
          expiryDateController.text.length != 5 ||
          cvvController.text.length != 3) {
        showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: const Text('Invalid Details', style: TextStyle(color: Colors.red)),
            content: const Text('Please enter valid card details.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(ctx).pop();
                },
                child: const Text('OK'),
              ),
            ],
          ),
        );
      } else {
        confirmPayment();
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment Page'),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.orange, Colors.red],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Order Summary:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: cartItems.length,
                itemBuilder: (ctx, i) {
                  final product = cartItems[i];
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${product.title} (x${product.quantity})',
                          style: const TextStyle(fontSize: 16),
                        ),
                        Text(
                          '\$${(product.price * product.quantity).toStringAsFixed(2)}',
                          style: const TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            const Divider(thickness: 1),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Delivery Charges:',
                    style: TextStyle(fontSize: 16),
                  ),
                  Text(
                    '\$${deliveryCharge.toStringAsFixed(2)}',
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
            const Divider(thickness: 1),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Total Amount:',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '\$${finalAmount.toStringAsFixed(2)}',
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            const Text('Enter Card Details:', style: TextStyle(fontSize: 18)),
            TextField(
              controller: cardNumberController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Card Number (16 digits)'),
              maxLength: 16,
            ),
            TextField(
              controller: expiryDateController,
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(labelText: 'Expiry Date (MM/YY)'),
              maxLength: 5,
            ),
            TextField(
              controller: cvvController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'CVV (3 digits)'),
              maxLength: 3,
            ),
            const Spacer(),
            Center(
              child: ElevatedButton(
                onPressed: validateAndPay,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  backgroundColor: Colors.green,
                ),
                child: const Text(
                  'Pay Now',
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
