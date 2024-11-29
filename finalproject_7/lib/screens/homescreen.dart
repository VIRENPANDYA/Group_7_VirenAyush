//file: lib/screen/homescreen.dart
//Author : Viren Pandya
//Description: This will be homescreen and first screen which shows up as app is opened!
import 'package:finalproject_7/screens/cartscreen.dart';
import 'package:flutter/material.dart';
import 'package:finalproject_7/models/products.dart';

class Homescreen extends StatefulWidget {
  @override
  HomescreenState createState() => HomescreenState();
}

class HomescreenState extends State<Homescreen>{
  //try and testing by adding some products here!
  final List<Product> product = [
    Product(
      id: 'p1',
      title: 'Milk',
      description: '3.25% Homogenized Milk, 4L Bag',
      price: 8.0,
      imageUrl: 'https://pixabay.com/illustrations/milk-milk-carton-milk-box-dairy-7228322/',
    ),
    Product(
      id: 'p2',
      title: 'Bread',
      description: 'Whole Wheat Bread, 675g',
      price: 2.49,
      imageUrl: 'https://pixabay.com/photos/bread-loaf-artisan-artisan-bread-1510155/',

    ),
    Product(
      id: 'p3',
      title: 'Eggs',
      description: 'Large White Eggs, 18 count',
      price: 6.88,
      imageUrl: '',
    ),
    Product(
      id: 'p4',
      title: 'Butter',
      description: 'Salted Butter, 1lb',
      price: 4.87,
      imageUrl: '',
    ),
    Product(
      id: 'p5',
      title: 'Paneer',
      description: 'Malai Paneer, 375g',
      price: 5.97,
      imageUrl: '',
    ),
  ];
  final List<Product> cartItems = [];
  void addToCart(Product product) {
    setState(() {
      final existingProduct = cartItems.firstWhere((element) => element.id == product.id, orElse: () => Product(description: '', id: '', title: '', price: 0, imageUrl: ''));
      if (existingProduct.id.isNotEmpty) {
        existingProduct.quantity++;
      } else {
        product.quantity = 1;
        cartItems.add(product);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('My Shop App'),
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => CartScreen(cartItems: cartItems),
              ));
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: product.length,
        itemBuilder: (ctx, i) => ListTile(
          leading: Image.network(product[i].imageUrl),
          title: Text(product[i].title),
          subtitle: Text('\$${product[i].price}'),
          trailing: IconButton(
            icon: Icon(Icons.add_shopping_cart),
            onPressed: () {
              addToCart(product[i]);
            },
          ),
        ),
      ),
    );
  }
}