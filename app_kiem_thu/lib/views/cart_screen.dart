import 'package:app_kiem_thu/models/products.dart';
import 'package:app_kiem_thu/widgets/my_colors.dart';
import 'package:flutter/material.dart';

class CartScreen extends StatefulWidget {
  static List<Product> cartItems = [];

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  double totalPrice() {
    double total = 0;
    for (var item in CartScreen.cartItems) {
      total += item.price * item.quantity;
    }
    return total;
  }

  void checkout() {
    if (CartScreen.cartItems.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Giỏ hàng đang trống!")),
      );
      return;
    }

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Thanh toán"),
        content: Text(
            "Tổng thanh toán: ${totalPrice().toStringAsFixed(2)}\$\nThanh toán thành công!"),
        actions: [
          TextButton(
            onPressed: () {
              setState(() {
                CartScreen.cartItems.clear();
              });
              Navigator.pop(context);
            },
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ShopeeColors.primary,
        title: Text("Giỏ Hàng",
            style: TextStyle(fontSize: 30, color: ShopeeColors.textDark)),
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: CartScreen.cartItems.length,
        itemBuilder: (context, index) {
          final item = CartScreen.cartItems[index];
          return Container(
            margin: const EdgeInsets.symmetric(vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: Colors.black, width: 2),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  blurRadius: 4,
                  offset: const Offset(2, 4),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                        item.images.isNotEmpty ? item.images[0] : '',
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(item.title,
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis),
                        const SizedBox(height: 8),
                        Text("${item.price}\$",
                            style: const TextStyle(
                                fontSize: 16,
                                color: Colors.teal,
                                fontWeight: FontWeight.w600)),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            IconButton(
                                icon: const Icon(Icons.remove_circle_outline),
                                onPressed: () {
                                  setState(() {
                                    if (item.quantity > 1) {
                                      item.quantity--;
                                    } else {
                                      CartScreen.cartItems.removeAt(index);
                                    }
                                  });
                                }),
                            Text("${item.quantity}",
                                style: const TextStyle(fontSize: 18)),
                            IconButton(
                                icon: const Icon(Icons.add_circle_outline),
                                onPressed: () {
                                  setState(() {
                                    item.quantity++;
                                  });
                                }),
                          ],
                        ),
                        Text(
                          "Tổng: ${(item.price * item.quantity).toStringAsFixed(2)}\$",
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red, size: 30),
                      onPressed: () {
                        setState(() {
                          CartScreen.cartItems.removeAt(index);
                        });
                      }),
                ],
              ),
            ),
          );
        },
      ),


      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        color: ShopeeColors.primary,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Tổng cộng: ${totalPrice().toStringAsFixed(2)}\$",
                style: const TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold)),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                padding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                textStyle:
                const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              onPressed: checkout,
              child: const Text("Thanh toán",style: TextStyle(color: ShopeeColors.white),),
            ),
          ],
        ),
      ),
    );
  }
}
