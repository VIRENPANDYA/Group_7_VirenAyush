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

  // Convert Product to Map (for saving to SharedPreferences)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'price': price,
      'imageUrl': imageUrl,
      'quantity': quantity,
    };
  }

  // Create Product from Map (for loading from SharedPreferences)
  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      price: map['price'],
      imageUrl: map['imageUrl'],
      quantity: map['quantity'],
    );
  }

}