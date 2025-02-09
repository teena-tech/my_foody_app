import 'package:flutter/material.dart';
import 'dish_card.dart';

class CategoryTab extends StatelessWidget {
  final Map<String, dynamic> category;

  CategoryTab({required this.category});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: category['dishes'].length,
      itemBuilder: (context, index) {
        return DishCard(dish: category['dishes'][index]);
      },
    );
  }
}
