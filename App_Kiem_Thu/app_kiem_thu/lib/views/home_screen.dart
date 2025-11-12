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
  String? selectedCategory;

  Future<List<Product>> loadProduct() => productViewModel.getAllProduct();

  @override
  void initState() {
    super.initState();
    fetchProduct = loadProduct();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80),
        child: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: ShopeeColors.primary,
          title: Row(
            children: [
              Expanded(child: MyContainerTextfiled()),
              IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => CartScreen()),
                  );
                },
                icon: const Icon(
                  Icons.shopping_cart,
                  size: 30,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
      body: FutureBuilder<List<Product>>(
        future: fetchProduct,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text("${snapshot.error}"));
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("Không có sản phẩm"));
          }

          final data = snapshot.data!;
          final categories = data.map((p) => p.category).toSet().toList();
          final filteredData = selectedCategory == null
              ? data
              : data.where((p) => p.category == selectedCategory).toList();

          return Column(
            children: [
              SizedBox(
                height: 70,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    final category = categories[index];
                    final isSelected = selectedCategory == category;
                    return Padding(
                      padding: const EdgeInsets.only(top: 20, left: 8),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedCategory = isSelected ? null : category;
                          });
                        },
                        child: Container(
                          height: 60,
                          width: 120,
                          decoration: BoxDecoration(
                            color: isSelected
                                ? ShopeeColors.primary
                                : ShopeeColors.primaryLight,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Center(
                            child: Text(
                              category,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: ShopeeColors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),

              Expanded(
                child: GridView.builder(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 10,
                  ),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: 0.65,
                  ),
                  itemCount: filteredData.length,
                  itemBuilder: (context, index) {
                    final item = filteredData[index];
                    final imageUrl = item.images.isNotEmpty
                        ? item.images[0]
                        : 'https://via.placeholder.com/150';
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => ProductDetailScreen(
                              productData: item,
                              url: imageUrl,
                            ),
                          ),
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              blurRadius: 6,
                              offset: const Offset(2, 4),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(12),
                                topRight: Radius.circular(12),
                              ),
                              child: Image.network(
                                imageUrl,
                                height: 120,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                              ),
                              child: Text(
                                item.title,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: ShopeeColors.textDark,
                                ),
                              ),
                            ),
                            const SizedBox(height: 4),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                              ),
                              child: Text(
                                "${item.price}\$",
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: ShopeeColors.primary,
                                ),
                              ),
                            ),
                            const SizedBox(height: 4),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.star,
                                    color: Colors.yellow.shade700,
                                    size: 16,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    "${item.rating}",
                                    style: const TextStyle(fontSize: 14),
                                  ),
                                ],
                              ),
                            ),
                            const Spacer(),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SizedBox(
                                width: double.infinity,
                                height: 32,
                                child: ElevatedButton.icon(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: ShopeeColors.primary,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  icon: const Icon(
                                    Icons.shopping_cart_outlined,
                                    size: 18,
                                    color: ShopeeColors.white,
                                  ),
                                  label: const Text(
                                    "Thêm vào giỏ",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: ShopeeColors.white,
                                    ),
                                  ),
                                  onPressed: () {
                                    bool found = false;
                                    for (var cartItem in CartScreen.cartItems) {
                                      if (cartItem.id == item.id) {
                                        cartItem.quantity++;
                                        found = true;
                                        break;
                                      }
                                    }
                                    if (!found) {
                                      item.quantity = 1;
                                      CartScreen.cartItems.add(item);
                                    }
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          "${item.title} đã thêm vào giỏ",
                                        ),
                                        duration: const Duration(seconds: 1),
                                      ),
                                    );
                                    setState(() {});
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
      bottomNavigationBar: Container(
        height: 70,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.home, size: 40, color: ShopeeColors.textGray),
              ),
              IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => CartScreen()),
                  );
                },
                icon: Icon(
                  Icons.shopping_cart_rounded,
                  size: 40,
                  color: ShopeeColors.textGray,
                ),
              ),
              IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => UserScreen()),
                  );
                },
                icon: Icon(
                  Icons.person,
                  size: 40,
                  color: ShopeeColors.textGray,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
