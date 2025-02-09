import 'package:flutter/material.dart';

class CartProvider with ChangeNotifier {
  final Map<String, Map<String, dynamic>> _cart = {};

  Map<String, Map<String, dynamic>> get cart => _cart;

  int get totalItems {
    return _cart.values.fold(0, (sum, item) => sum + (item['quantity'] as int));
  }

  double get totalAmount {
    return _cart.values.fold(
      0.0,
      (sum, item) =>
          sum + (item['quantity'] as int) * (item['price'] as double),
    );
  }

  void addItem(String dish, double price) {
    if (_cart.containsKey(dish)) {
      _cart[dish]!['quantity'] = (_cart[dish]!['quantity'] as int) + 1;
    } else {
      _cart[dish] = {'price': price, 'quantity': 1};
    }
    notifyListeners();
  }

  void removeItem(String dish) {
    if (_cart.containsKey(dish)) {
      if (_cart[dish]!['quantity'] > 1) {
        _cart[dish]!['quantity'] = (_cart[dish]!['quantity'] as int) - 1;
      } else {
        _cart.remove(dish);
      }
      notifyListeners();
    }
  }

  void clearCart() {
    _cart.clear();
    notifyListeners(); // Notify UI to update
  }
}
