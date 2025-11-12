import 'dart:convert';

import 'package:app_kiem_thu/models/products.dart';
import 'package:http/http.dart' as http;
class ProductViewModel{
  final String baseUrl = "https://dummyjson.com/products";
  Future<List<Product>> getAllProduct()async{
    try{
      final response = await http.get(Uri.parse(baseUrl));
      if(response.statusCode == 200){
        final data = jsonDecode(response.body)["products"] as List;
        return data.map((item)=>Product.fromJson(item)).toList();
      }else{
        throw Exception("Faild");
      }
    }catch(e){
      throw Exception(e);
    }
  }
}