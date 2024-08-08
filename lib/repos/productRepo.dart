import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:limeric_task/constants/urls.dart';
import 'package:limeric_task/model/productModel.dart';

class ProductRepository {
  Future<List<ProductModel>> fetchProductList(String token) async {
    final response = await http.get(
      Uri.parse(baseURL+productListURL),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> jsonResponse = json.decode(response.body);
      return jsonResponse.map((json) => ProductModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load product list');
    }
  }
}
