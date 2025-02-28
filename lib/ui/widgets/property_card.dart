import 'package:flutter/material.dart';
import 'package:online_swissy/data/models/property_model.dart';

class PropertyCard extends StatelessWidget {
  final PropertyModel property;

  const PropertyCard({Key? key, required this.property}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
            child: Image.network(
              property.imageUrl,
              height: 120,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(property.title,
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                SizedBox(height: 4),
                // Text("₹ ${propety.price}",
                //     style: TextStyle(
                //         fontSize: 14,
                //         fontWeight: FontWeight.bold,
                //
                //
                //         color: Colors.orange)),
                Text("₹ ${property.price}",
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.orange)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
