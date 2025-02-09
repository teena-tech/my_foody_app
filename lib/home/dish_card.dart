import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../home/cart_provider.dart';

class DishCard extends StatelessWidget {
  final Map<String, dynamic> dish;

  DishCard({required this.dish});

  @override
  Widget build(BuildContext context) {
    return Consumer<CartProvider>(
      builder: (context, cart, child) {
        int quantity = cart.cart[dish['name']]?['quantity'] ?? 0;
        String imageUrl = dish['image_url'] ?? "";

        return Card(
          elevation: 3,
          margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        height: 70,
                        width: 12,
                        margin: EdgeInsets.only(top: 2),
                        decoration: BoxDecoration(
                          color:
                              dish['isVeg'] == true ? Colors.green : Colors.red,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                    SizedBox(width: 8),

                    // Dish Details
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Dish Name
                          Text(
                            dish['name'] ?? "Unknown Dish",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: 5),

                          // Price & Calories
                          Row(
                            children: [
                              Text(
                                "INR ${dish['price'] ?? "0.00"}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green,
                                ),
                              ),
                              Spacer(),
                              Text(
                                "${dish['calories'] ?? "N/A"} calories",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 5),

                          // Description
                          Text(
                            dish['description'] ?? "No description available.",
                            style: TextStyle(fontSize: 12, color: Colors.grey),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          ),
                          SizedBox(height: 5),

                          if (dish['customizations_available'] == true)
                            Text(
                              "Customizations Available",
                              style: TextStyle(fontSize: 12, color: Colors.red),
                            ),
                        ],
                      ),
                    ),

                    SizedBox(width: 10),

                    // Dish Image
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: imageUrl.isNotEmpty && imageUrl.startsWith("http")
                          ? Image.network(
                              imageUrl,
                              height: 80,
                              width: 80,
                              fit: BoxFit.cover,
                              loadingBuilder:
                                  (context, child, loadingProgress) {
                                if (loadingProgress == null) return child;
                                return Center(
                                    child: CircularProgressIndicator());
                              },
                              errorBuilder: (context, error, stackTrace) {
                                return _placeholderImage();
                              },
                            )
                          : _placeholderImage(),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        IconButton(
                          icon: Icon(Icons.remove_circle, color: Colors.red),
                          onPressed: () {
                            if (quantity > 0) {
                              cart.removeItem(dish['name']);
                            }
                          },
                        ),
                        Text(
                          quantity.toString(),
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.add_circle, color: Colors.green),
                          onPressed: () {
                            cart.addItem(
                              dish['name'],
                              double.tryParse(dish['price'].toString()) ?? 0.0,
                            );
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _placeholderImage() {
    return Container(
      height: 80,
      width: 80,
      color: Colors.grey[300],
      child: Icon(Icons.fastfood_rounded, size: 40, color: Colors.grey),
    );
  }
}
