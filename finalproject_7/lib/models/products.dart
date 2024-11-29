//file: lib/models/cart.dart
//Author : Viren Pandya
//Description: this will hold the data of product

class Product {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  int quantity;

  Product({
    required this.description,
    required this.id,
    required this.title,
    required this.price,
    required this.imageUrl,
    this.quantity = 0,
  });
}