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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            IconButton(onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>CartScreen()));
            } , icon: Icon(Icons.shopping_cart_rounded, color: ShopeeColors.textGray, size: 30,))
          ],
        ),
      ),
      body: SingleChildScrollView(
        child:Padding(
          padding: const EdgeInsets.only(left: 16, right: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(height: 200, width: 400,widget.url),
              const SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("${widget.productData.price}đ", style: TextStyle(fontSize: 20, color: ShopeeColors.primary, fontWeight: FontWeight.bold),),
                  Row(
                    children: [
                      Text("${widget.productData.rating}", style: TextStyle(fontSize: 20, color: ShopeeColors.textDark, fontWeight: FontWeight.bold),),
                      Icon(Icons.star_rounded, color: Colors.yellow, size: 20,)
                    ],
                  )
                ],
              ),
              const SizedBox(height: 20,),
              Text("${widget.productData.title}", style: TextStyle(fontSize: 20, color: ShopeeColors.textDark, fontWeight: FontWeight.bold),),
              const SizedBox(height: 20,),

              Text("Description:", style: TextStyle(fontSize: 20, color: ShopeeColors.textDark, fontWeight: FontWeight.bold),),
              const SizedBox(height: 10,),
              Text("${widget.productData.description}", style: TextStyle(fontSize: 20, color: Colors.grey, fontWeight: FontWeight.bold),),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: 80,
        decoration: BoxDecoration(
          color: ShopeeColors.textGray
        ),
        child: Row(
          children: [
            Container(
              width: 200,
              height: 80,
              decoration: BoxDecoration(
                color: Colors.teal
              ),
              child: IconButton(onPressed: (){
                showDialog(context: context, builder: (context)=>
                    AlertDialog(
                      title: Text("Thông báo"),
                      content: Text("Thêm sản phẩm thành công"),
                    )
                );
              }, icon: Icon(Icons.shopping_cart_sharp, size: 30, color: Colors.white,)),
            ),

            Container(
              width: 225,
              decoration: BoxDecoration(
                color: ShopeeColors.primary
              ),
              child: Center(
                child: Text("${widget.productData.price}đ", style:const TextStyle(fontSize: 30, color: ShopeeColors.white, fontWeight: FontWeight.bold),),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

