import 'package:flutter/material.dart';
import 'dish_card.dart';

class CategoryCard extends StatelessWidget {
  final Map<String, dynamic> category;

  CategoryCard({required this.category});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            category['menu_category'],
            style: TextStyle(
                fontSize: 18, fontWeight: FontWeight.bold, color: Colors.red),
          ),
        ),
        Column(
          children: List.generate(category['category_dishes'].length, (index) {
            return DishCard(dish: category['category_dishes'][index]);
          }),
        ),
      ],
    );
  }
}
