class Product {
  int id;
  String title;
  String description;
  String category;
  double price;
  double discountPercentage;
  double rating;
  int stock;
  String brand;
  String sku;
  List<String> images;

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.price,
    required this.discountPercentage,
    required this.rating,
    required this.stock,
    required this.brand,
    required this.sku,
    required this.images,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json["id"] ?? 0,
      title: json["title"] ?? '',
      description: json["description"] ?? '',
      category: json["category"] ?? '',
      price: (json["price"] as num?)?.toDouble() ?? 0.0,
      discountPercentage: (json["discountPercentage"] as num?)?.toDouble() ?? 0.0,
      rating: (json["rating"] as num?)?.toDouble() ?? 0.0,
      stock: json["stock"] ?? 0,
      brand: json["brand"] ?? '',
      sku: json["sku"] ?? '',
      images: (json["images"] != null && json["images"] is List)
          ? List<String>.from(json["images"])
          : [],
    );
  }


}
