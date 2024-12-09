// file: lib/screens/shared_preferences_helper.dart
// Author : Viren Pandya
// Description: The SharedPreferencesHelper class provides utility functions to save and retrieve order data using Flutter's SharedPreferences. 
//  It stores the orders as a JSON string and retrieves them as a list of maps for persistent data management.


// SharedPreferencesHelper.dart
import 'dart:convert'; // Needed for JSON encoding and decoding
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {
  static const _ordersKey = 'orders'; // Key for storing orders

  // Save orders to SharedPreferences
  static Future<void> saveOrders(List<Map<String, dynamic>> orders) async {
    final prefs = await SharedPreferences.getInstance();
    String ordersJson = jsonEncode(orders); // Convert orders list to JSON string
    await prefs.setString(_ordersKey, ordersJson); // Save JSON string
    print("Orders saved: $ordersJson");
  }

  // Get saved orders from SharedPreferences
  static Future<List<Map<String, dynamic>>> getOrders() async {
    final prefs = await SharedPreferences.getInstance();
    String? ordersJson = prefs.getString(_ordersKey); // Retrieve JSON string
    if (ordersJson != null) {
      print("Retrieved orders: $ordersJson"); 
      List<dynamic> ordersList = jsonDecode(ordersJson); // Decode JSON string
      return ordersList.map((order) => Map<String, dynamic>.from(order)).toList(); // Convert to List<Map<String, dynamic>>
    }
    return []; // Return empty list if no orders are found
  }
}