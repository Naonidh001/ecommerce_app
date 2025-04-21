import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shopify/utils/constants.dart';

Future<List> getAllProducts() async {
  try {
    final url = Uri.parse(Api.getAllProducts);

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      print("product fetched successful!");

      return data['products'];
    } else {
      print("Status code: ${response.statusCode}");
      print("Response: ${response.body}");
      throw Exception("Failed to login");
    }
  } catch (e) {
    print("Error: $e");
    throw Exception("Failed to login");
  }
}

Future<List> getProductWithCategory({required String category}) async {
  try {
    final url = Uri.parse(Api.getCategoryProducts + category);

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      print("product fetched successful!");

      return data['products'];
    } else {
      print("Status code: ${response.statusCode}");
      print("Response: ${response.body}");
      throw Exception("Failed to login");
    }
  } catch (e) {
    print("Error: $e");
    throw Exception("Failed to login");
  }
}

Future<List> getSuggestions() async {
  try {
    final url = Uri.parse(Api.getSuggestions);

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      return data;
    } else {
      print("Status code: ${response.statusCode}");
      print("Response: ${response.body}");
      throw Exception("Failed");
    }
  } catch (e) {
    print("Error: $e");
    throw Exception("Failed");
  }
}

Future<List<dynamic>> fetchAllCategories(List<String> categories) async {
  List<dynamic> allProducts = [];

  await Future.wait(
    categories.map((category) async {
      final products = await getProductWithCategory(category: category);
      allProducts.addAll(products);
    }),
  );

  return allProducts;
}
