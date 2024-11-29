import 'package:flutter/material.dart';
import 'package:finalproject_7/screens/cartscreen.dart';
import 'package:finalproject_7/screens/homescreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Shop App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Homescreen(),
      routes: {
        '/home' : (context) => Homescreen(),
        '/cart' : (context) => CartScreen(cartItems: [],),
      },
    );
  }
}

