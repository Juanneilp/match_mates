import 'package:flutter/material.dart';

class CategoryChip extends StatelessWidget {
  final String category;
  final String color;
  const CategoryChip({Key? key, required this.category, required this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 8),
      child: Chip(
        label: Text(
          category,
          style: const TextStyle(fontSize: 15),
        ),
        backgroundColor: Color(int.parse(color, radix: 16)),
      ),
    );
  }
}
