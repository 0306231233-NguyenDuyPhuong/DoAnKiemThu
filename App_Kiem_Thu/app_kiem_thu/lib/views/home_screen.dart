import 'package:app_kiem_thu/viewmodels/product_viewmodels.dart';
import 'package:app_kiem_thu/views/cart_screen.dart';
import 'package:app_kiem_thu/views/product_detail_screen.dart';
import 'package:app_kiem_thu/views/user_screen.dart';
import 'package:app_kiem_thu/widgets/my_colors.dart';
import 'package:app_kiem_thu/widgets/my_container_textfiled.dart';
import 'package:flutter/material.dart';

import '../models/products.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<Product>> fetchProduct;
  final ProductViewModel productViewModel = ProductViewModel();


  Future<List<Product>> loadProduct(){
    return productViewModel.getAllProduct();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchProduct = loadProduct();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize:Size.fromHeight(80),
        child: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: ShopeeColors.primary,
          title: Row(
            children: [
              MyContainerTextfiled(width: 340,),
              IconButton(onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>CartScreen()));
              }, icon: Icon(Icons.shopping_cart, size: 30, color: Colors.white,))
            ],
          ),
        ),
      ),
      body:FutureBuilder(future: fetchProduct, builder: (context, snapshot){
        switch(snapshot.connectionState) {
          case ConnectionState.none:
            // TODO: Handle this case.
            throw UnimplementedError();
          case ConnectionState.waiting:
            return Center(
              child: CircularProgressIndicator(),
            );
          case ConnectionState.active:
            // TODO: Handle this case.
            throw UnimplementedError();
          case ConnectionState.done:
            if(snapshot.hasError){
              return Center(child: Text("${snapshot.error}"),);
            }
            final data = snapshot.data!;

            return Column(
              children: [
                  Container(
                    height: 70,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index){
                      final item = data[index];
                      return Padding(
                        padding: const EdgeInsets.only(top: 20, left: 8),
                        child: Container(
                          height: 60,
                          width: 120,
                          decoration: BoxDecoration(
                            color: ShopeeColors.primaryLight,
                            borderRadius: BorderRadius.circular(12)
                          ),
                          child: Center(
                            child: Text("${item.category}", style: const TextStyle(fontWeight: FontWeight.bold, color: ShopeeColors.white),),
                          ),
                        ),
                      );
                    }),
                  ),
                Container(
                  height: 670,
                  child: GridView.count(crossAxisCount: 2,
                  children: List.generate(data.length, (index){
                    final item = data[index];
                    final imageUrl = item.images.isNotEmpty
                        ? item.images[0] // 👉 lấy ảnh đầu tiên trong mảng
                        : 'https://via.placeholder.com/150';
                    return Padding(
                      padding: const EdgeInsets.only(top: 20, left: 16, right: 16),
                      child: GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>ProductDetailScreen(productData: item, url: imageUrl,)));
                        },
                        child: Container(
                          width: 200,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: ShopeeColors.white
                          ),
                          child: Stack(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Image.network(height: 100, width: 100, imageUrl),
                                    Text("${item.title}",maxLines: 2, style: const TextStyle(fontSize: 15, color: ShopeeColors.textDark),),
                                    Row(
                                      children: [
                                        Text("${item.price.toString()}", style: const TextStyle(fontSize: 20, color: ShopeeColors.primary, fontWeight: FontWeight.bold),),
                                        Icon(Icons.star, color: Colors.yellow,size: 20,)
                                      ],
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
                  ),
                ),
              ],
            );
        }
      }),
      bottomNavigationBar: Container(
        height: 70,
        child: Padding(
          padding: const EdgeInsets.only(left: 16, right: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                child: Center(child: IconButton(onPressed: (){}, icon: Icon(Icons.home,size: 40, color: ShopeeColors.textGray,))),
              ),Container(
                child: Center(child: IconButton(onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>CartScreen()));

                }, icon: Icon(Icons.shopping_cart_rounded,size: 40, color: ShopeeColors.textGray,))),
              ),Container(
                child: Center(child: IconButton(onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>UserScreen()));

                }, icon: Icon(Icons.person,size: 40, color: ShopeeColors.textGray,))),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
