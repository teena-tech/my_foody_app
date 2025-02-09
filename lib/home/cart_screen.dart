import 'package:flutter/material.dart';
import 'package:online_swissy/checkout/DeliveryScreen/DeliveryScreen.dart';
import 'package:online_swissy/delieverydetails/delievery_screen.dart';
import 'package:online_swissy/home/cart_provider.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Order Summary",
          style: TextStyle(color: Colors.grey[800]),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.grey[800]),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: Colors.white,
        elevation: 1,
      ),
      body: cart.cart.isEmpty
          ? Center(
              child: Text(
                "Your cart is empty",
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            )
          : Column(
              children: [
                // Header Section
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(16),
                  color: Colors.green[800],
                  child: Center(
                    child: Text(
                      "${cart.cart.length} Dishes - ${cart.totalItems} Items",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                // Cart Items List
                Expanded(
                  child: ListView.builder(
                    itemCount: cart.cart.length,
                    itemBuilder: (context, index) {
                      String dish = cart.cart.keys.elementAt(index);
                      final item = cart.cart[dish]!;
                      return Container(
                        margin:
                            EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.shade300,
                              blurRadius: 5,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                // Side Dot
                                Container(
                                  height: 10,
                                  width: 10,
                                  margin: EdgeInsets.only(right: 8),
                                  decoration: BoxDecoration(
                                    color: index % 2 == 0
                                        ? Colors.green
                                        : Colors
                                            .red, // Green for veg, Red for non-veg
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                // Dish Info
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        dish,
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(height: 4),
                                      Text(
                                        "INR ${item['price'].toStringAsFixed(2)}",
                                        style: TextStyle(
                                          color: Colors.green,
                                          fontSize: 14,
                                        ),
                                      ),
                                      SizedBox(height: 4),
                                      Text(
                                        "${item['calories']} calories",
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                // Quantity Selector
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    // Decrease Button
                                    Container(
                                      height: 32,
                                      width: 32,
                                      decoration: BoxDecoration(
                                        color: Colors.green[800],
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: IconButton(
                                        icon: Icon(
                                          Icons.remove,
                                          color: Colors.white,
                                          size: 18,
                                        ),
                                        onPressed: () => cart.removeItem(dish),
                                        padding: EdgeInsets.zero,
                                      ),
                                    ),
                                    // Quantity Text
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0),
                                      child: Text(
                                        item['quantity'].toString(),
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    // Increase Button
                                    Container(
                                      height: 32,
                                      width: 32,
                                      decoration: BoxDecoration(
                                        color: Colors.green[800],
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: IconButton(
                                        icon: Icon(
                                          Icons.add,
                                          color: Colors.white,
                                          size: 18,
                                        ),
                                        onPressed: () =>
                                            cart.addItem(dish, item['price']),
                                        padding: EdgeInsets.zero,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                // Total Amount Section
                Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(color: Colors.grey.shade300),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Total Amount",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "INR ${cart.totalAmount.toStringAsFixed(2)}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.green[800],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green[800],
                          padding: EdgeInsets.symmetric(
                              vertical: 16, horizontal: 32),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onPressed: () {
                          // Navigate to DeliveryDetailScreen
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DeliveryDetailsScreen(),
                            ),
                          );
                        },
                        child: Text(
                          "Place Order",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
