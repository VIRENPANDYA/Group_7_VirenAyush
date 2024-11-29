//file: lib/models/cart.dart
//Author : Viren Pandya
//Description: this class would be handling the cart operations
class Cart {
  final String id;
  final String title;
  final double price;
  int quantity;
  
  Cart({
    required this.id,
    required this.title,
    required this.price,
    this.quantity = 1,
  });
}