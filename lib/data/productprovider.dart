import 'package:flutter/material.dart';

class ProductProvider with ChangeNotifier {
  List products = [];

  void updateProducts(List newProducts) {
    products = newProducts;
    notifyListeners();
  }

  void resetProducts() {
    products = [];
    notifyListeners();
  }

  void sortAsc() {
    products.sort((a, b) => a['price'].compareTo(b['price']));
    notifyListeners();
  }

  void sortDsc() {
    products.sort((a, b) => b['price'].compareTo(a['price']));
    notifyListeners();
  }
}
