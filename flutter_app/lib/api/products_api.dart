import 'dart:convert';
import 'package:flutter_app/model/product.dart';
import 'package:http/http.dart' as http;

class ProductsApi {
  static Future<List<Product>> getUsers() async {
    const url = "https://elfasoft.com/beta/Test/mobil";
    final response = await http.get(Uri.parse(url));
    final body = json.decode(response.body);

    return body.map<Product>(Product.fromJson).toList();
  }
}
