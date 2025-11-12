import 'package:app_kiem_thu/widgets/my_colors.dart';
import 'package:flutter/material.dart';

class MyContainerTextfiled extends StatelessWidget {
  const MyContainerTextfiled({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: ShopeeColors.white,
        ),
        child: const TextField(
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: "Search product",
            prefixIcon: Icon(Icons.search),
          ),
        ),
      ),
    );
  }
}
