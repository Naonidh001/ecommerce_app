import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shopify/utils/constants.dart';

Future<List> getProductsCategory() async {
  try {
    final url = Uri.parse(Api.getCategory);

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      return data;
    } else {
      print("Status code: ${response.statusCode}");
      print("Response: ${response.body}");
      throw Exception("Failed to get category");
    }
  } catch (e) {
    print("Error: $e");
    throw Exception("Failed to gte category");
  }
}
