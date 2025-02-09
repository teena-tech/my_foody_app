import 'package:flutter/material.dart';
import 'authentication/login_screen.dart';
import 'home/home_screen.dart';
import 'home/cart_screen.dart';
import 'checkout/checkout_screen.dart';

class AppRoutes {
  static Map<String, WidgetBuilder> routes = {
    '/login': (context) => LoginScreen(),
    '/home': (context) => HomeScreen(),
    '/cart': (context) => CartScreen(),
    '/checkout': (context) => CheckoutScreen(
          firstName: '',
          lastName: '',
          address: '',
        ),
  };
}
