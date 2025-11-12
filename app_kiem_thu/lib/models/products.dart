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
  int quantity;

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
    this.quantity = 1,
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
      quantity: 1,
    );
  }


  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "title": title,
      "description": description,
      "category": category,
      "price": price,
      "discountPercentage": discountPercentage,
      "rating": rating,
      "stock": stock,
      "brand": brand,
      "sku": sku,
      "images": images,
      "quantity": quantity,
    };
  }
}
