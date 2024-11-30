//file: lib/screen/homescreen.dart
//Author : Viren Pandya
//Description: This will be homescreen and first screen which shows up as app is opened!
import 'package:finalproject_7/screens/cartscreen.dart';
import 'package:flutter/material.dart';
import 'package:finalproject_7/models/products.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

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
      final existingProduct = cartItems.firstWhere((element) => element.id == product.id, orElse: () => Product(description: '', id: '', title: '', price: 0, imageUrl: ''));
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
      final existingProduct = cartItems.firstWhere((element) => element.id == product.id, orElse: () => Product(description: '', id: '', title: '', price: 0, imageUrl: ''));
      if (existingProduct.id.isNotEmpty) {
        existingProduct.quantity--;
        if (existingProduct.quantity == 0) {
          cartItems.remove(existingProduct);
        }
      }
    });
  }
  void resetProductQuantities() {
    setState(() {
      for (var product in cartItems) {
        product.quantity = 0;
      }
      cartItems.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      appBar: AppBar(
        title: const Text('Grab&GoGoods',style: TextStyle(color: Colors.red, fontSize: 28, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.blueGrey,
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => CartScreen(cartItems: cartItems, resetQuantities: resetProductQuantities),
              ));
            },
          ),
        ],
      ),
      body: Container(
        color: Colors.blueGrey,
        child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            DecoratedBox(decoration: BoxDecoration(color: Colors.blueGrey),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: const Text(
                  'Available Products',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.deepOrange),
                ),
              ),
            ),
            
            Expanded(
              child: ListView.builder(
                itemCount: product.length,
                itemBuilder: (ctx, i) => Container(
                  color: Colors.blueGrey,
                  child: ListTile(
                    leading:  Image.network(product[i].imageUrl),
                    title: Text(product[i].title, style: const TextStyle(color: Colors.deepOrange),),
                    subtitle: Text('\$${product[i].price}', style: const TextStyle(color: Colors.deepOrange),),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(onPressed: (){removeFromCart(product[i]);}, icon: const Icon(Icons.remove, color: Colors.deepOrange,)),
                        Text('${product[i].quantity}', style: const TextStyle(color: Colors.deepOrange),),
                        IconButton(onPressed: () {addToCart(product[i]);}, icon: const Icon(Icons.add, color: Colors.deepOrange,)),
                      ],
                    ),
                  ),
              ),
            ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 60.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  textStyle: const TextStyle(fontSize: 20),
                  foregroundColor: Colors.black,
                ),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => CartScreen(cartItems: cartItems, resetQuantities: resetProductQuantities,),
                ));
              },
              child: const Text('ADD TO CART'),
              ),
            ),
          ],
        ),
      ),
      )
      
    );
  }
}