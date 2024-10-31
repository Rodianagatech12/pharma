import 'package:flutter/material.dart';

class CartProvider with ChangeNotifier {
  List<Map<String, dynamic>> cartItems = [];

  int get itemCount => cartItems.length;

  double get totalPrice => cartItems.fold(0,
      (sum, item) => sum + double.parse(item['price'].replaceAll(' LYD', '')));

  void addItem(Map<String, dynamic> medication) {
    cartItems.add(medication);
    notifyListeners();
  }

  void removeItem(Map<String, dynamic> item) {}
}
