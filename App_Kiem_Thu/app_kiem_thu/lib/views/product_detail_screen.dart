import 'package:app_kiem_thu/models/products.dart';
import 'package:app_kiem_thu/views/cart_screen.dart';
import 'package:app_kiem_thu/widgets/my_colors.dart';
import 'package:flutter/material.dart';

class ProductDetailScreen extends StatefulWidget {
  final Product productData;
  final String url;
  const ProductDetailScreen({super.key, required this.productData, required this.url});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {

  void addToCart(Product product) {
    bool found = false;
    for (var item in CartScreen.cartItems) {
      if (item.id == product.id) {
        item.quantity++; 
        found = true;
        break;
      }
    }
    if (!found) {
      product.quantity = 1;
      CartScreen.cartItems.add(product);
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CartScreen()),
                );
              },
              icon: Icon(Icons.shopping_cart_rounded, color: ShopeeColors.textGray, size: 30,),
            )
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 16, right: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(height: 200, width: 400, widget.url),
              const SizedBox(height: 20),
              Text("${widget.productData.title}", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              Text("Price: ${widget.productData.price}\$", style: TextStyle(fontSize: 18, color: Colors.teal)),
              const SizedBox(height: 10),
              Text("Rating: ${widget.productData.rating}", style: TextStyle(fontSize: 16)),
              const SizedBox(height: 20),
              Text("Description:", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              Text("${widget.productData.description}", style: TextStyle(fontSize: 16, color: Colors.grey)),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: 80,
        decoration: BoxDecoration(color: ShopeeColors.textGray),
        child: Row(
          children: [
            Container(
              width: 200,
              height: 80,
              color: Colors.teal,
              child: IconButton(
                onPressed: () {
                  addToCart(widget.productData);

                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text("Thông báo"),
                      content: Text("${widget.productData.title} đã được thêm vào giỏ hàng!"),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text("OK"),
                        ),
                      ],
                    ),
                  );
                },
                icon: Icon(Icons.shopping_cart_sharp, size: 30, color: Colors.white),
              ),
            ),
            Expanded(
              child: Container(
                color: ShopeeColors.primary,
                child: Center(
                  child: Text("${widget.productData.price}\$", style: const TextStyle(fontSize: 30, color: Colors.white, fontWeight: FontWeight.bold)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
