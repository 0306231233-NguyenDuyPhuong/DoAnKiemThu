import 'package:app_kiem_thu/widgets/my_colors.dart';
import 'package:flutter/material.dart';
class MyContainerTextfiled extends StatelessWidget {
  const MyContainerTextfiled({super.key, required this.width});
  final double width;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      padding: EdgeInsets.all(0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: ShopeeColors.white
      ),
      child: TextField(
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: "Search proudct",
          prefixIcon: Icon(Icons.search)
        )
      ),
    );
  }
}
