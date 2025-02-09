import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:online_swissy/home/cart_provider.dart';
import 'package:online_swissy/home/home_screen.dart';
import 'package:provider/provider.dart';

class CheckoutScreen extends StatelessWidget {
  final String firstName;
  final String lastName;
  final String address;

  const CheckoutScreen({
    Key? key,
    required this.firstName,
    required this.lastName,
    required this.address,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context, listen: false);

    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: const Text("Checkout"),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "!!Thank You Using Food App Please Purchase Again!!",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text("Name: $firstName $lastName",
                style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 5),
            Text("Address: $address", style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  cart.clearCart(); //
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text("Order Successfully Placed"),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context); // Close dialog
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomeScreen()),
                              (route) => false, // Remove
                            );
                          },
                          child: const Text("OK"),
                        ),
                      ],
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding:
                      const EdgeInsets.symmetric(vertical: 16, horizontal: 40),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text("Place Order"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
