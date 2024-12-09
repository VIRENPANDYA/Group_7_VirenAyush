// file: lib/screens/cartscreen.dart
// Author : Viren Pandya
// Description: This will be cart page where user would be able to add items and order!
import 'package:finalproject_7/screens/ordersscreen.dart';
import 'package:flutter/material.dart';
import 'package:finalproject_7/screens/cartscreen.dart';
import 'package:finalproject_7/models/products.dart';
//new added features by me on 6th december
import 'package:finalproject_7/screens/PaymentScreen.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  HomescreenState createState() => HomescreenState();
}

class HomescreenState extends State<Homescreen> with SingleTickerProviderStateMixin {
  int selectedIndex = 0;
  final List<Product> product = [
    Product(
      id: 'p1',
      title: 'Milk',
      description: '3.25% Homogenized Milk, 4L Bag',
      price: 8.0,
      imageUrl: 'https://cdn.pixabay.com/photo/2022/05/29/03/25/milk-7228322_1280.jpg',
    ),
    Product(
      id: 'p2',
      title: 'Bread',
      description: 'Whole Wheat Bread, 675g',
      price: 2.49,
      imageUrl: 'https://cdn.pixabay.com/photo/2018/02/26/02/43/bread-3182199_960_720.png',
    ),
    Product(
      id: 'p3',
      title: 'Eggs',
      description: 'Large White Eggs, 18 count',
      price: 6.88,
      imageUrl: 'https://cdn.pixabay.com/photo/2016/07/08/18/18/egg-1504992_960_720.png',
    ),
    Product(
      id: 'p4',
      title: 'Butter',
      description: 'Salted Butter, 1lb',
      price: 4.87,
      imageUrl: 'https://cdn.pixabay.com/photo/2021/09/06/00/19/butter-6600552_1280.png',
    ),
    Product(
      id: 'p5',
      title: 'Cheese',
      description: 'Indian cheese, 375g',
      price: 5.97,
      imageUrl: 'https://cdn.pixabay.com/photo/2023/03/12/13/59/cheese-7846988_1280.png',
    ),
  ];

  final List<Product> cartItems = [];

  void addToCart(Product product) {
    setState(() {
      final existingProduct = cartItems.firstWhere(
        (element) => element.id == product.id,
        orElse: () => Product(description: '', id: '', title: '', price: 0, imageUrl: ''),
      );
      if (existingProduct.id.isNotEmpty) {
        existingProduct.quantity++;
      } else {
        product.quantity = 1;
        cartItems.add(product);
      }
    });
  }

  void removeFromCart(Product product) {
    setState(() {
      final existingProduct = cartItems.firstWhere(
        (element) => element.id == product.id,
        orElse: () => Product(description: '', id: '', title: '', price: 0, imageUrl: ''),
      );
      if (existingProduct.id.isNotEmpty) {
        existingProduct.quantity--;
        if (existingProduct.quantity == 0) {
          cartItems.remove(existingProduct);
        }
      }
    });
  }

  //handling nav tab here
  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
    if (index == 1) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => CartScreen(cartItems: cartItems, resetQuantities: (){}),
        ),
      );
    } else if (index == 2) {
      Navigator.of(context).push(MaterialPageRoute(builder: (context) => PaymentScreen(cartItems: cartItems, resetQuantities: (){},)));

    }
  }
  //this will update the cart if any changes made in cart scree and refelct on home screen
  void updateCartItems(List<Product> updatedCartItems) {
    setState(() {
      cartItems.clear();
      cartItems.addAll(updatedCartItems);
    });
  }

  // Method to navigate to the Cart screen when the "Add to Cart" button is pressed
  void navigateToCartScreen() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => CartScreen(cartItems: cartItems, resetQuantities: () {}),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
  appBar: AppBar(
    title: const Text(
      'Grab&GoGoods',
      style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
      
    ),
    actions: [
      IconButton(
        icon: const Icon(Icons.shopping_cart),
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => CartScreen(cartItems: cartItems, resetQuantities: (){}),
          ));
        },
      ),
    ],
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
    body: Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.blueGrey, Colors.black87],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Available Products',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: product.length,
              itemBuilder: (ctx, i) {
                return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        elevation: 5,
                        child: ListTile(
                          leading: Hero(
                            tag: product[i].id,
                            child: Image.network(product[i].imageUrl),
                          ),
                          title: Text(
                            product[i].title,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text('\$${product[i].price.toStringAsFixed(2)}'),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                onPressed: () {
                                  removeFromCart(product[i]);
                                },
                                icon: const Icon(Icons.remove),
                                color: Colors.red,
                              ),
                              Text(
                                '${product[i].quantity}',
                                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              IconButton(
                                onPressed: () {
                                  addToCart(product[i]);
                                },
                                icon: const Icon(Icons.add),
                                color: Colors.green,
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
              },
            ),
          ),
          // "Add to Cart" Button below ListView, above BottomNavigationBar
             Padding(
              padding: const EdgeInsets.all(16.0),
              child: SizedBox(
                width: double.infinity, // To make it span the width
                child: TextButton(
                  onPressed: navigateToCartScreen, // Navigate to Cart screen
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.orange,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30), // Rounded button
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: const Text(
                    'Go to Cart',
                    style: TextStyle(color: Colors.black, fontSize: 18),
                  ),
                ),
              ),
            ),
        ],
      ),
    ),
    bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0, // Set to Payment screen
        onTap: (index) {
          if (index == 0) {
            Navigator.push(
                context, MaterialPageRoute(builder: (_) => Homescreen()));
          } else if (index == 1) {
            Navigator.push(
                context, MaterialPageRoute(builder: (_) => Ordersscreen()));
          } else if (index == 2) {
            Navigator.push(
              context, MaterialPageRoute(builder: (_) => CartScreen(cartItems: [], resetQuantities: () {} ))
            );
          }
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Orders',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.payment),
            label: 'Payment',
          ),
        ],
      ),
    );

  }
}
