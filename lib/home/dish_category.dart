import 'package:flutter/material.dart';

class DishCategory extends StatelessWidget {
  final String name;

  DishCategory({required this.name});

  @override
  Widget build(BuildContext context) {
    return ListTile(
        title: Text(name,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)));
  }
}
